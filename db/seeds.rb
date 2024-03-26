require 'uri'

Product.delete_all
Category.delete_all
AdminUser.delete_all


100.times do
  category_id = Category.find_or_create_by(name: Faker::Coffee.variety)

  p = Product.create(
    name: Faker::Coffee.blend_name,
    price: Faker::Number.between(from: 0.5, to: 29.99),
    description: Faker::Coffee.notes,
    categories_id: category_id.id
  )


  # downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{p.name}")
  # p.image.attach(io: downloaded_image, filename: "m-#{p.name}.jpg")
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?