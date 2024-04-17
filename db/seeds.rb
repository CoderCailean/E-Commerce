require 'uri'

OrderProduct.delete_all
Order.delete_all
User.delete_all
Province.delete_all
Product.delete_all
Category.delete_all
AdminUser.delete_all

Province.create(name: "Alberta", gst: 5, pst: 0, hst: 5)
Province.create(name: "British Columbia", gst: 5, pst: 7, hst: 12)
Province.create(name: "Manitoba", gst: 5, pst: 7, hst: 12)
Province.create(name: "New Brunswick", gst: 5, pst: 10, hst: 15)
Province.create(name: "Newfoundland and Labrador", gst: 5, pst: 10, hst: 15)
Province.create(name: "Northwest Territories", gst: 5, pst: 0, hst: 5)
Province.create(name: "Nova Scotia", gst: 5, pst: 10, hst: 15)
Province.create(name: "Nunavut", gst: 5, pst: 0, hst: 5)
Province.create(name: "Ontario", gst: 5, pst: 8, hst: 13)
Province.create(name: "Prince Edward Island", gst: 5, pst: 10, hst: 15)
Province.create(name: "Quebec", gst: 5, pst: 10, hst: 15)
Province.create!(name: "Saskatchewan", gst: 5, pst: 6, hst: 11)
Province.create!(name: "Yukon", gst: 5, pst: 0, hst: 5)


10.times do
  province = Province.find(rand(1...10))

  new_user = User.create!(
    email: Faker::Name.initials(number: 4) + "@gmail.com",
    password: 'password',
    password_confirmation: 'password') if Rails.env.development?

  user_profile = Profile.create!(
    full_name: Faker::Name.first_name + " " + Faker::Name.last_name,
    address: Faker::Address.street_address,
    postal_code: Faker::Address.zip,
    province_id: province.id,
    user_id: new_user.id
  )
end

100.times do
  category_id = Category.find_or_create_by(name: Faker::Coffee.variety)

  product = Product.create(
    name: Faker::Coffee.blend_name,
    price: Faker::Number.decimal(l_digits: 2),
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
      order_id: order.id,
      product_id: product.id,
      quantity: Faker::Number.between(from: 1, to: 10),
      sale_price: product.price
    )
  end
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?