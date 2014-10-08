require 'aws-sdk'

module Assh

  class AwsProvider < Assh::Provider

    def initialize(configuration)
      super(configuration)
    end

    def parse_config!(config)
      return unless config
      raise 'Unexpected config type' unless config.is_a? Hash

      name_match = config.delete 'NameMatch'
      access_key_id = config.delete 'AccessKeyId'
      secret_access_key = config.delete 'SecretAccessKey'

      AWS.config(
          access_key_id: access_key_id,
          secret_access_key: secret_access_key)


      Provider::status "Downloading regions list..."

      regions = AWS.ec2.regions.map { |r| r.name }

      Provider::status "Downloading instances..."

      regions.each do |region|

        ec2 = AWS::EC2.new(
            access_key_id: access_key_id,
            secret_access_key: secret_access_key,
            region: region)

        hosts = {}
        ec2.instances.each do |i|
          Provider::status '.', true
          name = (i.tags.Name || i.instance_id).underscore
          ip = i.public_ip_address
          hosts[name] = ip
        end

        hosts.each do |name, ip|

          if name_match
            m = Regexp.new(name_match).match(name)
            if m
              name = m.captures[0]
            end
          end

          add_host(region, name, Host.new(config.merge({'Host' => name, 'HostName' => ip})))
        end

      end

      Provider::status

    end

  end

end

Assh::Provider.register_provider!("aws", Assh::AwsProvider)