
module Assh
	class Generator

		def run!(output_file = '.generated-config')
			File.open(output_file, 'w') do |f|
				f << "Host test\n"
				f << "  Hostname 10.11.12.13\n"
			    f << "  Port 2219\n"
			    f << "  User paul\n"
			    f << "  IdentityFile ~/Dropbox/.ssh/floow/id_rsa"
			end
		end

	end
end