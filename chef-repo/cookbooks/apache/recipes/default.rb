#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

#package 'httpd'
package node['apache']['package_name']

apache_vhost node['apache']['site_name'] do
  site_name node['apache']['site_name']
  action :remove
  notifies :restart, node['apache']['service_resource']
end

apache_vhost 'users' do
  notifies :restart, node['apache']['service_resource']
end

apache_vhost 'admins' do
  site_port 8080
  notifies :restart, node['apache']['service_resource']
end

service node['apache']['service_name'] do
  action [:enable, :start]
end

chef_gem 'vault' do
  compile_time true
end
require 'vault'
Vault.configure do |config|
  # The address of the Vault server
  config.address = 'http://44.201.43.68:8200/'
  # The token to authenticate with Vault
  config.token = ''
end
creds = Vault.kv('secret').read('password')
user 'WebAdmin' do
  comment 'Web Admin'
  uid 2000
  home '/home/WebAdmin'
  shell '/bin/bash'
  manage_home true
  password creds.data[:password]
end
