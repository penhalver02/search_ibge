# frozen_string_literal: true

require 'faraday'
require 'json'
require 'pry'
require 'sqlite3'
require 'active_support/all'
require_relative 'entities/state'
require_relative 'entities/city'
require_relative 'entities/statistics_name'
require_relative 'entities/frequency_name'
require_relative 'presenters/menu'
require_relative 'repositories/uf'
require_relative 'repositories/ibge'
require_relative 'presenters/states'
require_relative 'presenters/cities'
require_relative 'presenters/table_cities'
require_relative 'presenters/table_frequency'
require_relative 'printer'
require_relative 'available_services'
require_relative 'services/name_uf'
require_relative 'services/name_city'

presenter = Presenters::Menu.new(AvailableServices, 'Menu')
Printer.new(presenter).print
opcion = gets.to_i

while opcion != AvailableServices::QUIT
  if opcion == AvailableServices::NAME_IN_UF
    Services::NameUf.list_uf
    puts 'Digite o codigo'
    code = gets.to_i
    Services::NameUf.get_uf(code)
  elsif opcion == AvailableServices::NAME_IN_CITY
    puts 'Digite a cidade'
    city = gets.chomp
    Services::NameCity.list_city(city)
    puts 'Confirme a cidade digitando o codigo:'
    code = gets.to_i
    Services::NameCity.get_city(code)
  elsif opcion == AvailableServices::NAME_IN_THE_TIME
    puts 'Digite o nome'
    name = gets.chomp
    frequency_of_name = Repositories::Ibge.request_name(name)
    if frequency_of_name.empty?
      puts 'Nome não encontrado'
    else
      presenter = Presenters::TableFrequency.new(frequency_of_name, 'Tabela de frequencia ')
      Printer.new(presenter).print
    end
  elsif opcion == AvailableServices::QUIT
  end
  presenter = Presenters::Menu.new(AvailableServices, 'Menu')
  Printer.new(presenter).print
  opcion = gets.to_i
end
