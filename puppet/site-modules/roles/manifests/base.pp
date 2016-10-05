# base role - os, security, packages, system files
class roles::base {
  include ::profiles::base
  include ::profiles::security
}
