# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

product = Product.create( name: "Snow Mittenberry", price: 24.99, photo: "snow.png", color_name: "Snow", color: "#F8F8F8", sku:"090101")
product = Product.create( name: "Heather Gray Mittenberry", price: 24.99, photo: "gray.png", color_name: "Heather Gray", color: "#3B3D43", sku: "090102")
product = Product.create( name: "Blush Mittenberry", price: 24.99, photo: "blush.png", color_name: "Blush", color: "#FFDDFF", sku:"090103")

# User.create( name: "Admin", email: "admin@mittenberry.com", password: "hungry" )