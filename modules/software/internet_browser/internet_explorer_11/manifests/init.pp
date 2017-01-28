include chocolatey

notice('Installing Internet Explorer 11')

package { 'ie11':
  ensure   => installed,
  provider => 'chocolatey',
}