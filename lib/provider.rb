module Assh

  class Provider

    @@verbose = false

    @@providers ||= {}

    def initialize(configuration)
      @configuration = configuration
    end

    def self.load_configuration!(configuration, file)
      status "Loading: #{file}"

      config = YAML::load_file(File.expand_path(file, Assh::ROOT))

      includes = config.delete(Assh::FileProvider::INCLUDES_KEY) || []

      provider_name = (config.delete('Provider') || 'file').downcase
      provider_class = @@providers[provider_name]
      raise "Provider not found: #{provider_name}" unless provider_class

      provider = provider_class.new(configuration)
      provider.parse_config!(config)

      includes.each do |inc|
        Provider.load_configuration!(configuration, File.expand_path(inc, ROOT))
      end

      provider
    end

    def parse_config!(config)
      raise 'parse_config! must be overridden'
    end

    def add_host(group_name, host_name, host)
      @configuration.add_host(group_name, host_name, host)
    end

    def self.status(message = "", inline = false)
      return unless @@verbose
      if inline
        print message
      else
        puts message
      end
    end

    def self.verbose!
      @@verbose = true
    end

    def self.register_provider!(name, clazz)
      @@providers[name] = clazz
    end

  end

end