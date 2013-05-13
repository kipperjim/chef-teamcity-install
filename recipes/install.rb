#
# Cookbook Name:: chef-teamcity-install
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

teamcity_user = node['teamcity']['user']['name']
version = node['teamcity']['version']
install_dir = node['teamcity']['install_dir']
install_path = File.join install_dir, 'TeamCity'
data_path = node['teamcity']['data_path']

# Install Java
node.default['java']['oracle']['accept_oracle_download_terms'] = true
include_recipe 'java::oracle'

# Create user
user teamcity_user do
  comment 'User running TeamCity'
  shell '/bin/bash'
  home "/home/#{teamcity_user}"
  supports :manage_home => true
end

# Download Teamcity
download_path = File.join install_dir, "TeamCity-#{version}.tar.gz"

remote_file download_path do
  source "http://download.jetbrains.com/teamcity/TeamCity-#{version}.tar.gz"
  action :create_if_missing
  owner teamcity_user
  group teamcity_user
end

# Unpack
execute 'Unpack package' do
  command "tar -xvzf #{download_path} --directory \"#{install_dir}\""
  creates install_path
  user teamcity_user
  group teamcity_user
end

# Install as a service
template '/etc/init.d/teamcity' do
  source 'teamcity_service_script.sh.erb'
  variables(
      :teamcity_data_path => data_path,
      :teamcity_path => install_path,
      :user => teamcity_user
  )
  owner 'root'
  group 'root'
  mode 0755
end

# Start service
service 'teamcity' do
  supports :status => true
  action [:enable, :start]
end
