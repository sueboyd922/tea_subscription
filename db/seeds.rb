# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Subscription.destroy_all
Customer.destroy_all

Subscription.create!(name: "Single Tea", price: 10, tea_limit: 1)
Subscription.create!(name: "Tea Lover", price: 20, tea_limit: 3)
Subscription.create!(name: "Tea Fiend", price: 30, tea_limit: 5)


Customer.create!(first_name: "Harry", last_name: "Potter", email: "thechosenone@hogwarts.edu", street: "Grimmauld Place", city: "London", state: "UK", zip_code: "12345")
