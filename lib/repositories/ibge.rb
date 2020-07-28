# frozen_string_literal: true

module Repositories
  # get the information in the api
  class Ibge
    class << self
      def resque_uf(uf_number, params = {})
        url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=#{uf_number}#{query_string(params)}"
        response = Faraday.get(url)
        response_parsed = JSON.parse(response.body)
        response_parsed[0]['res'].each_with_object([]) do |q, names|
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
    end
  end
end
