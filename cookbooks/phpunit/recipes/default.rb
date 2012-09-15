# this cookbook sets up PHPUnit

execute "Upgrade Pear" do
  command "sudo pear upgrade PEAR"
end

execute "enable auto_discover" do
  command "sudo pear config-set auto_discover 1"
end

execute "install phpunit" do
  command "sudo pear install pear.phpunit.de/PHPUnit"
  not_if  do
    File.exist?("/usr/bin/phpunit")
  end
end
