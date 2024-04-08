class SearchController < ApplicationController
  def index
    category = params[:category_id]
    query = params[:query]

    if(category == "All")
      @results = Product.where('name LIKE ? OR description LIKE ?', "%#{query}%", "%#{query}%").all
    else
      category_id = category.to_i

      @results = Product.where('category_id = ? AND name like ? OR category_id = ? AND description LIKE ?', "#{category_id}", "%#{query}%", "#{category_id}", "%#{query}%").all
    end
  end
end
