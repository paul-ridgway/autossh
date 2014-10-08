module Assh
  class Generator

    attr_accessor :output_file

    def initialize(output_file = File.expand_path(Assh::GENERATED_CONFIG))
      @output_file = output_file
    end

    def run!(hosts)
      File.open(@output_file, 'w') do |f|
        hosts.each do |_, host|
          f << host.to_ssh_config
        end
      end
    end

  end

end