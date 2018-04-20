# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  User.create(name: Faker::Name.unique.name, email: Faker::Internet.email)
end

countries = ['Malaysia', 'Indonesia', 'Singapore']

100.times do
  Listing.create(user_id: rand(1..10), title: Faker::Address.street_name, country: countries.sample, num_beds: rand(1..6), num_bath: rand(1..3), price_per_night: rand(100..500))
end
