include chocolatey

$cmd_executable_install_path = 'C:\windows\system32'
$chrome_install_dir = 'C:\Program Files (x86)\Google\Chrome\Application'

notice('Installing google chrome')

package { 'googlechrome':
  ensure   => installed,
  provider => 'chocolatey',
}

# exec { 'exec-test':
#   command => "cmd.exe /c \"echo \'test\'\""
# }

# Need to ensure unique to each version of Windows,
# different versions may have different install locations
exec { 'google-chrome-initialize':
  # command => "$cmd_executable_install_path\\cmd.exe /c \"start chrome && taskkill /F /IM chrome.exe /T && exit 0\""
  require => Package[googlechrome],
  # command => "$cmd_executable_install_path\\cmd.exe \"\"$chrome_install_dir\\chrome.exe\"\"",
  # command => "\"$chrome_install_dir\\chrome.exe\"",
  command => 'C:\windows\system32\cmd.exe /C start "" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.google.com',
  # command => "$cmd_executable_install_path\\cmd.exe \"\"$chrome_install_dir\\chrome.exe\"\"",
  # command => "$cmd_executable_install_path\\cmd.exe",
}

exec { 'google-chrome-kill-all-processes':
  require => Exec[google-chrome-initialize],
  command => "$cmd_executable_install_path\\cmd.exe /C \"taskkill /F /IM chrome.exe /T\""
}