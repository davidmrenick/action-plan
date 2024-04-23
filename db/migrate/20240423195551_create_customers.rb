class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.integer :vehicle_type
      t.string :vehicle_name
      t.integer :vehicle_length

      t.timestamps
    end
  end
end
