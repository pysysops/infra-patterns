# Security profile - applied to every server
class profiles::security {
  include ::profiles::security::firewall
  include ::profiles::security::users
}
