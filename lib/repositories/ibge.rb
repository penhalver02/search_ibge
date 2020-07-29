# frozen_string_literal: true

require 'cgi'
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
        name.gsub!(/[,]/, '|')
        name.gsub!(/\s+/, '')
        name = CGI.escape(name)
        url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{name}"
        response = Faraday.get(url)
        response_parsed = JSON.parse(response.body).first

        response_parsed['res'].each_with_object([]) do |q, names|
          names << Entities::FrequencyName.new(response_parsed['nome'], q['periodo'], q['frequencia'])
        end
      end
    end
  end
end
