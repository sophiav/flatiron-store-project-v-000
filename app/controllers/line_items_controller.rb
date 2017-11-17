class LineItemsController < ApplicationController

  def create
    cart = current_user.current_cart || current_user.carts.create
    cart.add_item(params[:item_id])


    if cart.save!
      redirect_to cart_path(cart)
    end
  end
end
