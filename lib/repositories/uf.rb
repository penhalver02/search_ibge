# frozen_string_literal: true

require 'csv'

module Repositories
  # get the information in the database
  class Uf
    class << self
      def list
        execute_query('SELECT * FROM States').map do |state|
          Entities::State.new(state['code'], state['name'], state['population'])
        end
      end

      def get_city_by_name(check_city)
        execute_query('SELECT * FROM Cities WHERE name LIKE ?', ["%#{check_city}%"]).map do |city|
          Entities::City.new(city['code'], city['name'], city['population'])
        end
      end

      def check_uf_is_not_valid?(data)
        execute_query('SELECT * FROM States WHERE code=?', [data]).empty?
      end

      def check_city_is_not_valid?(data)
        execute_query('SELECT * FROM Cities WHERE code=?', [data]).empty?
      end

      private

      def execute_query(query, params = [])
        db = SQLite3::Database.new('db/database.db', results_as_hash: true)
        db.execute(query, params)
      ensure
        db.close
      end
    end
  end
end
