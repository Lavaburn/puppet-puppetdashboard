# This is the puppetdashboard parameters class that holds
# all the top level variables for the puppetdashboard module
class puppetdashboard::params {

  # OS independent variables
  $package                  = 'puppet-dashboard'
  $db_user                  = 'puppetdashboard'
  $db_name                  = 'puppetdashboard'
  $db_adapter               = 'mysql'
  $install_dir              = '/usr/share/puppet-dashboard'
  $config_dir               = "${install_dir}/config"
  $cn_name                  = 'dashboard'
  $ca_server                = 'puppet'
  $ca_crl_path              = 'certs/dashboard.ca_crl.pem'
  $ca_certificate_path      = 'certs/dashboard.ca_cert.pem'
  $certificate_path         = 'certs/dashboard.cert.pem'
  $private_key_path         = 'certs/dashboard.private_key.pem'
  $public_key_path          = 'certs/dashboard.public_key.pem'
  $inventory_server_port    = '8140'
  $file_bucket_server_port  = '8140'
  $docroot                  = '/usr/share/puppet-dashboard/public'
  $error_log_file           = "dashboard.${::fqdn}_error.log"
  $access_log_file          = "dashboard.${::fqdn}_access.log"
  $apache_user              = $::apache::user
  $apache_group             = $::apache::group
  $apache_port              = '80'
  $repo_url                 = 'https://github.com/sodabrew/puppet-dashboard.git'
  $repo_ref                 = '2.0.0-beta2'

  case $::osfamily {
    'Debian':{
      $ruby_bin         = '/usr/bin/ruby'
      case $::operatingsystem {
        'Ubuntu': {
          case $::lsbdistcodename {
            'trusty': {
              $gem_dependencies = [
                'libpq-dev',
                'openssl'
              ]
            }
            default: {
              $gem_dependencies = [
                'libpq-dev',
                'passenger-common1.9.1',
                'openssl'
              ]
            }
          }
        }
        default: {
          $gem_dependencies = [
            'libpq-dev',
            'passenger-common1.9.1',
            'openssl'
          ]
        }
      }
    }
    default: {
      fail("The NeSI Puppet Dashboard Puppet module does not support ${::osfamily} family of operating systems")
    }
  }
}
