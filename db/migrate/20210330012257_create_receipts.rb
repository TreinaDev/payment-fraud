class CreateReceipts < ActiveRecord::Migration[6.1]
  def change
    create_table :receipts do |t|
      t.integer :token_receipt
      t.integer :number_installment
      t.references :payment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
