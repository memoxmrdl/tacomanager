class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :user_id
      t.references :user, index: true

      t.timestamps
    end
  end
end
