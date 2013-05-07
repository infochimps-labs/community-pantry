maintainer        "Dhruv Bansal"
maintainer_email  "dhruv@infochimps.com"
license           "Apache 2.0"
description       "Installs/Configures PhantomJS and scraper processes."
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION'))

supports "ubuntu",   ">= 10.04"
supports "debian",   ">= 6.0"

depends "silverware"
depends "git"
depends "volumes"

recipe "phantomjs::default", "Install PhantomJS."
recipe "phantomjs::scraper", "Install PhantomJS scraper daemon processes."

attribute "phantoms/user",
  :display_name          => "",
  :description           => "The PhantomJS daemon user.",
  :default               => "phantomjs"

attribute "users/phantomjs/uid",
  :display_name          => "",
  :description           => "The uid of the PhantomJS daemon user.",
  :default               => "448"

attribute "groups/phantomjs/gid",
  :display_name          => "",
  :description           => "The gid of the PhantomJS daemon group.",
  :default               => "448"

attribute "phantomjs/deploy_root",
  :display_name          => "",
  :description           => "The deploy root directory for the installation of PhantomJS.",
  :default               => "/usr/local/share"

attribute "phantomjs/home_dir",
  :display_name          => "",
  :description           => "The base installation directory for PhantomJS.",
  :default               => "/usr/local/share/phantomjs"

attribute "phantomjs/repo",
  :display_name          => "",
  :description           => "The URL of the Git repository for PhantomJS.",
  :default               => "git://github.com/ariya/phantomjs"

attribute "phantomjs/branch",
  :display_name          => "",
  :description           => "The branch of PhantomJS to checkout.",
  :default               => "1.4"


attribute "phantomjs/scraper/home_dir",
  :display_name          => "",
  :description           => "The base installation directory for the PhantomJS scraper.",
  :default               => "/usr/local/share/phantomjs_scraper"

attribute "phantomjs/scraper/log_dir",
  :display_name          => "",
  :description           => "The log directory for PhantomJS scrapers.",
  :default               => "/var/log/phantomjs_scraper"

attribute "phantomjs/scraper/data_dir",
  :display_name          => "",
  :description           => "The data directory for PhantomJS scrapers.",
  :default               => nil

attribute "phantomjs/scraper/phanta",
  :display_name          => "",
  :description           => "The number of PhantomJS scraper processes to launch.",
  :default               => '1'

attribute "phantomjs/scraper/options",
  :display_name          => "",
  :description           => "Command line options for PhantomJS when launching scrapers.",
  :default               => '--load-images=no --load-plugins=no'
