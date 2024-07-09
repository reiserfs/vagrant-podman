# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

require "log4r"

module VagrantPlugins
  module PodmanProvider
    module Action
      class DestroyBuildImage
        def initialize(app, env)
          @app = app
          @logger = Log4r::Logger.new("vagrant::podman::destroybuildimage")
        end

        def call(env)
          machine = env[:machine]
          image   = env[:build_image]
          image_file = nil

          if !image
            # Try to read the image ID from the cache file if we've
            # already built it.
            image_file = machine.data_dir.join("podman_build_image")
            image      = nil
            if image_file.file?
              image = image_file.read.chomp
            end
          end

          if image
            machine.ui.output(I18n.t("podman_provider.build_image_destroy"))
            if !machine.provider.driver.rmi(image)
              machine.ui.detail(I18n.t(
                "podman_provider.build_image_destroy_in_use"))
            end
          end

          if image_file && image_file.file?
            begin
              image_file.delete
            rescue Errno::ENOENT
              # Its okay
            end
          end

          @app.call(env)
        end
      end
    end
  end
end
