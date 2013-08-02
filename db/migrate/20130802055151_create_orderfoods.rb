class CreateOrderfoods < ActiveRecord::Migration
  def change
    create_table :orderfoods do |t|
      t.integer :order_id
      t.integer :food_id

      t.timestamps
    end
  end
end
