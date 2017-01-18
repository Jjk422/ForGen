  include chocolatey

  notice('Puppet module to install ruby working')

  package { 'notepadplusplus':
    ensure   => installed,
    provider => 'chocolatey',
  }