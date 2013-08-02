class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :establishment_id
      t.text :comment
      t.references :establishment, index: true

      t.timestamps
    end
  end
end
