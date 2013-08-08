class Dashboard::OrdersController < DashboardController
  before_filter :order_find_by_id, except: [:index, :new, :create]

  def index
    @orders = Order.find_by_user_id current_identity.user.id
  end

  def new
    @order = Order.new
  end

  def show
    return redirect_to dashboard_orders_path, alert: 'not found' unless @order
  end

  def create
    @order = Order.new order_params
    @order.user = current_identity.user

    return redirect_to dashboard_order_path(id: @order.id), notice: 'created' if @order.save

    render :new
  end

  def edit
    redirect_to dashboard_orders_path, alert: 'not found' unless @order
  end

  def update
    updated = @order.update order_params if @order

    message = redirect_message @order, updated, 'updated'
    return redirect_to dashboard_orders_path, message unless message.empty?

    render :edit
  end

  def destroy
    deleted = @order.destroy if @order
    message = redirect_message @order, deleted, 'deleted'

    redirect_to dashboard_orders_path, message
  end

  private

  def order_find_by_id
    @order = Order.find_by_id params[:id]
  end

  def order_params
    params.require(:order).permit(:name, :establishment_id)
  end
end
