#!/usr/bin/env ruby
require 'pp'
require_relative 'lib/assh.rb'

Assh::Command.new(ARGV).execute!
