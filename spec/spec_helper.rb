require("rspec")
require('pry')
require("pg")
require("animal")
require("customer")

DB = PG.connect({:dbname => "animal_shelter"}) #connect to test db

RSpec.configure do |config| # clear db between spec runs
  config.after(:each) do
    DB.exec("DELETE FROM animal *;")
    DB.exec("DELETE FROM customer *;")
  end
end
