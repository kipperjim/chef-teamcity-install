# Stop service
service 'teamcity' do
  action :stop
end

teamcity_user = node['teamcity']['user']['name']
install_dir = node['teamcity']['install_dir']
install_path = File.join install_dir, 'TeamCity'
java_home = node['teamcity']['java_home']

# Create backup
maintain_db_path = "#{install_path}/bin/maintainDB.sh"

ENV['JAVA_HOME'] = java_home
execute 'Backup data' do
  command "#{maintain_db_path} backup -C -D -L -P"
  cwd install_dir
  only_if { ::File.exists?(maintain_db_path) }
  user teamcity_user
end

# Remove old installation dir
directory install_path do
  action :delete
  recursive true
end

# Run install recipe
include_recipe 'chef-teamcity-vagrant::teamcity'