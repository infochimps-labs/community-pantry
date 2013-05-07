case node[:platform]
when "ubuntu","debian"
  %w{ libqt4-dev libqtwebkit-dev qt4-qmake }.each do |pck|
    package "#{pck}" do
      action :install
    end
  end
when "centos"
  log "No centos Support yet"
end

standard_dirs(:phantomjs) do
  directories :deploy_root       # git will create the home_dir below
end

git node.phantomjs.home_dir do
  repository        node.phantomjs.repo
  reference         node.phantomjs.branch
  action            :checkout
  enable_submodules true
  notifies          :run, "bash[compile_phantomjs_source]", :immediately
end

bash "compile_phantomjs_source" do
  cwd    node.phantomjs.home_dir
  action :nothing
  code   "qmake-qt4 && make"
end

link "/usr/local/bin/phantomjs" do
  to File.join(node.phantomjs.home_dir, 'bin/phantomjs')
end
