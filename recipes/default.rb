#
# Cookbook Name:: jdk
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe "chef-yum-docker"

remote_file '/tmp/jdk-8u101-linux-x64.rpm' do
  source 'http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.rpm'
  headers({ "Cookie" => "gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" })
  action :create
end

package '/tmp/jdk-8u101-linux-x64.rpm' do # no need to do interpolation here, we just need the name
  source "/tmp/jdk-8u101-linux-x64.rpm" # Here we have to concatenate path and name
  action :install # do nothing, just define the resource
end

yum_package 'docker-engine' do
  action :upgrade
end

# Create docker group for docker deamon
group 'docker' do
  action :default
end
