# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

module VagrantPlugins
  module PodmanProvider
    module Action
      class Start
        def initialize(app, env)
          @app = app
        end

        def call(env)
          machine = env[:machine]
          driver  = machine.provider.driver

          machine.ui.output(I18n.t("podman_provider.messages.starting"))
          driver.start(machine.id)

          @app.call(env)
        end
      end
    end
  end
end
