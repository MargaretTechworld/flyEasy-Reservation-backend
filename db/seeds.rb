# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(name:'Bahati', password: '12345678', email:'exampl1@gmail.com', password_confirmation: '12345678', admin: false)
User.create(name:'Joy', password: '12345678', email:'exampl2@gmail.com', password_confirmation: '12345678', admin: true)
User.create(name:'Margaret', password: '12345678', email:'exampl3@gmail.com', password_confirmation: '12345678', admin: false)
User.create(name:'Bran', password: '12345678', email:'exampl4@gmail.com', password_confirmation: '12345678', admin: true)
User.create(name:'Ghost', password: '12345678', email:'exampl5@gmail.com', password_confirmation: '12345678', admin: false)
