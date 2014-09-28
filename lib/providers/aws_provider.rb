require 'aws-sdk'

module Assh

  class AwsProvider < Assh::Provider

    def initialize(configuration)
      super(configuration)
    end

    def parse_config!(config)
      return unless config
      raise 'Unexpected config type' unless config.is_a? Hash

      AWS.config(
          access_key_id: config['AccessKeyId'],
          secret_access_key: config['SecretAccessKey'])


      regions = AWS.ec2.regions.map { |r| r.name }

      regions.each do |region|

        ec2 = AWS::EC2.new(
            access_key_id: config['AccessKeyId'],
            secret_access_key: config['SecretAccessKey'],
            region: region)

        hosts = {}
        ec2.instances.each do |i|
          name = (i.tags.Name || i.instance_id).underscore
          ip = i.public_ip_address
          hosts[name] = ip
        end

        hosts.each do |name, ip|
          add_host(region, name, Host.new({'Host' => name, 'HostName' => ip}))
        end

      end

    end

  end

end

Assh::Provider.register_provider!("aws", Assh::AwsProvider)