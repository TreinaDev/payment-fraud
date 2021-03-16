class CreateFraudEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :fraud_events do |t|
      t.string :cpf
      t.integer :event_severity

      t.timestamps
    end
  end
end
