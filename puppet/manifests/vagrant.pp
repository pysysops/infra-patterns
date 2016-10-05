# Defaults
File { ignore => ['.svn', 'CVS', '.git'], }
Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', }

# Disable the stupid warning
if versioncmp($::puppetversion, '3.6.1') >= 0 {
  Package {
    allow_virtual => false,
  }
}

# Create a default node
node default {
  include roles::base
}

node 'prd-base-001.dc1.example.com' {
  include roles::base
}

node 'prd-cm-001.dc1.example.com' {
  include roles::cm
}

node 'prd-ci-001.dc1.example.com' {
  include roles::ci
}

node 'prd-git-001.dc1.example.com' {
  include roles::git
}

node 'prd-prx-001.dc1.example.com' {
  include roles::prx
}

node 'prd-dns-001.dc1.example.com' {
  include roles::dns
}
