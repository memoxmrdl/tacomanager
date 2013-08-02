class CreateOrderfoods < ActiveRecord::Migration
  def change
    create_table :orderfoods do |t|
      t.integer :order_id
      t.integer :food_id
      t.references :order, index: true
      t.references :food, index: true

      t.timestamps
    end
  end
end
