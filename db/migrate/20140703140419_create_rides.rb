class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :attraction_id, null: false
      t.integer :user_id, null: false
    end
  end
end
