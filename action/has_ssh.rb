# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

module VagrantPlugins
  module PodmanProvider
    module Action
      # This middleware is used with Call to test if this machine supports
      # SSH.
      class HasSSH
        def initialize(app, env)
          @app    = app
        end

        def call(env)
          env[:result] = env[:machine].provider_config.has_ssh
          @app.call(env)
        end
      end
    end
  end
end
