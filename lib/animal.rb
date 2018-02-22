class Animal
  attr_reader :name, :gender, :admit_date, :type, :breed, :id, :owner_id

  def initialize(attributes)
      @name = attributes[:name]
      @gender = attributes[:gender]
      @admit_date = attributes[:admit_date]
      @type = attributes[:type]
      @breed = attributes[:breed]
      @id = attributes[:id]
      @owner_id = attributes[:owner_id]
    end

  def self.all
    animals = []
    returned_animals = DB.exec("SELECT * FROM animal;")
    returned_animals.each() do |animal|
      name = animal.fetch("name")
      gender = animal.fetch("gender")
      admit_date = animal.fetch("admit_date")
      type = animal.fetch("type")
      breed = animal.fetch("breed")
      id = animal.fetch("id").to_i()
      owner_id = animal.fetch("owner_id").to_i()
      animals.push(Animal.new({:name => name, :gender => gender, :admit_date => admit_date, :type => type, :breed => breed, :id => id, :owner_id => owner_id}))
    end
    animals
  end

  def save
    result = DB.exec("INSERT INTO animal (name, gender, admit_date, type, breed, owner_id) VALUES ('#{@name}', '#{@gender}', '#{@admit_date}', '#{@type}', '#{@breed}', '#{@owner_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_animal)
    self.name().==(another_animal.name()).&(self.id().==(another_animal.id()))
  end

  def self.find(id)
    found_animal = nil
    Animal.all().each() do |animal|
      if animal.id().==(id)
        found_animal = animal
      end
    end
    found_animal
  end
end
