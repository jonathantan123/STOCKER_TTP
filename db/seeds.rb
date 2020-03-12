# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# ahoussaoinfoiasnofa
User.destroy_all

User.create(name: "jon", email_address: "admin", password_digest: BCrypt::Password.create('password'))
Portfolio.create(user_id: 1)