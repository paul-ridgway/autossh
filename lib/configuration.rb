
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

    def save_cache!(file = File.expand_path(Assh::CONFIG_CACHE))
      cache = {
          hosts: @hosts,
          groups: @groups
      }
      File.open(file, 'w') {|f| f.write cache.to_yaml }
    end

    def load_cache!(file = File.expand_path(Assh::CONFIG_CACHE))
      cache = YAML::load_file(file)
      @hosts = cache[:hosts]
      @groups = cache[:groups]
    end

  end

end