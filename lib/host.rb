require_relative 'providers/file_provider'

module Assh

	class Host

		PORT_KEY		= "Port"
		HOST_KEY		= Assh::FileProvider::HOST_KEY	
		HOSTNAME_KEY 	= "HostName"
		HOSTS_KEY		= Assh::FileProvider::HOSTS_KEY	
		GROUP_KEY		= Assh::FileProvider::GROUP_KEY	
		GROUPS_KEY		= Assh::FileProvider::GROUPS_KEY	


		attr_accessor :name, :hostname, :port

		def initialize(params)
			raise 'Unexpected params type' unless params.is_a? Hash
			@name = params.delete(HOST_KEY)
			@hostname = params.delete(HOSTNAME_KEY)
			@port = params.delete(PORT_KEY) || 22
			@params = params
		end

		def address
			"#{hostname}:#{port}"
		end

		def to_s
			"#{name} - #{hostname}:#{port}"
		end

		def to_ssh_config
			f = ""
			f << "Host #{name}\n"
			f << "  Hostname #{hostname}\n"
		    f << "  Port #{port}\n"
		    @params.each do |k,v|
		    	f << "  #{k} #{v}\n"
		    end
		    f
		end

	end

end