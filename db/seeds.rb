
Category.delete_all
Product.delete_all


100.times do
  category_id = Category.find_or_create_by(name: Faker::Coffee.variety)

  Product.create(
    name: Faker::Coffee.blend_name,
    price: Faker::Number.between(from: 0.5, to: 29.99),
    description: Faker::Coffee.notes,
    categories_id: category_id.id
  )
end