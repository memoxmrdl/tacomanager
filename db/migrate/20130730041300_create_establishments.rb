class CreateEstablishments < ActiveRecord::Migration
  def change
    create_table :establishments do |t|
      t.string :name, null: false
      t.string :telephones, null: false
      t.string :address, null: false
      t.string :description
      t.integer :user_id

      t.timestamps
    end
  end
end
