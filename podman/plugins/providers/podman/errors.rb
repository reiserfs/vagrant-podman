# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

module VagrantPlugins
  module PodmanProvider
    module Errors
      class PodmanError < Vagrant::Errors::VagrantError
        error_namespace("podman_provider.errors")
      end

      class BuildError < PodmanError
        error_key(:build_error)
      end

      class CommunicatorNonPodman < PodmanError
        error_key(:communicator_non_podman)
      end

      class ComposeLockTimeoutError < PodmanError
        error_key(:compose_lock_timeout)
      end

      class ContainerNotRunningError < PodmanError
        error_key(:not_running)
      end

      class ContainerNotCreatedError < PodmanError
        error_key(:not_created)
      end

      class PodmanComposeNotInstalledError < PodmanError
        error_key(:podman_compose_not_installed)
      end

      class ExecuteError < PodmanError
        error_key(:execute_error)
      end

      class ExecCommandRequired < PodmanError
        error_key(:exec_command_required)
      end

      class HostVMCommunicatorNotReady < PodmanError
        error_key(:host_vm_communicator_not_ready)
      end

      class ImageNotConfiguredError < PodmanError
        error_key(:podman_provider_image_not_configured)
      end

      class NfsWithoutPrivilegedError < PodmanError
        error_key(:podman_provider_nfs_without_privileged)
      end

      class NetworkAddressInvalid < PodmanError
        error_key(:network_address_invalid)
      end

      class NetworkIPAddressRequired < PodmanError
        error_key(:network_address_required)
      end

      class NetworkSubnetInvalid < PodmanError
        error_key(:network_subnet_invalid)
      end

      class NetworkInvalidOption < PodmanError
        error_key(:network_invalid_option)
      end

      class NetworkNameMissing < PodmanError
        error_key(:network_name_missing)
      end

      class NetworkNameUndefined < PodmanError
        error_key(:network_name_undefined)
      end

      class NetworkNoInterfaces < PodmanError
        error_key(:network_no_interfaces)
      end

      class PackageNotSupported < PodmanError
        error_key(:package_not_supported)
      end

      class StateNotRunning < PodmanError
        error_key(:state_not_running)
      end

      class StateStopped < PodmanError
        error_key(:state_stopped)
      end

      class SuspendNotSupported < PodmanError
        error_key(:suspend_not_supported)
      end

      class SyncedFolderNonPodman < PodmanError
        error_key(:synced_folder_non_podman)
      end

      class VagrantfileNotFound < PodmanError
        error_key(:vagrantfile_not_found)
      end
    end
  end
end
