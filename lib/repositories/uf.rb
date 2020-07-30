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

      def get_city_by_name(city)
        db = SQLite3::Database.open 'db/database.db'
        city = db.execute("SELECT * FROM Cities WHERE name='#{city}'")
        db.close
        Entities::State.new(city[0][1], city[0][2], city[0][3])
      end

      def check_uf_is_not_valid?(data)
        db = SQLite3::Database.open 'db/database.db'
        checked_uf = db.execute("SELECT * FROM Cities WHERE code='#{data}' AND level='UF'")
        db.close
        checked_uf.empty?
      end
    end
  end
end
