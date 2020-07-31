# frozen_string_literal: true

require 'sqlite3'

module Repositories
  # get the information in the database
  class Uf
    class << self
      def list
        db = SQLite3::Database.open 'db/database.db'
        states = db.execute("SELECT * FROM Cities WHERE level='UF'")
        db.close
        states.map do |state|
          Entities::State.new(state[1], state[2], state[3])
        end
      end

      def get_city_by_name(check_city)
        db = SQLite3::Database.open 'db/database.db'
        cities = db.execute("SELECT * FROM Cities WHERE name LIKE ? AND level='MU'", ["%#{check_city}%"])
        db.close

        cities.map do |city|
          Entities::City.new(city[1], city[2], city[3])
        end
      end

      def check_uf_is_not_valid?(data, level)
        db = SQLite3::Database.open 'db/database.db'
        checked_uf = db.execute('SELECT * FROM Cities WHERE code=? AND level=?', [data, level])
        db.close
        checked_uf.empty?
      end
    end
  end
end
