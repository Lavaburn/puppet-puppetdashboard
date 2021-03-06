# This configures the Puppet Dashboard on an apache web server
# using the puppetlans Apache module
class puppetdashboard::site::apache (
  $docroot          = $puppetdashboard::params::docroot,
  $port             = $puppetdashboard::params::apache_port,
  $servername       = $::fqdn,
  $error_log_file   = $puppetdashboard::params::error_log_file,
  $access_log_file  = $puppetdashboard::params::access_log_file
) inherits puppetdashboard::params {

  apache::vhost { 'puppet-dashboard':
    servername      => $servername,
    port            => $port,
    docroot         => $docroot,
    directories     => [
      {
        path              => $docroot,
        passenger_enabled => 'on',
      },
    ],
    custom_fragment => 'RailsBaseURI /',
    error_log_file  => $error_log_file,
    access_log_file => $access_log_file,
  }

}