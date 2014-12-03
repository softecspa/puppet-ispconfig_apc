# = Class: ispconfig_apc
#
# This class install apc on ispconfig cluster node by including apc class with a path for the monitoring page.
#
# == Parameters:
#
# $password::   password used to protect access to apc.php page
#
# $enabled::    true enable apc module. Default=true
#
# $apc_stat::   if true set apc.stat=1 otherwise set apc.stat=0.
#               default=true
#
# == Actions:
#   Use the apc class to install apc extension. Push apcstat.php file to admin
#   virtualhost /var/www/cluster.$nomecluster.$dominio/web
#
# == Requires:
#   - class["apc"]
#
# == Sample Usage:
#
#   class {'ispconfig_apc':
#     enabled   => true,
#     apc_stat  => true,
#     password  => "yourpassword",
#   }
class ispconfig_apc (
  $password       = $::apc_stat_password,
  $clusterslaves  = $clusterslaves,
  ) {

  include softec_php::apc

  file { "/var/www/cluster.${cluster}.${clusterdomain}/web/apcstat.php":
    ensure  => 'present',
    content => template('ispconfig_apc/apcstat.php.erb'),
    owner   => 'root',
    group   => 'www-data',
    mode    => '0440',
    require => Class['softec_php::apc']
  }

}
