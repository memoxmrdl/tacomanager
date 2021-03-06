class CreateEstablishments < ActiveRecord::Migration
  def change
    create_table :establishments do |t|
      t.string :name, null: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
