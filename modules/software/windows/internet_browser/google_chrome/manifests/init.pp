include chocolatey

notice('Installing google chrome')

package { 'googlechrome':
  ensure   => installed,
  provider => 'chocolatey',
}