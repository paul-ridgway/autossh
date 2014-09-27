require 'pp'

module Assh

	class Command

		def initialize(argv)
			@args = argv
			parse_arguments!
		end

		def execute!
			if @cmd_ls
				puts 'ls'
			else
				puts 'default'
			end
		end

		private
		def parse_arguments!
			return unless @args.size > 0
			first_arg = @args[0].downcase
			if first_arg == 'ls'
				@cmd_ls = true
			end
		end

	end

end