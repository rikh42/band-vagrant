Vagrant::Config.run do |config|

  ###############################################
  # Share some folders from Host machine and
  # mount them on the VM
  # Format is Name of share, Path on VM, Path on Host computer to share

  ## Example Project
  config.vm.share_folder("example", "/example", "~/example", :extra => 'dmode=777,fmode=777')


  ###############################################
  # Set some custom options for better support of OSX
  # Enable Symbolic Links in some of the shared folders 
  config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/example", "1"]


  ###############################################
  # Provision the server using Chef Solo, and set the confif for the server
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "vagrant_main"
    chef.log_level = :info

    # Customise the attributes of the receipes
    chef.json.merge!( 
      {
        'mysql'   => { 'server_root_password' => '4242' },
        'php'     => { 'conf_dir' => '/etc/php5/apache2' },
        'vhosts'  => [
            { 
                "server_name"   => 'example.riffal.com',
                "document_root" => '/example/htdocs',
                "env" => {}
            }
        ]
      }
    )
  end

  ###############################################
  # Which base box to use
  config.vm.box = "ubuntu"


  ###############################################
  # Forward some ports. The values are Port on VM, Port on Host computer
  config.vm.forward_port(80, 8080)
  config.vm.forward_port(22, 2222)
  config.vm.forward_port(3306, 3306)

  ###############################################
  # Stuff we don't use, but helpful to keep a reminder in there how to do it...
  # Boot with a GUI so you can see the screen. (Default is headless)
  #config.vm.boot_mode = :gui

  # Assign this VM to a host only network IP, allowing you to access it
  # via the IP.
  ##config.vm.network "10.10.10.1"
end
