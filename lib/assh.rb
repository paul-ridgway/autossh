require 'rubygems'
require 'colorize'

require_relative 'provider'
require_relative 'providers/file_provider'
require_relative 'command'
require_relative 'generator'
require_relative 'host'

module Assh

	GENERATED_CONFIG = '.generated-config'

	VERSION = '2014.9.27.1.alpha'

end