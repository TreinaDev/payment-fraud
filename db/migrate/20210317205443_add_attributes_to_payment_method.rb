class AddAttributesToPaymentMethod < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_methods, :max_installments, :integer
    add_column :payment_methods, :code, :string
  end
end
