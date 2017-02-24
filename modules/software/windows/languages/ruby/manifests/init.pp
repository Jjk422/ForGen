# include ruby::install::install
include chocolatey

notice('Installing ruby')

package { 'ruby':
  ensure   => installed,
  provider => 'chocolatey',
}