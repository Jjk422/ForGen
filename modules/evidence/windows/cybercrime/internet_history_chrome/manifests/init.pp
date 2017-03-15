$user_account = 'vagrant'
$url_paths = ["https://www.offensive-security.com/backtrack/exploit-db-updates"]

# file { "C:\Users\{$user_account}\AppData\Roaming\Mozilla\Firefox\Profiles\{$mozilla_profile_number}.default\places.sqlite":
#
# }

# exec { "add-chrome-history":
#   command => "",
# }

file { 'add-chrome-history':
  ensure => 'present',
  path => "C:/Users/$user_account/AppData/Local/Google/Chrome/User Data/Default/History",
  content => template('evidence_windows_cybercrime_internet_history_chrome/insert_history.erb')
  # content => inline_template('evidence_windows_cybercrime_internet_history_chrome/insert_history.erb')
}