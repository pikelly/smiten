# frozen_string_literal: true

require 'time'
require 'digest'
require 'faraday'
require 'faraday_middleware'
require 'ostruct'
require_relative 'smiten/version'
require_relative 'smiten/smiten'
require_relative 'smiten/paladins'
require_relative 'smiten/smite'

exit unless $0 == __FILE__

require 'yaml'
creds = YAML.load_file(__dir__ + '/../.creds')
api = Smiten::Paladins.new(creds)
api.calls.keys[15..-1].each do |call_name|
  next if %i{createsession}.include?(call_name)

  response = api.send(call_name, api.calls[call_name][2])
  response
end
