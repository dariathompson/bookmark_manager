# frozen_string_literal: true

require 'pg'
require_relative '../lib/database_connection'
def persisted_data(table:, id:)
  DatabaseConnection.query("SELECT * FROM #{table} WHERE id = '#{id}';")
end
