# = Class: sendmail::params
#
# The parameters used when setting up the Sendmail MTA.
#
# == Parameters:
#
# None.
#
# == Requires:
#
# Nothing.
#
# == Sample Usage:
#
#   include ::sendmail::params
#
#
class sendmail::params {

  # Where (most of) the sendmail configuration files are kept
  $mail_settings_dir = '/etc/mail'

  # File locations
  $alias_file            = '/etc/aliases'
  $access_file           = "${mail_settings_dir}/access"
  $authinfo_file         = "${mail_settings_dir}/authinfo"
  $bitdomain_file        = "${mail_settings_dir}/bitdomain"
  $domaintable_file      = "${mail_settings_dir}/domaintable"
  $genericstable_file    = "${mail_settings_dir}/genericstable"
  $local_host_names_file = "${mail_settings_dir}/local-host-names"
  $mailertable_file      = "${mail_settings_dir}/mailertable"
  $msp_authinfo_file     = "${mail_settings_dir}/msp-authinfo"
  $relay_domains_file    = "${mail_settings_dir}/relay-domains"
  $trusted_users_file    = "${mail_settings_dir}/trusted-users"
  $userdb_file           = "${mail_settings_dir}/userdb"
  $uudomain_file         = "${mail_settings_dir}/uudomain"
  $virtusertable_file    = "${mail_settings_dir}/virtusertable"

  $sendmail_mc_file      = "${mail_settings_dir}/sendmail.mc"
  $submit_mc_file        = "${mail_settings_dir}/submit.mc"

  $package_name      = 'sendmail'
  $service_name      = 'sendmail'

  $sendmail_binary   = '/usr/sbin/sendmail'

  $configure_command = "make -C ${mail_settings_dir} all"

  $mailers = [ 'smtp', 'local' ]

  case $::osfamily {

    'Debian': {
      $auxiliary_packages = [ 'bsd-mailx', ]

      # Unfortunately the /etc/init.d/sendmail script does
      # not provide a useful status exit code on wheezy.
      $service_hasstatus = false

      $sendmail_user  = 'smmta'
      $sendmail_group = 'smmsp'

      $sendmail_mc_ostype = 'debian'
      $submit_mc_ostype   = 'debian'
      $sendmail_mc_domain = 'debian-mta'
      $submit_mc_domain   = 'debian-msp'
    }

    'RedHat': {
      $auxiliary_packages = [ 'sendmail-cf', 'mailx', ]

      $service_hasstatus = true

      $sendmail_user  = 'root'
      $sendmail_group = 'root'

      $sendmail_mc_ostype = 'linux'
      $submit_mc_ostype   = undef
      $sendmail_mc_domain = undef
      $submit_mc_domain   = undef
    }

    'FreeBSD': {
      $auxiliary_packages = []
      $sendmail_user  = 'root'
      $sendmail_group = 'wheel'

      $sendmail_mc_ostype = 'freebsd6'
      $submit_mc_ostype   = 'freebsd6'
      $sendmail_mc_domain = undef
      $submit_mc_domain   = undef
    }

    default: {
      fail("Unsupported operatingsystem ${::operatingsystem}")
    }
  }
}
