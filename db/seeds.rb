# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Variant.delete_all
Product.delete_all
Category.delete_all
Category.create(name: 'Fuentes de poder')
Category.create(name: 'Tarjetas de video')
Category.create(name: 'Placas madre')
Category.create(name: 'Procesadores')

categories = Category.all
categories.each do |category|
  (1..14).each do |_n|
    product = Product.new(title: FFaker::Product.product, category_id: category.id)
    product.images.attach(io: File.open(Rails.root.join('public/1.png')), filename: '200x250.png',
                          content_type: 'image/png')
    product.images.attach(io: File.open(Rails.root.join('public/2.png')), filename: '200x250.png',
                          content_type: 'image/png')
    product.save!
  end
end

# User.create(email: 'seba.nrc@gmail.com')

# rangesdas = 1..20
# rangesdas.each do |_n|
#   order = Order.new(user_id: 1, name: FFaker::NameES.first_name, last_name: FFaker::NameES.last_name,
#                     address: FFaker::AddressCH.street_address, city: FFaker::AddressCH.city,
#                     comuna: FFaker::AddressCH.neighborhood, phone: 111_111,
#                     postal_code: FFaker::AddressCH.postal_code,
#                     amount: rand(9990..49_990))
#   order.save!
# end
