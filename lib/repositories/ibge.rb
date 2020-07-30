# frozen_string_literal: true

require 'cgi'
require 'i18n'
module Repositories
  # get the information in the api
  class Ibge
    class << self
      def resque_uf(uf_number, params = {})
        query_string = "#{uf_number}#{query_string(params)}"
        url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=#{query_string}"
        response = Faraday.get(url)
        response_parsed = JSON.parse(response.body).first
        response_parsed['res'].each_with_object([]) do |q, names|
          names << Entities::StatisticsName.new(q['nome'], q['ranking'], q['frequencia'])
        end
      end

      def query_string(params)
        {
          sexo: params[:sexo]
        }.compact.each_with_object([]) do |(key, value), q|
          q << "&#{key}=#{value}"
        end.join
      end

      def request_name(name)
        treated_name = handling_string(name)
        url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{treated_name}"
        response = Faraday.get(url)
        response_parsed = JSON.parse(response.body)
        response_parsed.each_with_object([]) do |name_of_person, data|
          data << name_of_person['res'].map do |q|
            Entities::FrequencyName.new(name_of_person['nome'], q['periodo'], q['frequencia'])
          end
        end
      end

      def handling_string(name)
        name = name.parameterize
        name.gsub!(/[-]/, '|')
        CGI.escape(name).downcase
      end
    end
  end
end
