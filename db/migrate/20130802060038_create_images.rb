class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.attachment :image
      t.references :establishment, index: true
      t.references :food, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
