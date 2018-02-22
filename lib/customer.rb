class Customer
  attr_accessor :name, :animal_type_pref, :breed_type_pref, :id

  def initialize(attributes)
    @name = attributes[:name]
    @animal_type_pref = attributes[:animal_type_pref]
    @breed_type_pref = attributes[:breed_type_pref]
    @id = attributes[:id]
  end

  def self.all
    customers = []
    returned_customers = DB.exec("SELECT * FROM customer;")
    returned_customers.each() do |customer|
      name = customer.fetch("name")
      animal_type_pref = customer.fetch("animal_type_pref")
      breed_type_pref = customer.fetch("breed_type_pref")
      id = customer.fetch("id").to_i()

      customers.push(Customer.new({:name => name, :animal_type_pref => animal_type_pref, :breed_type_pref => breed_type_pref, :id => id}))
    end
    customers
  end

  def save
    result = DB.exec("INSERT INTO customer (name, animal_type_pref, breed_type_pref) VALUES ('#{@name}', '#{@animal_type_pref}', '#{@breed_type_pref}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_customer)
    self.name().==(another_customer.name()).&(self.id().==(another_customer.id()))
  end

  def self.find(id)
    found_customer = nil
    Customer.all().each() do |customer|
      if customer.id().==(id)
        found_customer = customer
      end
    end
    found_customer
  end

  def adoption
    customer_animals = []
    animals = DB.exec("SELECT * FROM animal WHERE customer.id = #{self.id()};")
    binding.pry
    animals.each() do |animal|
      name = animals.fetch("name")
      gender = animal.fetch("gender")
      type = animal.fetch("type")
      breed = animal.fetch("breed")
      customer_animals.push(Animal.new({:name => name, :gender => gender, :type => type, :breed => breed}))
    end
    customer_animals
  end
end
