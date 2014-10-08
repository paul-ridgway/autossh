module Assh

  class Configuration

    attr_accessor :hosts, :groups

    def initialize
      @hosts = {}
      @groups = {}
    end

    def add_host(group_name, host_name, host)
      puts "WARNING: Duplicate host named: #{name}. Only latest host is included" if @hosts[host_name]

      @groups[group_name] = {} unless @groups.has_key?(group_name)
      @groups[group_name][host_name] = host
      @hosts[host_name] = host
    end

    #TODO: Move generated-at to here and call config-cached-at

    def save_cache!(config_file = File.expand_path(Assh::CONFIG_CACHE),
                    timestamp_file = File.expand_path(Assh::CONFIG_CACHE_AT))
      cache = {
          hosts: @hosts,
          groups: @groups
      }
      File.open(config_file, 'w') { |f| f << cache.to_yaml }
      File.open(timestamp_file, 'w') { |f| f << current_time }

    end

    def load_cache!(config_file = File.expand_path(Assh::CONFIG_CACHE))
      cache = YAML::load_file(config_file)
      @hosts = cache[:hosts]
      @groups = cache[:groups]
    end

    def needs_generating?(timestamp_file = File.expand_path(Assh::CONFIG_CACHE_AT))
      (current_time - generated_at(timestamp_file)) > 300
    end

    private
    def generated_at(timestamp_file = File.expand_path(Assh::CONFIG_CACHE_AT))
      return File.read(timestamp_file).to_i if File.exists?(timestamp_file)
      0
    end

    def current_time
      Time.now.to_i
    end

  end

end