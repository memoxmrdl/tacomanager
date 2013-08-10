class Dashboard::EstablishmentsController < DashboardController
  before_filter :establishment_find_by_id, only: [:show, :edit, :update]

  def index
    @establishments = Establishment.all
  end

  def new
    @establishment = Establishment.new
    @address = Address.new
  end

  def show
  end

  def create
    address = Address.new params_address
    @establishment = Establishment.new params_establishment

    if @establishment.save
      @establishment.address << address
      address.save
      return redirect_to dashboard_establishments_path, notice: t('.created')
    end

    flash.now[:alert] = 'error'
    render :new
  end

  def edit
    return redirect_to dashboard_establishments_path, alert: 'not found' unless @establishment
  end

  def update
    updated = @establishment.update params_establishment if @establishment

    message = redirect_message @establishment, updated, 'updated'
    return redirect_to dashboard_establishments_path, message unless message.empty?

    flash.now[:alert] = 'error'
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
    params.require(:establishment).permit(:name)
  end
end
