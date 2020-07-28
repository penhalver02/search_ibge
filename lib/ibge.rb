# frozen_string_literal: true

require 'faraday'
require 'json'
require 'pry'
require_relative 'entities/state'
require_relative 'entities/statistics_name'
require_relative 'presenters/menu'
require_relative 'repositories/uf'
require_relative 'repositories/ibge'
require_relative 'presenters/states'
require_relative 'presenters/table_cities'

Presenters::Menu.new.print
opcion = gets.to_i

while opcion != 4
  if opcion == 1
    ufs = Repositories::Uf.list
    Presenters::States.new(ufs).print
    code = gets
    names = Repositories::Ibge.resque_uf(code)
    Presenters::TableCities.new('Tabela de nomes no Estado', names).printf
    names = Repositories::Ibge.resque_uf(code, sexo: 'M')
    Presenters::TableCities.new('Tabela de nomes masculinos no Estado', names).printf
    names = Repositories::Ibge.resque_uf(code, sexo: 'F')
    Presenters::TableCities.new('Tabela de nomes femeninos no Estado', names).printf
  elsif opcion == 2
    puts 'Digete a cidade'
    city = gets.chomp
    city = Repositories::Uf.get_city_by_name(city)
    names = Repositories::Ibge.resque_uf(city.code)
    Presenters::TableCities.new('Tabela de nomes da cidade', names).printf
    names = Repositories::Ibge.resque_uf(city.code, sexo: 'M')
    Presenters::TableCities.new('Tabela de nomes masculinos da Cidade', names).printf
    names = Repositories::Ibge.resque_uf(city.code, sexo: 'F')
    Presenters::TableCities.new('Tabela de nomes femeninos da Cidade', names).printf
  elsif opcion == 3

  elsif opcion == 4
  end
  Presenters::Menu.new.print
  opcion = gets.to_i
end
