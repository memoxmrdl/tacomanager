class Dashboard::OrdersController < DashboardController
  before_filter :order_find_by_id, only: [:show, :destroy]

  def show
    return redirect_to dashboard_orders_path, alert: 'not found' unless @order

    @establishment = Establishment.find_by_id(params[:establishment_id])
    @foods = Food.where(establishment_id: params[:establishment_id])
  end

  def create
    @establishment = Establishment.find_by_id params[:establishment_id]

    return redirect_to dashboard_establishments_path, alert: 'Exito!' unless @establishment

    @order = Order.new
    @order.name = 'Nueva orden'
    @order.establishment = @establishment
    @order.user = current_identity.user

    if @order.save
      return redirect_to dashboard_establishment_order_path(id: @order.id), notice: 'created'
    end

    render text: @order.errors.inspect
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
end
