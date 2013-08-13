class AddPaymentToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :payment, :boolean, default: false
  end
end
