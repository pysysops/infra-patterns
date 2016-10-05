# Defaults
File { ignore => ['.svn', 'CVS', '.git'] }
Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', }

# Disable the stupid warning
if versioncmp($::puppetversion, '3.6.1') >= 0 {
  Package {
    allow_virtual => false,
  }
}

# Create a default node for all servers
node default {
  # Everything gets this class, no matter what
  # Ensures boxes are secure and in the environment properly
  include roles::base
}
