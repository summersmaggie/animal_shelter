require("spec_helper")

describe(Animal) do
  describe(".all") do
    it("is empty at first") do
      expect(Animal.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("saves animals to animal array") do
      new_animal = Animal.new({:name => "Nugget", :gender => "Male", :admit_date => "2018-01-22", :type => "dog", :breed => "chihuahua", :id => nil, :owner_id => 0})
      new_animal.save()
      expect(Animal.all()).to(eq([new_animal]))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      new_animal = (Animal.new({:name => "Nugget", :gender => "Male", :admit_date => "2018-01-22", :type => "dog", :breed => "chihuahua", :id => nil, :owner_id => 0}))
      new_animal.save()
      expect(new_animal.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#==") do
    it("is the same animal if it has the same name") do
      animal1 = (Animal.new({:name => "Nugget", :gender => "Male", :admit_date => "2018-01-22", :type => "dog", :breed => "chihuahua", :id => nil, :owner_id => 0}))
      animal2 = (Animal.new({:name => "Nugget", :gender => "Male", :admit_date => "2018-01-22", :type => "dog", :breed => "chihuahua", :id => nil, :owner_id => 0}))
      expect(animal1).to(eq(animal2))
    end
  end

  describe("#find") do
    it("returns an animal by its id") do
      animal1 = Animal.new({:name => "Nugget", :gender => "Male", :admit_date => "2018-01-22", :type => "dog", :breed => "chihuahua", :id => nil, :owner_id => 0})
      animal1.save()
      animal2 = Animal.new({:name => "Nugget", :gender => "Male", :admit_date => "2018-01-22", :type => "dog", :breed => "chihuahua", :id => nil, :owner_id => 0})
      animal2.save()
      expect(Animal.find(animal2.id())).to(eq(animal2))
    end
  end
end
