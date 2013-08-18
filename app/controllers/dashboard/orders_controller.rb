class Dashboard::OrdersController < DashboardController
  before_filter :order_find_by_id, only: [:show, :update, :destroy]
  before_filter :check_info_establishment, only: :create

  respond_to :js, :json, only: :update

  def show
    @establishment = Establishment.find_by_id(params[:establishment_id])

    return redirect_to dashboard_establishments_path, alert: t('.not_found_establishment') unless @establishment

    @foods = Food.where(establishment_id: @establishment.id)
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def create
    @order = Order.new
    @order.establishment = @establishment
    @order.user = current_identity.user

    if @order.save
      return redirect_to dashboard_establishment_order_path(id: @order.id), notice: t('.created')
    end

    redirect_to dashboard_establishment_order_path(id: @order.id), alert: t('.error')
  end

  def update
    @order.user_id_payment = current_identity.user.id if params[:order][:payment]
    @order.update_attributes params_order

    respond_to do |format|
      if @order.valid?
        format.js {}
      else
        format.json { render json: @order.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    deleted = @order.destroy if @order
    message = redirect_message @order, deleted, t('.deleted')

    redirect_to dashboard_establishments_path, message
  end

  private

  def params_order
    params.require(:order).permit :status, :payment
  end

  def order_find_by_id
    @order = Order.find_by_id params[:id]

    return redirect_to dashboard_root_path, alert: t('.not_found_order') unless @order
  end

  def check_info_establishment
    @establishment = Establishment.find_by_id params[:establishment_id]

    return redirect_to dashboard_establishments_path, alert: t('.not_found') unless @establishment
    return redirect_to dashboard_establishment_path(id: @establishment.id), alert: t('.info_invalid') unless @establishment.info_valid?
  end
end
