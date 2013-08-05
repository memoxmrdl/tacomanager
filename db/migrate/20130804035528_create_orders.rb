class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name, null: false
      t.references :user, index: true
      t.references :establishment, index: true

      t.timestamps
    end
  end
end
