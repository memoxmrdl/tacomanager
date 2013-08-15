class AddUserIdPaymentToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :user_id_payment, :integer
  end
end
