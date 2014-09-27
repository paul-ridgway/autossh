module Assh

	class Command

		def initialize(argv)
			@args = argv
			parse_arguments!

			@configuration = Configuration.new
			@configuration.load!('config.yml')

			@generator = Generator.new
		end

		def execute!
			if @cmd_ls
				puts "Host List".green
				@configuration.groups.each do |name, hosts|
					puts "  #{name.yellow}"
					hosts.each do |name, host|
						puts "    #{host.name.light_white} #{"-".green} #{host.address.cyan}"
					end
				end
			elsif @cmd_generate
				puts "Generating config in #{@generator.output_file}"
				generate!
				puts "Done"
			else
				generate!
				execute_default!
			end
		end

		private
		def parse_arguments!
			return unless @args.size > 0
			first_arg = @args[0].downcase
			if first_arg == 'ls'
				@cmd_ls = true
			elsif first_arg == 'generate'
				@cmd_generate = true
			end
		end

		def generate!
			#Generates up-to-date config
			@generator.run!(@configuration.hosts)
		end

		def execute_default!
			# Generates safe args and replaces assh process with ssh call
			args = @args.map{|x| x.include?(' ') ? "\"#{x}\"" : x}.join(' ')
			command = "ssh -F #{Assh::GENERATED_CONFIG} #{args}"
			exec(command)
		end

	end

end