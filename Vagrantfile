Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu"

  config.vm.forward_port(80, 8080)
  config.vm.forward_port(22, 2222)
  config.vm.forward_port(3306, 3306)

  ## Normal Band Dev
  config.vm.share_folder("band", "/band", "../../band/band-framework", :extra => 'dmode=777,fmode=777')

  ## Rikheywood.co.uk
  config.vm.share_folder "rik", "/rik", "../../clients/rikheywood", :extra => 'dmode=777,fmode=777'

  ## Test Project
  #config.vm.share_folder "test", "/test", "../../packages/band-docs", :extra => 'dmode=777,fmode=777'
  #config.vm.share_folder "test", "/test", "../../packages/mpx", :extra => 'dmode=777,fmode=777'
  #config.vm.share_folder "test", "/test", "../../symfony", :extra => 'dmode=777,fmode=777'
  config.vm.share_folder "test", "/test", "../../sym", :extra => 'dmode=777,fmode=777'
  
  # Boot with a GUI so you can see the screen. (Default is headless)
  #config.vm.boot_mode = :gui

  # Assign this VM to a host only network IP, allowing you to access it
  # via the IP.
  ##config.vm.network "10.10.10.1"

  # Enable provisioning with chef solo, specifying a cookbooks path (relative
  # to this Vagrantfile), and adding some recipes and/or roles.
  #
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
end
