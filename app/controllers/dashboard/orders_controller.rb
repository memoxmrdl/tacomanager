class Dashboard::OrdersController < DashboardController
  def index
    @orders = Order.find_by_user_id current_identity.user.id
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find_by_id params[:id]

    return redirect_to dashboard_orders_path, alert: 'not found' unless @order
  end

  def create
    @order = Order.new order_params
    @order.user = current_identity.user

    return redirect_to dashboard_order_path(id: @order.id), notice: 'created' if @order.save

    render :new
  end

  def edit
    @order = Order.find_by_id params[:id]

    redirect_to dashboard_orders_path, alert: 'not found' unless @order
  end

  def update
    @order = Order.find_by_id params[:id]

    updated = @order.update order_params if @order

    message = redirect_message @order, updated, 'updated'
    return redirect_to dashboard_orders_path, message unless message.empty?

    render :edit
  end

  def destroy
    @order = Order.find_by_id params[:id]

    deleted = @order.destroy if @order
    message = redirect_message @order, deleted, 'deleted'

    redirect_to dashboard_orders_path, message
  end

  private

  def order_params
    params.require(:order).permit(:name, :establishment_id)
  end
end
