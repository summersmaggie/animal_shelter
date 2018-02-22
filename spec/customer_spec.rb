require("spec_helper")

describe(Customer) do
  describe(".all") do
    it("is empty at first") do
      expect(Customer.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("saves customers to customer array") do
      new_customer = Customer.new({:name => "Maggie", :phone => '6302531865', :animal_type_pref => "dog", :breed_type_pref => "chihuahua", :id => nil})
      new_customer.save()
      expect(Customer.all()).to(eq([new_customer]))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      new_customer = Customer.new({:name => "Maggie", :phone => '6302531865', :animal_type_pref => "dog", :breed_type_pref => "chihuahua", :id => nil})
      new_customer.save()
      expect(new_customer.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#==") do
    it("is the same animal if it has the same name") do
      customer1 = Customer.new({:name => "Maggie", :phone => '6302531865', :animal_type_pref => "dog", :breed_type_pref => "chihuahua", :id => nil})
      customer2 = Customer.new({:name => "Maggie", :phone => '6302531865', :animal_type_pref => "dog", :breed_type_pref => "chihuahua", :id => nil})
      expect(customer1).to(eq(customer2))
    end
  end

  describe("#find") do
    it("returns an customer by its id") do
      customer1 = Customer.new({:name => "Maggie", :phone => '6302531865', :animal_type_pref => "dog", :breed_type_pref => "chihuahua", :id => nil})
      customer1.save()
      customer2 = Customer.new({:name => "Maggie", :phone => '6302531865', :animal_type_pref => "dog", :breed_type_pref => "chihuahua", :id => nil})
      customer2.save()
      expect(Customer.find(customer2.id())).to(eq(customer2))
    end
  end

  describe("#adoption") do
    it("returns an array of animals per customer") do
      test_customer = Customer.new({:name => "Maggie", :phone => '6302531865', :animal_type_pref => "dog", :breed_type_pref => "chihuahua", :id => nil})
      test_customer.save()
      animal1 = Animal.new({:name => "Nugget", :gender => "Male", :type => "dog", :breed => "chihuahua", :id => nil, :owner_id => 0})
      animal1.save()
      animal2 = Animal.new({:name => "Faye", :gender => "Female", :type => "dog", :breed => "border collie", :id => nil, :owner_id => 0})
      animal2.save()
      expect(test_customer.adoption()).to(eq([animal1, animal2]))
    end
  end
end
