include chocolatey

notice('Installing python')

package { 'python':
  ensure   => installed,
  provider => 'chocolatey',
}