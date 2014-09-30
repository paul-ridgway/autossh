
module Assh
	class Generator

		attr_accessor :output_file

		def initialize(output_file = File.expand_path(Assh::GENERATED_CONFIG),
                   timestamp_file = File.expand_path(Assh::GENERATED_AT))
			@output_file = output_file
      @timestamp_file = timestamp_file
		end

		def run!(hosts)
			File.open(@output_file, 'w') do |f|
				hosts.each do |_, host|
					f << host.to_ssh_config
				end
      end
      File.open(@timestamp_file, 'w') do |f|
        f << Time.now
      end
		end

	end
end