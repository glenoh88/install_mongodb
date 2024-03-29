#
# Cookbook Name:: install_mongodb
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

#import key
execute 'import key' do
  command 'apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10'
end

#create list file
file '/etc/apt/sources.list.d/mongodb-org-3.0.list' do
  content 'deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse'
  mode '0755'
end

#Update apt-get
execute 'Update apt-get' do
  command 'apt-get update'
end

#install mongodb
execute 'install mongodb' do
  command 'apt-get install -y mongodb-org'
end

#enable and start mongodb
service 'mongod' do
  supports :status => true
  action [:enable, :start]
end

#pin mongod db version
execute 'pin mongodb' do
  command 'echo "mongodb-org hold" | sudo dpkg --set-selections'
end
