class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :orderfood_id
      t.string :name

      t.timestamps
    end
  end
end