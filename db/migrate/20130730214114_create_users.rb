class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname, null: false
      t.string :email, null: false
      t.boolean :blocked, default: false

      t.timestamps
    end
  end
end
