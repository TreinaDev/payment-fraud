class AddStatusToPaymentMethod < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_methods, :status, :integer, default: 0, null: false
  end
end
