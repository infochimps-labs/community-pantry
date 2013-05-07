#
# PhantomJS user
#

default[:phantomjs][:user]                    = 'phantomjs'
default[:users ]['phantomjs'][:uid]           = 448
default[:groups]['phantomjs'][:gid]           = 448

#
# PhantomJS deploy
#

default[:phantomjs][:deploy_root]             = '/usr/local/share'
default[:phantomjs][:home_dir]                = '/usr/local/share/phantomjs'
default[:phantomjs][:repo]                    = 'git://github.com/ariya/phantomjs'
default[:phantomjs][:branch]                  = '1.4'

#
# PhantomJS scraper deploy
#

default[:phantomjs][:scraper][:home_dir]      = "/usr/local/share/phantomjs_scraper"
default[:phantomjs][:scraper][:log_dir]       = "/var/log/phantomjs_scraper"
# Set in recipe using 'volume_dirs'
# default[:phantomjs][:scraper][:data_dir]      = nil
default[:phantomjs][:scraper][:phanta]        = 1
default[:phantomjs][:scraper][:options]       = '--load-images=no --load-plugins=no'

default[:tuning][:ulimit]['phantomjs'] = { :nofile => { :both => 32768 }}
