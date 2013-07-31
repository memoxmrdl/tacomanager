class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :email, null: false
      t.string :user_id

      t.timestamps
    end
  end
end
