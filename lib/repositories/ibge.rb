# frozen_string_literal: true
module Repositories
  class Ibge
    class << self
      def resque_uf(uf, params = {})
        response = Faraday.get("https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=#{uf}#{query_string(params)}")
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
