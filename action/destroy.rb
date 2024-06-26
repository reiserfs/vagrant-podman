# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

module VagrantPlugins
  module PodmanProvider
    module Action
      class Destroy
        def initialize(app, env)
          @app = app
        end

        def call(env)
          env[:ui].info I18n.t("podman_provider.messages.destroying")

          machine = env[:machine]
          driver  = machine.provider.driver

          # If we have a build image, store that
          image_file = machine.data_dir.join("podman_build_image")
          image      = nil
          if image_file.file?
            image = image_file.read.chomp
          end
          env[:build_image] = image

          driver.rm(machine.id)
          machine.id = nil

          @app.call(env)
        end
      end
    end
  end
end
