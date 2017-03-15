$user_account = 'vagrant'
# $mozilla_profile_number = 'fpi79hgq'

# file { "C:\Users\{$user_account}\AppData\Roaming\Mozilla\Firefox\Profiles\{$mozilla_profile_number}.default\places.sqlite":
#
# }

$url_path = "https://www.offensive-security.com/backtrack/exploit-db-updates"

exec { "firefox-visit-webpage":
  "{$firefox_executable_location} {$url_path}"
}