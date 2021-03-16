class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :payment_method, null: false, foreign_key: true
      t.string :cpf
      t.string :customer_token
      t.string :plan_id

      t.timestamps
    end
  end
end
