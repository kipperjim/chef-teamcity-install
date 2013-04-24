#
# Cookbook Name:: chef-teamcity-install
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

# Install Java
include_recipe 'java::oracle'

# Download Teamcity
version = node['teamcity']['version']
install_dir = node['teamcity']['install_dir']
download_path = File.join install_dir, "TeamCity-#{version}.tar.gz"

remote_file download_path do
  source "http://download.jetbrains.com/teamcity/TeamCity-#{version}.tar.gz"
  action :create_if_missing
end

# Unpack
install_path = File.join install_dir, 'TeamCity'

execute 'Unpack package' do
  command "tar -xvzf #{download_path} --directory \"#{install_dir}\""
  creates install_path
end

# Install as a service
data_path = node['teamcity']['data_path']

template '/etc/init.d/teamcity' do
  source 'service_script.sh'
  variables(
      :teamcity_data_path => data_path,
      :teamcity_path => install_path
  )
  owner 'root'
  group 'root'
  mode 0755
end

# Start service
service 'teamcity' do
  action [:enable, :start]
end
