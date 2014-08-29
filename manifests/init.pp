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
  $enabled        = true,
  $apc_stat       = true,
  $password       = $::apc_stat_password,
  $num_files_hint = '5000',
  $ttl            = '3600',
  $shm_size       = '1024M',
  $rfc1867        = 'false',
  $user_ttl       = '0',
  $gc_ttl         = '3600',
  ) {

  class { 'apc' :
    enabled         => $enabled,
    apc_stat        => $apc_stat,
    apcdocroot      => '/var/www/sharedip',
    password        => $password,
    num_files_hint  => $num_files_hint,
    ttl             => $ttl,
    shm_size        => $shm_size,
    rfc1867         => $rfc1867,
    user_ttl        => $user_ttl,
    gc_ttl          => $gc_ttl,
  }

  file { "/var/www/cluster.${cluster}.${clusterdomain}/web/apcstat.php":
    ensure  => 'present',
    content => template('ispconfig_apc/apcstat.php.erb'),
    owner   => 'root',
    group   => 'www-data',
    mode    => '0440'
  }

}
