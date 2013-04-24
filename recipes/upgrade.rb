# Stop service
service 'teamcity' do
  action :stop
end

# Create backup
install_dir = node['teamcity']['install_dir']
install_path = File.join install_dir, 'TeamCity'
maintain_db_path = "#{install_path}/bin/maintainDB.sh"

execute 'Backup data' do
  command "#{maintain_db_path} backup -C -D -L -P"
  cwd '/opt'
  only_if { ::File.exists?(maintain_db_path) }
end

# Remove old installation dir
directory install_path do
  action :delete
  recursive true
end

# Run install recipe
include_recipe 'chef-teamcity-install::default'