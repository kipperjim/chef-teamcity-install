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
version = '7.1.4'
download_path = "/opt/TeamCity-#{version}.tar.gz"
remote_file download_path do
  source "http://download.jetbrains.com/teamcity/TeamCity-#{version}.tar.gz"
  action :create_if_missing
end

# Unpack
install_path = "/opt/TeamCity"
execute 'Unpack package' do
  command "tar -xvzf #{download_path} --directory /opt"
  creates install_path
end

# Install and start service
service 'teamcity' do
  supports :start => true, :stop => true
  action :nothing
end

template '/etc/init.d/teamcity' do
  source 'service_script.sh'
  variables(
      :teamcity_data_path => '/var/TeamCity/.BuildServer',
      :teamcity_path => install_path
  )
  owner 'root'
  group 'root'
  mode 0755
  notifies :enable, 'service[teamcity]'
  notifies :start, 'service[teamcity]'
end
