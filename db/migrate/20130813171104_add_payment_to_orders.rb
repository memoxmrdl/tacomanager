class AddPaymentToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment, :boolean
    add_column :orders, :user_id_payment, :integer
  end
end
