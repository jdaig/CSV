require 'faker'
require 'csv'
require 'date'
#require 'as-duration'

class Person

  attr_accessor :first_name, :last_name, :email, :phone, :created_at
  
  def initialize(first_name, last_name, email, phone, created_at)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone = phone
    @created_at = created_at
  end

  def poblar_info
    @first_name = Faker::Name.first_name
    @last_name = Faker::Name.last_name
    @email = Faker::Internet.email
    @phone = Faker::PhoneNumber.cell_phone
    @created_at = Faker::Time.between(DateTime.now - 100, DateTime.now)
    #{}"#{@first_name}, #{@last_name}, #{@email}, #{@phone}, #{@created_at}"
    self #devuelve el objeto mismo
  end

end

class PersonWriter
  def initialize(file, people)
    @file = file
    @people = people
  end

  def create_csv
    CSV.open(@file, 'wb') do |csv|
      @people.each{|persona| csv << [persona.first_name, persona.last_name, persona.email, persona.phone, persona.created_at]}
    end
  end
end


class PersonParser
 def initialize(name_file)
  @name_file = name_file
 end


 def people
  nuevo_array=[]
  CSV.foreach(@name_file) do |row|
    # p row
    person = Person.new(row[0], row[1], row[2], row[3], DateTime.parse(row[4]))
    nuevo_array << person
  end
  nuevo_array
 end

end


def ingresados(number)
  lista_de_espera=[]
  number.times do
    persona = Person.new(0,0,0,0,0)
    lista_de_espera << persona.poblar_info
  end
  lista_de_espera
end

#p Person.new(Faker::Name.first_name, Faker::Name.last_name, Faker::Internet.email, Faker::PhoneNumber.phone_number, Faker::Time.between(DateTime.now - 100, DateTime.now))

array_people = ingresados(15)
 p array_people


person_writer = PersonWriter.new("people.csv", array_people)
person_writer.create_csv

parser = PersonParser.new('people.csv')
people = parser.people
 p people

