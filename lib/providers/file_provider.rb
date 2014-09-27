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

		def load!(file)
			parse_config!(YAML::load_file(File.expand_path(file, ROOT)))
		end

		private
		def parse_config!(config)
			return unless config
			raise 'Unexpected config type' unless config.is_a? Hash
			includes = config.delete(INCLUDES_KEY)
			includes.each do |inc|
				config.merge!(YAML::load_file(File.expand_path(inc, ROOT))) do |key, old_value, new_value|
					if old_value.is_a? Array
						old_value + new_value
					else
						new_value
					end
				end
			end

			groups = config.delete(GROUPS_KEY)

			if hosts = config.delete(HOSTS_KEY)
				groups << {GROUP_KEY => 'ungrouped', HOSTS_KEY => hosts}
			end
			
			groups.each { |g| parse_group!(config, g) }
		end

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

			host = Host.new(parent_config.merge(host))

			add_host(group_name, name, host)
		end

	end

end