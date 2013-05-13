#
# Cookbook Name:: .
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

%w[
  chef-teamcity-install::install
  chef-teamcity-install::vcs
  chef-teamcity-install::ssh
].each do |r|
  include_recipe r
end
