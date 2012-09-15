maintainer "Peritor GmbH"
maintainer_email "scalarium@peritor.com"
description "Installs Memcached"
version "0.1"
supports "ubuntu"

recipe "memcached::server", "Memcached server"
recipe "memcached::ruby", "Memcached Ruby client libraries"
recipe "memcached::php", "Memcached PHP client libraries"

attribute "memcached/memory",
  :display_name => "Memcached Memory",
  :description => "Memory allocated for memcached instance",
  :default => "512"

attribute "memcached/port",
  :display_name => "Memcached Port",
  :description => "Port to use for memcached instance",
  :default => "11211"

attribute "memcached/user",
  :display_name => "Memcached User",
  :description => "User to run memcached instance as",
  :default => "nobody"