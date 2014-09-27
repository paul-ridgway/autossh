module Assh

	class Provider

		attr_accessor :hosts, :groups

		def initialize
			@hosts = {}
			@groups = {}
		end

		protected
		def add_host(group_name, host_name, host)
			puts "WARNING: Duplicate host named: #{name}. Only latest host is included" if hosts[host_name]

			@groups[group_name] = {} unless @groups.has_key?(group_name)
			@groups[group_name][host_name] = host
			hosts[host_name] = host
		end
	end

end