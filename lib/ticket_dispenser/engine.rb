# frozen_string_literal: true

module TicketDispenser
  class Engine < ::Rails::Engine
    isolate_namespace TicketDispenser

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot # newly added code
      g.factory_bot dir: 'spec/factories' # newly added code
    end
  end
end
