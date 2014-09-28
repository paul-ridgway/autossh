require_relative '../provider'
require 'yaml'

module Assh

	class FileProvider < Provider

		ROOT = File.expand_path('~/.autossh')

		INCLUDES_KEY = "Includes"
		HOST_KEY	 = "Host"
		HOSTS_KEY	 = "Hosts"
		GROUP_KEY	 = "Group"
		GROUPS_KEY	 = "Groups"

    def initialize(configuration)
      super(configuration)
    end

		def parse_config!(config)
			return unless config
			raise 'Unexpected config type' unless config.is_a? Hash

			groups = config.delete(GROUPS_KEY)

			if hosts = config.delete(HOSTS_KEY)
				groups << {GROUP_KEY => 'ungrouped', HOSTS_KEY => hosts}
			end
			
			groups.each { |g| parse_group!(config, g) }
		end

		private
		def parse_group!(parent_config, group)
			return unless group
			parent_config ||= {}
			name = group.delete(GROUP_KEY)
			hosts = group.delete(HOSTS_KEY)
			hosts.each { |h| parse_host!(name, parent_config.merge(group), h) }
		end

		def parse_host!(group_name, parent_config, host)
			return unless host
			parent_config ||= {}
			name = host[HOST_KEY]

			add_host(group_name, name, Host.new(parent_config.merge(host)))
		end

	end

end

Assh::Provider.register_provider!("file", Assh::FileProvider)