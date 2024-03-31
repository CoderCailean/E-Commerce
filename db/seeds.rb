require 'uri'

OrderProduct.delete_all
Order.delete_all
User.delete_all
Province.delete_all
Product.delete_all
Category.delete_all
AdminUser.delete_all

Province.create(name: "Alberta", tax_rate: 0)
Province.create(name: "British Columbia", tax_rate: 7)
Province.create(name: "Manitoba", tax_rate: 7)
Province.create(name: "New Brunswick", tax_rate: 10)
Province.create(name: "Newfoundland and Labrador", tax_rate: 10)
Province.create(name: "Northwest Territories", tax_rate: 0)
Province.create(name: "Nova Scotia", tax_rate: 10)
Province.create(name: "Nunavut", tax_rate: 0)
Province.create(name: "Ontario", tax_rate: 8)
Province.create(name: "Prince Edward Island", tax_rate: 10)
Province.create(name: "Quebec", tax_rate: 10)
Province.create!(name: "Saskatchewan", tax_rate: 6)
Province.create!(name: "Yukon", tax_rate: 0)


10.times do
  province = Province.find(rand(1...10))

  user = User.create!(
    full_name: Faker::Name.first_name + " " + Faker::Name.last_name,
    email: Faker::Name.initials(number: 4) + "@gmail.com",
    password: Faker::Fantasy::Tolkien.character,
    address: Faker::Address.street_address,
    provinces_id: province.id
  )
end

100.times do
  category_id = Category.find_or_create_by(name: Faker::Coffee.variety)

  product = Product.create(
    name: Faker::Coffee.blend_name,
    price: Faker::Number.between(from: 0.5, to: 29.99),
    description: Faker::Coffee.notes,
    category_id: category_id.id
  )

  query = URI.encode_www_form_component(["coffee"])
  downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{query}")
  product.image.attach(io: downloaded_image, filename: "m-#{product.name}.jpg")
  sleep(1)
end

20.times do
  user_count = User.count

  user = User.find(rand(1...user_count))

  order = Order.create(
    user_id: user.id,
    order_date: Faker::Date.in_date_period,
    fulfillment_status: Faker::Number.between(from: 1, to: 3)
  )

  5.times do
    product_count = Product.count
    product = Product.find(rand(1...product_count))

    OrderProduct.create!(
      orders_id: order.id,
      products_id: product.id,
      quantity: Faker::Number.between(from: 1, to: 10)
    )
  end
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?