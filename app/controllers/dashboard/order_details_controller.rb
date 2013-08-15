class Dashboard::OrderDetailsController < DashboardController
  before_filter :order_find_by_id
  respond_to :js, only: [:create, :update, :destroy]

  def create
    @order_detail = OrderDetail.new order_detail_params
    @order_detail.user = current_identity.user
    @order_detail.order = @order
    @order_detail.quantity = 1
    @order_detail.save

    respond_with @order_detail
  end

  def update
    @order_detail = OrderDetail.find_by_id params[:id]
    @order_detail.user_id_payment = current_identity.user.id
    @order_detail.update_attributes order_detail_params

    respond_with @order_detail
  end

  def destroy
    @order_detail = OrderDetail.find_by_id params[:id]
    @order_detail.destroy

    respond_with @order_detail
  end

  private

  def order_find_by_id
    @order = Order.find_by_id params[:order_id]
    return redirect_to dashboard_orders_path, alert: 'not_found' unless @order
  end

  def order_detail_params
    params.require(:order_details).permit(:food_id, :quantity, :payment)
  end
end
