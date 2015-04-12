# = Class: sendmail::aliases::file
#
# Create the Sendmail aliases file.
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
#   class { 'sendmail::aliases::file': }
#
#
class sendmail::aliases::file {
  include ::sendmail::params

  file { $::sendmail::params::alias_file:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
}
