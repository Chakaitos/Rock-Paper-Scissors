require './lib/rps.rb'
require 'pry-debugger'

RSpec.configure do |config|
  config.before(:each) do
    RPS.instance_variable_set(:@__db_instance,nil)

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    # NEW: This clears your tables so you get fresh tables for every test
    # Please READ THE METHOD yourself in database.rb
    TM.db.clear_all_records
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  end
end
