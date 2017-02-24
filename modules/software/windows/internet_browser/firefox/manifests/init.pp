include chocolatey

notice('Installing Firefox')

package { 'firefox':
  ensure   => installed,
  provider => 'chocolatey',
}