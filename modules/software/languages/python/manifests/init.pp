include chocolatey

notice('Installing notepad++')

package { 'notepadplusplus':
  ensure   => installed,
  provider => 'chocolatey',
}