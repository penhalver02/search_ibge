# frozen_string_literal: true

require 'cgi'
require 'i18n'
module Repositories
  # get the information in the api
  class Ibge
    IBGE_URL = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/'
    class << self
      def resque_uf(uf_number, params = {})
        query_string = "#{uf_number}#{query_string(params)}"
        url = "#{IBGE_URL}ranking?localidade=#{query_string}"
        response = http_get(url).first
        response['res'].each_with_object([]) do |q, names|
          names << Entities::StatisticsName.new(q['nome'], q['ranking'], q['frequencia'])
        end
      end

      def request_name(name)
        treated_name = handling_string(name)
        url = "#{IBGE_URL}#{treated_name}"
        response = http_get(url)
        response.each_with_object([]) do |name_of_person, data|
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

      private

      def query_string(params)
        {
          sexo: params[:sexo]
        }.compact.each_with_object([]) do |(key, value), q|
          q << "&#{key}=#{value}"
        end.join
      end

      def http_get(url)
        response = Faraday.get(url)
        JSON.parse(response.body)
      end
    end
  end
end
