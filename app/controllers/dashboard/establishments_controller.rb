class Dashboard::EstablishmentsController < DashboardController
  def index
    @establishments = Establishment.all
  end

  def new
    @establishment = Establishment.new
  end

  def show
    @establishment = Establishment.find_by_id params[:id]
  end


  def create
    @establishment = Establishment.new establishment_params

    return redirect_to dashboard_establishments_path, notice: 'created' if @establishment.save

    flash.now[:alert] = 'error'
    render :new
  end

  def edit
    @establishment = Establishment.find_by_id params[:id]

    return redirect_to dashboard_establishments_path, alert: 'not found' unless @establishment
  end

  def update
    @establishment = Establishment.find_by_id params[:id]

    if @establishment
      @establishment.update_attributes establishment_params
      return redirect_to dashboard_establishments_path, notice: 'updated'
    end

    flash.now[:alert] = 'error'
    render :edit
  end

  def destroy
    return redirect_to dashboard_establishments_path, alert: 'permision deneged' unless current_identity.user.admin?

    @establishment = Establishment.find_by_id params[:id]

    @establishment.destroy if @establishment

    redirect_to dashboard_establishments_path, notice: 'deleted'
  end

  private

  def establishment_params
    params.require(:establishment).permit(:name)
  end
end
