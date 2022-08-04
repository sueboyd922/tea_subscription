# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
CustomerSubscription.destroy_all
CustomerTea.destroy_all
Subscription.destroy_all
Customer.destroy_all

sub_1 = Subscription.create!(name: "Single Tea", price: 10, tea_limit: 1)
sub_2 = Subscription.create!(name: "Tea Lover", price: 20, tea_limit: 3)
sub_3 = Subscription.create!(name: "Tea Fiend", price: 30, tea_limit: 5)

tea_names = Tea.pluck(:name)

harry = Customer.create!(first_name: "Harry", last_name: "Potter", email: "thechosenone@hogwarts.edu", street: "Grimmauld Place", city: "London", state: "UK", zip_code: "12345")
jon = Customer.create!(first_name: "Jon", last_name: "Snow", email: "king0fthenorth@thewall.org", street: "The Wall", city: "The North", state: "Westeros", zip_code: "8675-309")

harry_sub_1 = harry.customer_subscriptions.create!(subscription: sub_1, frequency: "monthly")
harry_sub_2 = harry.customer_subscriptions.create!(subscription: sub_2, frequency: "yearly", active: false)
harry_sub_3 = harry.customer_subscriptions.create!(subscription: sub_3, frequency: "yearly")

harry_sub_1.add_teas([tea_names[0]])
harry_sub_2.add_teas([tea_names[3], tea_names[5], tea_names[10]])
harry_sub_3.add_teas([tea_names[4], tea_names[8], tea_names[9]])

jon_sub_1 = jon.customer_subscriptions.create!(subscription: sub_1, frequency: "monthly")
jon_sub_2 = jon.customer_subscriptions.create!(subscription: sub_1, frequency: "every 3 months", active: false)
jon_sub_3 =  jon.customer_subscriptions.create!(subscription: sub_2, frequency: "yearly")
jon_sub_4 = jon.customer_subscriptions.create!(subscription: sub_3, frequency: "yearly")

jon_sub_1.add_teas([tea_names[1]])
jon_sub_2.add_teas([tea_names[10]])
jon_sub_3.add_teas([tea_names[0], tea_names[2]])
jon_sub_4.add_teas([tea_names[7], tea_names[5], tea_names[9], tea_names[3]])
