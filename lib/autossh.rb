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

  GENERATED_CONFIG = "#{ROOT}/.assh-generated-config"
  CONFIG_CACHE     = "#{ROOT}/.assh-config-cache"
  CONFIG_CACHE_AT  = "#{ROOT}/.assh-config-cached-at"

  VERSION = '0.0.3'

end