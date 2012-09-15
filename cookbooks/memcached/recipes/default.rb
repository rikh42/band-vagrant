package "memcached" do
  action :upgrade
end

package "libmemcache-dev" do
  action :upgrade
end

service "memcached" do
  action :nothing
end


template "/etc/memcached.conf" do
  source "memcached.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :user => node[:memcached][:user],
    :port => node[:memcached][:port],
    :memory => node[:memcached][:memory]
  )
  notifies :restart, resources(:service => "memcached"), :immediately
end

template "/etc/default/memcached" do
  source "memcached.default.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "memcached"), :immediately
end

