maintainer        "Dhruv Bansal"
maintainer_email  "dhruv@infochimps.com"
license           "Apache 2.0"
description       "Provides collectd installation and configuration"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION'))

supports "ubuntu",   ">= 10.04"
supports "debian",   ">= 6.0"

recipe "collectd::default",               "Does nothing."
recipe "collectd::configure",             "Installs collectd configuration files"
recipe "collectd::install_from_package",  "Installs collectd from package"
recipe "collectd::compile",               "Installs and compiles collectd from source"

depends "silverware"
depends "runit"
depends "git"
