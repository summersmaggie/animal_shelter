class Customer
  attr_reader :name, :phone, :animal_type_pref, :breed_type_pref, :id

  def initialize(attributes)
    @name = attributes[:name]
    @phone = attributes[:phone]
    @animal_type_pref = attributes[:animal_type_pref]
    @breed_type_pref = attributes[:breed_type_pref]
    @id = attributes[:id]
  end

  def self.all
    customers = []
    returned_customers = DB.exec("SELECT * FROM owner;")
    returned_customers.each() do |customer|
      name = customer.fetch("name")
      phone = customer.fetch("phone")
      animal_type_pref = customer.fetch("animal_type_pref")
      breed_type_pref = customer.fetch("breed_type_pref")
      id = customer.fetch("id").to_i()

      customers.push(Customer.new({:name => name, :phone => phone, :animal_type_pref => animal_type_pref, :breed_type_pref => breed_type_pref, :id => id}))
    end
    customers
  end

  def save
    result = DB.exec("INSERT INTO owner (name, phone, animal_type_pref, breed_type_pref) VALUES ('#{@name}', '#{@phone}', '#{@animal_type_pref}', '#{@breed_type_pref}') RETURNING id;")
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
end
