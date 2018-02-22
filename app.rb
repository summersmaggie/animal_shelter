require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/animal")
require("./lib/customer")
require("pg")
require("pry")

DB = PG.connect({:dbname => "animal_shelter"})

get('/') do
  erb(:home)
end

get('/animal/new') do
  erb(:animal_form)
end

get('/animals') do
  @animals = Doctor.all()
  erb(:animals)
end

post('/animals') do
  name = params.fetch("name")
  gender = params.fetch("gender")
  type = params.fetch("type")
  breed = params.fetch("breed")
  owner_id = params.fetch("owner_id").to_i()

  @customer = Customer.find(owner_id)
  @animal = Animal.new({:name => name, :gender => gender, :type => type, :breed => breed, :owner_id => owner_id, :id => nil})
  @animal.save()

  erb(:animals)
end

get('/customer/new') do
  erb(:customer_form)
end
