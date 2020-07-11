class CombineItemsInCart < ActiveRecord::Migration[5.1]
  def up
    Cart.all.each do | cart |
      items = cart.line_items.group(:product_id).sum(:quantity)

      items.each do | id, quantity |
        if quantity > 1
          cart.line_items.where(product_id: id).delete_all

          item = cart.line_items.build(product_id: id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    LineItem.where("quantity > 1").each do | line_item |
      line_item.quantity.times do
        LineItem.create(
          cart_id: line_item.cart_id,
          product_id: line_item.product_id,
          quantity: 1
        )
      end

      line_item.destroy
    end
  end
end