# frozen_string_literal: true

require 'webmock/rspec'
require 'active_support/all'
require 'pry'
require 'json'
require 'repositories/ibge'
require 'faraday'
require 'sqlite3'
require 'entities/statistics_name'
require 'entities/frequency_name'
require 'entities/city'
require 'repositories/uf'
require 'presenters/states'
require 'presenters/table_cities'
require 'presenters/table_frequency'
require 'presenters/menu'

PROJECT_ROOT = File.expand_path('..', __dir__)

Dir.glob(File.join(PROJECT_ROOT, 'lib', '*.rb')).each do |file|
  autoload File.basename(file, '.rb').camelize, file
end

RSpec.configure do |config|
end
