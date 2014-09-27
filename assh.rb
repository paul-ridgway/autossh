#!/usr/bin/env ruby
require_relative 'lib/assh.rb'

Assh::Command.new(ARGV).execute!
