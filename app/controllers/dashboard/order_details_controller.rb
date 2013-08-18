class Dashboard::OrderDetailsController < DashboardController
  before_filter :order_find_by_id
  before_filter :order_detail_find_by_id

  respond_to :js, :json, only: [:create, :update, :destroy]

  def create
    @order_detail = current_identity.user
      .order_details
      .new order_detail_params
    @order_detail.order = @order
    @order_detail.quantity = 1

    respond_to do |format|
      if @order_detail.save
        format.js {}
      else
        format.json { render json: @order_detail.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  def update
    @order_detail.user_id_payment = current_identity.user.id
    @order_detail.update_attributes order_detail_params

    respond_to do |format|
      unless @order_detail.changed?
        format.js {}
      else
        format.json { render json: @order_detail.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order_detail.destroy

    respond_to do |format|
      if @order_detail.destroyed?
        format.js {}
      else
        format.json { render json: @order_details.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  private

  def order_detail_find_by_id
    @order_detail = OrderDetail.find_by_id params[:id]
  end

  def order_find_by_id
    @order = Order.find_by_id params[:order_id]
  end

  def order_detail_params
    params.require(:order_details).permit(:food_id, :quantity, :payment)
  end
end
