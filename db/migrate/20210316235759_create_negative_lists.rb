class CreateNegativeLists < ActiveRecord::Migration[6.1]
  def change
    create_table :negative_lists do |t|
      t.string :cpf, null: false
      t.date :expiration_date, null: false

      t.timestamps
    end
  end
end
