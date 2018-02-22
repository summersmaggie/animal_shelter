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

get('/customer/new') do
  erb(:customer_form)
end

get('/customers') do
  @customers = Customer.all()
  erb(:customers)
end

post('/customers') do
  name = params.fetch("name")
  animal_type_pref = params.fetch("animal_type_pref")
  breed_type_pref = params.fetch("breed_type_pref")
  customer = Customer.new({:name => name, :animal_type_pref => animal_type_pref, :breed_type_pref => breed_type_pref})
  customer.save()
  erb(:customer_success)
end

get('/customers/:id') do
  @customer = Customer.find(params.fetch("id").to_i)
  erb(:customer)
end

get('/animal/new') do
  erb(:animal_form)
end

get('/animals') do
  @animals = Animal.all()
  erb(:animals)
end

post('/animals') do
  name = params.fetch("name")
  gender = params.fetch("gender")
  type = params.fetch("type")
  breed = params.fetch("breed")
  @animal = Animal.new({:name => name, :gender => gender, :type => type, :breed => breed})
  @animal.save()
  erb(:animal_success)
end
