# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

module VagrantPlugins
  module PodmanProvider
    autoload :Action, File.expand_path("../action", __FILE__)
    autoload :Driver, File.expand_path("../driver", __FILE__)
    autoload :Errors, File.expand_path("../errors", __FILE__)

    module Executor
      autoload :Local, File.expand_path("../executor/local", __FILE__)
      autoload :Vagrant, File.expand_path("../executor/vagrant", __FILE__)
    end

    class Plugin < Vagrant.plugin("2")
      name "podman-provider"
      description <<-EOF
      The Podman provider allows Vagrant to manage and control
      Podman containers.
      EOF

      provider(:podman, box_optional: true, parallel: true, defaultable: false) do
        require_relative 'provider'
        init!
        Provider
      end

      command("podman-exec", primary: false) do
        require_relative "command/exec"
        init!
        Command::Exec
      end

      command("podman-logs", primary: false) do
        require_relative "command/logs"
        init!
        Command::Logs
      end

      command("podman-run", primary: false) do
        require_relative "command/run"
        init!
        Command::Run
      end

      communicator(:podman_hostvm) do
        require_relative "communicator"
        init!
        Communicator
      end

      config(:podman, :provider) do
        require_relative 'config'
        init!
        Config
      end

      synced_folder(:podman) do
        require File.expand_path("../synced_folder", __FILE__)
        SyncedFolder
      end

      provider_capability("podman", "public_address") do
        require_relative "cap/public_address"
        Cap::PublicAddress
      end

      provider_capability("podman", "proxy_machine") do
        require_relative "cap/proxy_machine"
        Cap::ProxyMachine
      end

      provider_capability("podman", "has_communicator") do
        require_relative "cap/has_communicator"
        Cap::HasCommunicator
      end

      protected

      def self.init!
        return if defined?(@_init)
        I18n.load_path << File.expand_path(
          "templates/locales/providers_podman.yml", Vagrant.source_root)
        I18n.reload!
        @_init = true
      end
    end
  end
end
