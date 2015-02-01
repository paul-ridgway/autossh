require 'rubygems'
require 'colorize'

require_relative 'helpers'
require_relative 'configuration'
require_relative 'provider'
require_relative 'providers/file_provider'
require_relative 'providers/random_provider'
require_relative 'providers/aws_provider'
require_relative 'command'
require_relative 'generator'
require_relative 'host'

module Assh

  ROOT = File.expand_path('~/.autossh')

  GENERATED_CONFIG = '.assh-generated-config'
  CONFIG_CACHE = '.assh-config-cache'
  CONFIG_CACHE_AT = '.assh-config-cached-at'

	VERSION = '2014.9.27.1.alpha'

end