class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code
      t.references :establishment, index: true

      t.timestamps
    end
  end
end
