
# Over ride this in your VagrantFile with the hosts and paths you want
default[:vhosts] = [
    { 
        "server_name" => 'example.riffal.com',
        "document_root" => '/vagrant/htdocs',
        "env" => {"EXAMPLE" => "Example_Value"}
    }
]
