class Dashboard::EstablishmentsController < DashboardController
  before_filter :establishment_find_by_id, only: [:show, :edit, :update]

  def index
    @establishments = Establishment.all
  end

  def new
    @establishment = Establishment.new
  end

  def show
    return redirect_to dashboard_establishments_path, alert: 'not found' unless @establishment

    @order = Order.new
    @foods = Food.where(establishment_id: params[:id])
  end

  def create
    @establishment = Establishment.new params_establishment
    @establishment.build_address params_address

    if @establishment.save
      return redirect_to dashboard_establishments_path, notice: t('.created')
    end

    flash.now[:alert] = t('.error')
    render :new
  end

  def edit
    return redirect_to dashboard_establishments_path, alert: 'not found' unless @establishment
  end

  def update
    updated = @establishment.update params_establishment if @establishment

    message = redirect_message @establishment, updated, 'updated'
    return redirect_to dashboard_establishments_path, message unless message.empty?

    flash.now[:alert] = t('.error')
    render :edit
  end

  def destroy
    return redirect_to dashboard_establishments_path, alert: 'permision deneged' unless current_identity.user.admin?

    @establishment = Establishment.find_by_id params[:id]
    deleted = @establishment.destroy if @establishment

    message = redirect_message @establishment, deleted, 'deleted'

    redirect_to dashboard_establishments_path, message
  end

  private

  def establishment_find_by_id
    @establishment = Establishment.find_by_id params[:id]
  end

  def params_address
    params.require(:establishment).require(:address).permit(:street, :city, :state, :country, :zip_code)
  end

  def params_establishment
    params.require(:establishment).permit(:name, :schedule, :phone)
  end
end
