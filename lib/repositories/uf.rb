# frozen_string_literal: true

require 'sqlite3'

module Repositories
  # get the information in the database
  class Uf
    def self.list
      db = SQLite3::Database.open 'db/database.db'
      states = db.execute("SELECT * FROM Cities WHERE level='UF'")
      db.close
      states.map do |state|
        Entities::State.new(state[1], state[2], state[3])
      end
    end

    def self.check_city(city)
      db = SQLite3::Database.open 'db/database.db'
      city = db.execute("SELECT * FROM Cities WHERE name Like '%#{city}%'")
      db.close
      city
    end
  end
end
