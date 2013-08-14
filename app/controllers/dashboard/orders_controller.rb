class Dashboard::OrdersController < DashboardController
  before_filter :order_find_by_id, only: [:show, :destroy, :update]
  before_filter :check_info_establishment, only: :create

  respond_to :js, only: :update

  def show
    return redirect_to dashboard_root_path, alert: t('.not_found_order') unless @order

    @establishment = Establishment.find_by_id(params[:establishment_id])

    return redirect_to dashboard_establishments_path, alert: t('.not_found_establishment') unless @establishment

    @foods = Food.where(establishment_id: @establishment.id)
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def create
    @establishment = Establishment.find_by_id params[:establishment_id]

    return redirect_to dashboard_establishments_path, alert: t('.not_found') unless @establishment

    @order = Order.new
    @order.name = 'Nueva orden'
    @order.establishment = @establishment
    @order.user = current_identity.user

    if @order.save
      return redirect_to dashboard_establishment_order_path(id: @order.id), notice: t('.created')
    end

    redirect_to dashboard_establishments_path, alert: t('.error')
  end

  def update
    @order.update_attributes params_order

    respond_with @order
  end

  def destroy
    deleted = @order.destroy if @order
    message = redirect_message @order, deleted, t('.deleted')

    redirect_to dashboard_establishments_path, message
  end

  private

  def params_order
    params.require(:order).permit(:name, :status, :payment)
  end

  def order_find_by_id
    @order = Order.find_by_id params[:id]
  end

  def check_info_establishment
    @establishment = Establishment.find_by_id params[:establishment_id]

    return redirect_to dashboard_establishments_path, alert: t('.info_invalid') unless @establishment.info_valid?
  end
end
