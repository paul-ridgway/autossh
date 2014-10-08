module Assh

  class Command

    def initialize(argv)
      @args = argv
      parse_arguments!

      @configuration = Configuration.new

      @generator = Generator.new

      Provider.verbose! if @cmd_generate

      if @configuration.needs_generating? || @cmd_generate
        puts "Refreshing..."
        Provider.load_configuration!(@configuration, 'config.yml')
        @configuration.save_cache!
      else
        @configuration.load_cache!
      end

    end

    def execute!
      if @cmd_ls
        puts "Host List (cached at #{Time.at(@configuration.generated_at)})".green
        max_name = 0
        @configuration.groups.each do |name, hosts|
          hosts.each do |name, host|
            max_name = name.size if name.size > max_name
          end
        end
        @configuration.groups.each do |name, hosts|
          puts "  #{name.yellow}"
          hosts = Hash[hosts.sort]
          hosts.each do |name, host|
            padded_name = name + (" " * (max_name - name.size))
            puts "    #{padded_name.light_white} #{"-".green} #{host.address.cyan}"
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
      args = @args.map { |x| x.include?(' ') ? "\"#{x}\"" : x }.join(' ')
      command = "ssh -F #{Assh::GENERATED_CONFIG} #{args}"
      exec(command)
    end

  end

end