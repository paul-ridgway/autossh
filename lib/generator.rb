module Assh
  class Generator

    attr_accessor :output_file

    def initialize(output_file = File.expand_path(Assh::GENERATED_CONFIG),
                   timestamp_file = File.expand_path(Assh::GENERATED_AT))
      @output_file = output_file
      @timestamp_file = timestamp_file
    end

    def needs_generating?
      puts current_time
      puts generated_at
      puts current_time-generated_at
      (current_time - generated_at) > 300
    end

    def run!(hosts)
      File.open(@output_file, 'w') do |f|
        hosts.each do |_, host|
          f << host.to_ssh_config
        end
      end
      File.open(@timestamp_file, 'w') do |f|
        f << current_time
      end
    end

    private
    def generated_at
      return File.read(@timestamp_file).to_i if File.exists?(@timestamp_file)
      0
    end

    def current_time
      Time.now.to_i
    end

  end

end