# = Define: sendmail::mc::trust_auth_mech
#
# Add the TRUST_AUTH_MECH macro to the sendmail.mc file.
#
# == Parameters:
#
# [*trust_auth_mech*]
#   The value of the TRUST_AUTH_MECH macro to set. If this is a string it
#   is used as-is. For an array the value will be concatenated into a
#   string. Default is the resource title.
#
# == Requires:
#
# Nothing.
#
# == Sample Usage:
#
#   sendmail::mc::trust_auth_mech { 'PLAIN': }
#
define sendmail::mc::trust_auth_mech (
  $trust_auth_mech = $title,
) {
  include ::sendmail::makeall

  if is_array($trust_auth_mech) {
    # Make a string from array elements
    $mech = join(strip($trust_auth_mech), ' ')
  }
  else {
    $mech = strip($trust_auth_mech)
  }

  concat::fragment { "sendmail_mc-trust_auth_mech":
    target  => 'sendmail.mc',
    order   => '75',
    content => inline_template("TRUST_AUTH_MECH(`<%= @mech -%>')dnl\n"),
    notify  => Class['::sendmail::makeall'],
  }
}