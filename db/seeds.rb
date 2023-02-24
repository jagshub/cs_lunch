# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
#

Employee.destroy_all

30.times do |n|
  f_name = Faker::Name.first_name
  s_name = Faker::Name.last_name
  sex = ['Male', 'Female']
  Employee.create!(name: "#{f_name} #{s_name}", sex: sex[rand(0..1)], image_url: Faker::Avatar.image, department: Department.all.sample)
end


