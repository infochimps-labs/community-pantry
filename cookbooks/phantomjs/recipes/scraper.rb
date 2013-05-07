daemon_user(:phantomjs) do
  comment       "PhantomJS daemon"
  home          "/nonexistent"
  shell         "/bin/false"
end

#
# Use node's own volume directories.
#

standard_dirs('phantomjs.scraper') do
  directories :home_dir, :log_dir
end

volume_dirs('phantomjs.scraper.data') do
  type          :persistent
  selects       :single
end

#
# Input -- make sure the input FIFO exists.
#
node.phantomjs.scraper.phanta.times do |index|
  fifo = File.join(node.phantomjs.scraper.data_dir, "fifo_#{index}")
  case
  when File.exist?(fifo) && File.ftype(fifo) != 'fifo'
    Chef::Log.warn("A file exists at #{fifo} but it's not a FIFO, it's a #{File.ftype(fifo)}")
  when (!File.exist?(fifo))
    bash "Create PhantomJS scraper input FIFO at #{fifo}" do
      code    "mkfifo #{fifo} && chown #{node[:users]['phantomjs'][:uid]}:#{node[:groups]['phantomjs'][:gid]} #{fifo} && chmod 662 #{fifo}"
      creates fifo
    end
  else
    # fifo exists, do nothing
  end
end

#
# Drop the script.
#

scraper_script = File.join(node.phantomjs.scraper.home_dir, 'scraper.js')
template scraper_script do
  source 'scraper.js.erb'
  action :create
  mode   '0644'
end

#
# Spawn the phanta.
#
node.phantomjs.scraper.phanta.times do |index|
  output_path = File.join(node.phantomjs.scraper.data_dir, "phantomjs_scraper_#{index}.json")
  runit_service "phantomjs_scraper_#{index}" do
    template_name "phantomjs_scraper"
    options({
              :args    => node.phantomjs.scraper.options,
              :script  => scraper_script,
              :fifo    => File.join(node.phantomjs.scraper.data_dir, "fifo_#{index}"),
              :output  => output_path
            })
  end
end

#
# Announce
#

announce(:phantomjs, :scraper, {
           :logs    => { :sv => File.join(node.phantomjs.scraper.log_dir, 'current') },
           :daemons => {
             :phantomjs_scraper => {
               :name   => 'phantomjs',
               :number => node.phantomjs.scraper.phanta
             }
           }})
