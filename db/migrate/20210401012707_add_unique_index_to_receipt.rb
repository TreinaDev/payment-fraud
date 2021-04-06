class AddUniqueIndexToReceipt < ActiveRecord::Migration[6.1]
  def change
    add_index :receipts, :token_receipt, unique: true
  end
end
