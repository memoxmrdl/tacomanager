class CreateOrderusers < ActiveRecord::Migration
  def change
    create_table :orderusers do |t|
      t.references :order, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
