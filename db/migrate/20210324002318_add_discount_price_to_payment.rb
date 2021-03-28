class AddDiscountPriceToPayment < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :discount_price, :decimal,
                  precision: 6, scale: 2
  end
end
