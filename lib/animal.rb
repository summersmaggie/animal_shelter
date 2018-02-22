class Animal
  attr_accessor :name, :gender, :type, :breed, :id

  def initialize(attributes)
      @name = attributes[:name]
      @gender = attributes[:gender]
      @type = attributes[:type]
      @breed = attributes[:breed]
      @id = attributes[:id]
    end

  def self.all
    animals = []
    returned_animals = DB.exec("SELECT * FROM animal;")
    returned_animals.each() do |animal|
      name = animal.fetch("name")
      gender = animal.fetch("gender")
      type = animal.fetch("type")
      breed = animal.fetch("breed")
      id = animal.fetch("id").to_i()
      animals.push(Animal.new({:name => name, :gender => gender, :type => type, :breed => breed, :id => id}))
    end
    animals
  end

  def save
    result = DB.exec("INSERT INTO animal (name, gender, type, breed) VALUES ('#{@name}', '#{@gender}', '#{@type}', '#{@breed}') RETURNING id;")
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
