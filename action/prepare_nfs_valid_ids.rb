# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

module VagrantPlugins
  module PodmanProvider
    module Action
      class PrepareNFSValidIds
        def initialize(app, env)
          @app = app
          @logger = Log4r::Logger.new("vagrant::action::vm::nfs")
        end

        def call(env)
          machine = env[:machine]
          env[:nfs_valid_ids] = machine.provider.driver.all_containers

          @app.call(env)
        end
      end
    end
  end
end
