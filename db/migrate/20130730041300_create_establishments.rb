class CreateEstablishments < ActiveRecord::Migration
  def change
    create_table :establishments do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :location, null: false
      t.integer :identity_id

      t.timestamps
    end
  end
end
