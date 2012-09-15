include_recipe "apt"
include_recipe "memcached"

include_recipe "apache2"
include_recipe "php"
include_recipe "php::module_memcache"
include_recipe "php::module_mysql"
include_recipe "php::module_gd"
include_recipe "php::module_apc"
include_recipe "php::module_curl"
include_recipe "php::module_sqlite3"

include_recipe "phpunit"


#include_recipe "mysql::server"

# If Mysql Server install is causing problems, try this...
package "mysql-server"
package "libmysqlclient-dev"
execute "ensure mysql password is set" do
  user 'root'
  command "/usr/bin/mysql -u root -e \"UPDATE mysql.user SET password = PASSWORD('4242'); FLUSH PRIVILEGES\""
  not_if "/usr/bin/mysql -u root -p4242 -e \"FLUSH PRIVILEGES\""
end


%w{ curl }.each do |a_package|
  package a_package
end


template "xdebug.ini" do
  path "/etc/php5/apache2/conf.d/xdebug.ini"
  source "xdebug.ini.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "apache2"), :delayed
end

cookbook_file "/usr/lib/php5/20090626/xdebug.so" do
	source "xdebug.so"
	mode 0755
	owner "root"
	group "root"
end



execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :restart, resources(:service => "apache2"), :delayed
end

web_app "project" do
  template "project.conf.erb"
  notifies :restart, resources(:service => "apache2"), :delayed
end


#################################
#################################


#package "couchdb" do
#  action :upgrade
#end

#service "couchdb" do
#  action :nothing
#end

#template "local.ini" do
#  path "/etc/couchdb/local.ini"
#  source "local.ini.erb"
#  owner "couchdb"
#  group "couchdb"
##  mode 0644
#  notifies :restart, resources(:service => "couchdb"), :delayed
#end

#php_pear "mongo" do
#  action :install
#end

#template "mongodb.ini" do
#  path "/etc/php5/apache2/conf.d/mongodb.ini"
#  source "mongo.ini.erb"
#  owner "root"
#  group "root"
#  mode 0644
#  notifies :restart, resources(:service => "apache2"), :delayed
#end

#template "dbg-debugger.ini" do
#  path "/etc/php5/apache2/conf.d/dbg-debugger.ini"
#  source "dbg-debugger.ini.erb"
#  owner "root"
#  group "root"
#  mode 0644
#  notifies :restart, resources(:service => "apache2"), :delayed
#end

#cookbook_file "/usr/lib/php5/20090626/dbg-php-5.3.so" do
#  source "dbg-php-5.3.so"
#  mode 0755
#  owner "root"
#  group "root"
#end


#template "zenddebugger.ini" do
#  path "/etc/php5/apache2/conf.d/zenddebugger.ini"
#  source "zenddebugger.ini.erb"
#  owner "root"
#  group "root"
#  mode 0644
#  notifies :restart, resources(:service => "apache2"), :delayed
#end

#cookbook_file "/usr/lib/php5/20090626/ZendDebugger.so" do
#	source "ZendDebugger.so"
#	mode 0755
#	owner "root"
#	group "root"
#end


#file "/etc/php5/apache2/conf.d/dbg-debugger.ini" do
#  action :delete
##  ignore_failure true
#end

#file "/usr/lib/php5/20090626/dbg-php-5.3.so" do
#  action :delete
#  ignore_failure true
#end

