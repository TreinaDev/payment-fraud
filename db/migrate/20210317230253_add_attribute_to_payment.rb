class AddAttributeToPayment < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :payment_token, :string
  end
end
