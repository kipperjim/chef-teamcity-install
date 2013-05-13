#
# Cookbook Name:: .
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

%w[
  chef-teamcity-install::vcs
  chef-teamcity-install::ssh
  chef-teamcity-install::install
].each do |r|
  include_recipe r
end
