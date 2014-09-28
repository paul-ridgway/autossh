require_relative '../provider'
require 'yaml'

module Assh

	class RandomProvider < Provider

    def initialize(configuration)
      super(configuration)
    end

		def parse_config!(config)
			return unless config
			raise 'Unexpected config type' unless config.is_a? Hash

        add_host('Random', 'rnd', Host.new({'Host' => 'rnd', 'HostName' => '123.1.2.3'}))
		end

	end

end

Assh::Provider.register_provider!("random", Assh::RandomProvider)