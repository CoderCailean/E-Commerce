class ProductsController < ApplicationController
  def index
    @products = Product.all()
  end

  def show
    @product = Product.find(params[:id])
    @category = Category.find(@product.category_id)
  end
end
