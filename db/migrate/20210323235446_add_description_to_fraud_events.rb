class AddDescriptionToFraudEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :fraud_events, :description, :string
  end
end
