# Vagrant Podman Provider README

I rewrite the original docker provider to use podman on

You can use the original docker provider with podman instaled, because the "Docker CLI Emulator" script, but you can not create networks in podman since the network inspect format is different from podman to docker.

```
docker inspect vagrant
[
    {
        "Name": "vagrant",
        "Id": "2e6833f339f44e007be05c2642b1b52b3d9d51a02172db06583dd47310cc6674",
        "Created": "2024-06-13T21:35:50.962805837+01:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "192.168.200.0/24",
                    "Gateway": "192.168.200.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {},
        "Labels": {}
    }
]
```
```
podman network inspect vagrant
[
     {
          "name": "vagrant",
          "id": "b0931bc45f398733349554eeeca4c584f22eee0abfb2f1aa579b2e00506fdb8f",
          "driver": "bridge",
          "network_interface": "podman7",
          "created": "2024-06-17T10:07:30.267513349+01:00",
          "subnets": [
               {
                    "subnet": "192.168.200.0/24",
                    "gateway": "192.168.200.1"
               }
          ],
          "ipv6_enabled": false,
          "internal": false,
          "dns_enabled": true,
          "ipam_options": {
               "driver": "host-local"
          }
     }
]
```

This guide is intended to explain how the Podman provider functions within Vagrant, allowing you to manage and control Podman containers effectively in a Vagrant environment.

## Create network if not exist
The docker plugin have a function to create the network, if not exist, but is never used since the funcion validate_network_name!(root_options[:name], env) will return an exception in case the network was not created before. 

So i removed this check in the process_private_network and process_public_network functions to the drive create the network in case not exist.

There was also a problem with the process_private_network and process_public_network functions not returning the network_options[:subnet] options so the drive create the network but do not find it to use with the VM.

## New features
I also added support for more podman commands, that was missing in the docker provider.
```
    --network
    --user
    --userns
```
## Docker provider MOD
In this repo there is a mod for the docker provider including some updates i made to the podman provider, like create network if not exist 

## Overview

The Vagrant Podman Provider enables Vagrant to manage containers in Podman instead of traditional virtual machines. With Podman being a daemonless container engine, it offers a Docker-compatible command line that allows for easy migration of Docker workflows to Podman. This provider leverages Podman to offer a lightweight and more secure way to handle container management in development environments.

## Getting Started with Vagrant Podman Provider

To begin using the Vagrant Podman Provider, you will first need to ensure that Podman is installed on your system. Vagrant interacts with Podman through the Podman command line, mirroring actions that you might perform with Docker but using Podman's tools instead.

##

### Installation

1. **Install Podman**: Follow the official Podman installation guides to get Podman running on your system: [Install Podman](https://podman.io/getting-started/installation)

2. **Install Vagrant**: If you haven’t already installed Vagrant, download and install it from [Vagrant Downloads](https://www.vagrantup.com/downloads.html).

3. **Install Vagrant Podman Provider**: As of now, Vagrant does not include a native Podman provider. If a community plugin is available, it can be installed using Vagrant's plugin system:

    ```
    vagrant plugin install podman
    ```

### Configuring Your Vagrantfile

Here’s a basic example of how to configure your Vagrant environment to use Podman:

```ruby
Vagrant.configure("2") do |config|
    config.vm.provider "podman" do |podman|
    podman.image = "fedora:latest"
    podman.has_ssh = true
    end

    config.vm.provision "shell", inline: <<-SHELL
    echo "Hello, Podman!"
    SHELL
end
```

In this example, Vagrant will pull the latest Fedora container image and provision it with a simple shell script.

## Usage

The Vagrant Podman Provider supports various commands that you are familiar with from other Vagrant environments:

- **`vagrant up`**: This command is used to start the containers.
- **`vagrant halt`**: Stops the Podman containers.
- **`vagrant destroy`**: Removes the containers entirely.
- **`vagrant ssh`**: Connects to the container via SSH if SSH is configured.

## Advanced Configuration

The Vagrant Podman Provider allows for detailed configuration to tweak container settings such as mounting volumes, port forwarding, and more.

```ruby
config.vm.provider "podman" do |podman|
    podman.image = "ubuntu:latest"
    podman.ports = ["80:80"]
    podman.volumes = ["/host/path:/container/path"]
end
```

## Limitations and Considerations

While the Vagrant Podman Provider mimics much of the functionality of the Docker provider, there may be some differences due to the underlying differences between Docker and Podman. It is important to test and ensure your specific use cases work as expected.

## Conclusion

The Vagrant Podman Provider is a powerful tool for developers looking to use Podman containers within their Vagrant workflows. It provides a familiar interface for those who are accustomed to Docker but prefer or require the use of Podman due to its daemonless architecture and enhanced security features.

For more detailed information and latest updates, please refer to the official [Vagrant documentation](https://www.vagrantup.com/docs) and the [Podman website](https://podman.io/).
