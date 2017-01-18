class init () {
  # include ruby::install::install

  include chocolatey

  notice('Puppet module to install ruby working')

  package { 'ruby':
    ensure   => installed,
    provider => 'chocolatey',
  }
}