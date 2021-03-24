class AddPlanPriceToPayment < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :plan_price, :decimal,
                  precision: 6, scale: 2, null: false
  end
end
