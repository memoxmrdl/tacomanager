class Establishment < ActiveRecord::Base
  t.integer :user_id
  t.string :name
  t.string :information
  t.string :telephone
  t.string :addres
  t.references :establishment, index: true

  t.timestamps
end
