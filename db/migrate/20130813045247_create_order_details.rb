class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.integer :quantity
      t.float :subtotal
      t.references :order, index: true
      t.references :user, index: true
      t.references :food, index: true

      t.timestamps
    end
  end
end
