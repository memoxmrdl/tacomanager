class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.integer :establishment_id
      t.string :name, null: false
      t.text :description, null: false
      t.float :price, null: false

      t.timestamps
    end
  end
end
