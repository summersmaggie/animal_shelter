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
end
