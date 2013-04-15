maintainer       "Heavy Water Software Inc."
maintainer_email "darrin@heavywater.ca"
license          "Apache 2.0"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION'))

description      "Installs/Configures graphite"

depends          "python"
depends          "apache2"
depends          "runit"
depends          "ganglia"
depends          "install_from"
depends          "silverware"

recipe           "graphite::carbon",                   "Carbon"
recipe           "graphite::default",                  "Base configuration for graphite"
recipe           "graphite::ganglia",                  "Ganglia"
recipe           "graphite::dashboard",                "Web Dashboard"
recipe           "graphite::whisper",                  "Whisper"

%w[ debian ubuntu ].each do |os|
  supports os
end

attribute "graphite/conf_dir",
  :display_name          => "",
  :description           => "",
  :default               => "/etc/graphite/"

attribute "graphite/home_dir",
  :display_name          => "",
  :description           => "",
  :default               => "/usr/local/share/graphite/"

attribute "graphite/data_dir",
  :display_name          => "",
  :description           => "",
  :default               => "/var/lib/graphite/storage/"

attribute "graphite/log_dir",
  :display_name          => "",
  :description           => "",
  :default               => "/var/log/graphite/"

attribute "graphite/pid_dir",
  :display_name          => "",
  :description           => "",
  :default               => "/var/run/graphite"

attribute "graphite/user",
  :display_name          => "",
  :description           => "",
  :default               => "www-data"

attribute "graphite/carbon/line_rcvr_addr",
  :display_name          => "",
  :description           => "",
  :default               => "127.0.0.1"

attribute "graphite/carbon/pickle_rcvr_addr",
  :display_name          => "",
  :description           => "",
  :default               => "127.0.0.1"

attribute "graphite/carbon/cache_query_addr",
  :display_name          => "",
  :description           => "",
  :default               => "127.0.0.1"

attribute "graphite/carbon/user",
  :display_name          => "",
  :description           => "",
  :default               => "www-data"

attribute "graphite/carbon/version",
  :display_name          => "",
  :description           => "",
  :default               => "0.9.7"

attribute "graphite/carbon/release_url",
  :display_name          => "",
  :description           => "",
  :default               => "http://launchpadlibrarian.net/61904798/carbon-0.9.7.tar.gz"

attribute "graphite/carbon/release_url_checksum",
  :display_name          => "",
  :description           => "",
  :default               => "ba698aca"

attribute "graphite/whisper/version",
  :display_name          => "",
  :description           => "",
  :default               => "0.9.7"

attribute "graphite/whisper/release_url",
  :display_name          => "",
  :description           => "",
  :default               => "http://launchpadlibrarian.net/61904764/whisper-0.9.7.tar.gz"

attribute "graphite/whisper/release_url_checksum",
  :display_name          => "",
  :description           => "",
  :default               => "c6272ad6"

attribute "graphite/dashboard/version",
  :display_name          => "",
  :description           => "",
  :default               => "0.9.7c"

attribute "graphite/dashboard/release_url",
  :display_name          => "",
  :description           => "",
  :default               => "http://launchpadlibrarian.net/62379635/graphite-web-0.9.7c.tar.gz"

attribute "graphite/dashboard/release_url_checksum",
  :display_name          => "",
  :description           => "",
  :default               => "a3e16265"

attribute "users/graphite/uid",
  :display_name          => "",
  :description           => "",
  :default               => "446"

attribute "groups/graphite/gid",
  :display_name          => "",
  :description           => "",
  :default               => "446"
