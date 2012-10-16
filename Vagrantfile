Vagrant::Config.run do |config|

  ###############################################
  # Share some folders from Host machine and
  # mount them on the VM
  # Format is Name of share, Path on VM, Path on Host computer to share

  ## Normal Band Dev
  config.vm.share_folder("band", "/band", "../../band/band-framework", :extra => 'dmode=777,fmode=777')

  ## Rikheywood.co.uk
  config.vm.share_folder "rik", "/rik", "../../clients/rikheywood", :extra => 'dmode=777,fmode=777'


  ###############################################
  # Set some custom options for better support of OSX
  # Enable Symbolic Links in some of the shared folders 
  config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/band", "1"]
  config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/rik", "1"]


  ###############################################
  # Provision the server using Chef Solo, and set the confif for the server
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "vagrant_main"
    chef.log_level = :info

    # Customise the attributes of the receipes
    chef.json.merge!( 
      {
  		  'mysql' => { 'server_root_password' => '4242' },
  		  'php'   => { 'conf_dir' => '/etc/php5/apache2' },
        'vhosts' => [
            { 
              "server_name" => 'band.riffal.com',
              "document_root" => '/band/htdocs',
              "server_name" => 'example.riffal.com',
              "document_root" => '/example/htdocs',
              "env" => {}
            },
            { 
              "server_name" => 'rik.riffal.com',
              "document_root" => '/rik/htdocs',
              "env" => {'BAND_ENV'=>'dev', 'POSTMARKAPP_API_KEY'=>'300fd23f-39a5-4d8b-bc20-5a855a0d9209'}
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
