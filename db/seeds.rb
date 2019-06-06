# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: "giapb",email: "giapb@mail.com", password:"Aa123456")

9.times do |x|
  User.create(name: "username #{x}", email: "email#{x}@mail.com", password:"Bb123456")
end
