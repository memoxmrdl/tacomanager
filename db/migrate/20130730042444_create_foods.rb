class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.text :description
      t.float :price, null: false
      t.references :establishment, index: true

      t.timestamps
    end
  end
end
