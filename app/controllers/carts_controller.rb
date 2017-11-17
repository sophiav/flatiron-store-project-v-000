class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    if user_signed_in?
      render :show
    else
      redirect_to new_user_session_path
    end
  end

  def checkout
    current_user.current_cart.line_items.each do |i|
      item = Item.find(i.item_id)
      item.inventory-= i.quantity
      item.save
    end

    cart = current_user.current_cart
    cart.user_id = nil
    cart.save
    redirect_to cart_path(cart)
  end

end
