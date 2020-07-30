# frozen_string_literal: true

require 'webmock/rspec'
require 'active_support/all'
require 'pry'
require 'json'
require 'repositories/ibge'
require 'faraday'
require 'entities/statistics_name'
require 'entities/frequency_name'
require 'entities/city'
require 'repositories/uf'

PROJECT_ROOT = File.expand_path('..', __dir__)

Dir.glob(File.join(PROJECT_ROOT, 'lib', '*.rb')).each do |file|
  autoload File.basename(file, '.rb').camelize, file
end

RSpec.configure do |config|
end
