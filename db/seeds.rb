# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

product = Product.create( name: "Snow", price: 24.99, photo: "mittenssnow.jpg", color: "#F8F8F8", sku:"090101")
product = Product.create( name: "Heather Gray", price: 24.99, photo: "mittensgray.jpg", color: "#3B3D43", sku: "090102")
product = Product.create( name: "Blush", price: 24.99, photo: "mittensblush.jpg", color: "#FFDDFF", sku:"090103")

# User.create( name: "Admin", email: "admin@mittenberry.com", password: "hungry" )