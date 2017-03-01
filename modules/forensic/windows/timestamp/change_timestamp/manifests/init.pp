$file = 'test'
$file_path = 'c:\test.txt'
# $time_type values = ['creationtime', 'lastaccesstime', 'lastwritetime' ]
$time_type = 'creationtime'
# $time values = 'mm/dd/yyyy hh:mm am/pm'
$time = '11/24/2015 06:00 am'

file { "create-file-${file}":
  path => $file_path,
  ensure => 'present'
}

# command => "Start-Process powershell.exe \"-NoProfile -ExecutionPolicy Bypass \"$(Get-Item ${file_path}).${time_type}=$(Get-Date \"${time}\")\" -Verb RunAs;exit",

exec { "change-timestamp-${file}":
  require => File["create-file-${file}"],
  command => "powershell.exe \"-NoProfile -ExecutionPolicy Bypass -command \"$(Get-Item ${file_path}).${time_type}=$(Get-Date \"${time}\")\"",
  provider => powershell,
  logoutput => false
}