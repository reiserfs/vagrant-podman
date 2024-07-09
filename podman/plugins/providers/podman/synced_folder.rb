# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

module VagrantPlugins
  module PodmanProvider
    class SyncedFolder < Vagrant.plugin("2", :synced_folder)
      def usable?(machine, raise_error=false)
        # These synced folders only work if the provider is Podman
        if machine.provider_name != :podman
          if raise_error
            raise Errors::SyncedFolderNonPodman,
              provider: machine.provider_name.to_s
          end

          return false
        end

        true
      end

      def prepare(machine, folders, _opts)
        folders.each do |id, data|
          next if data[:ignore]

          host_path  = data[:hostpath]
          guest_path = data[:guestpath]
          # Append consistency option if it exists, otherwise let it nil out
          consistency = data[:podman_consistency]
          consistency &&= ":" + consistency
          machine.provider_config.volumes << "#{host_path}:#{guest_path}#{consistency}"
        end
      end
    end
  end
end
