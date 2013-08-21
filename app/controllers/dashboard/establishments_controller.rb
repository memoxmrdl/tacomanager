class Dashboard::EstablishmentsController < DashboardController
  before_filter :establishment_find_by_id, only: [:show, :destroy]
  before_filter :is_mine?, only: [:edit, :update]
  before_filter :is_admin?, only: :destroy
  before_filter :prepare, only: :show

  def index
    @establishments = Establishment.all
  end

  def new
    @establishment = Establishment.new
    @establishment.build_address
  end

  def show; end

  def create
    @establishment = current_identity.user
      .establishments
      .create(params_establishment)
    @establishment.build_address params_address

    return redirect_to dashboard_establishments_path, notice: t('.created') if @establishment.save

    flash.now[:alert] = t('.error')
    render :new
  end

  def edit; end

  def update
    if @establishment
      @establishment.address.update params_address
      updated = @establishment.update params_establishment
    end

    message = redirect_message @establishment, updated, t('.updated')
    return redirect_to dashboard_establishment_path(id: @establishment.id), message unless message.empty?

    flash.now[:alert] = t('.error')
    render :edit
  end

  def destroy
    deleted = @establishment.destroy if @establishment
    message = redirect_message @establishment, deleted, t('.deleted')

    redirect_to dashboard_establishments_path, message
  end

  private

  def prepare
    @order = Order.new
    @comment = Comment.new
    @foods = Food.where(establishment_id: params[:id])
  end

  def is_admin?
    return redirect_to dashboard_establishments_path, alert: t('.not_permision') unless current_identity.user.admin? 
  end

  def is_mine?
    @establishment = Establishment.is_mine? params[:id], current_identity.user

    return redirect_to dashboard_establishments_path, alert: t('.not_access') unless @establishment
  end

  def establishment_find_by_id
    @establishment = Establishment.find_by_id params[:id]

    return redirect_to dashboard_establishments_path, alert: t('.not_found') unless @establishment
  end

  def params_address
    params.require(:establishment).require(:address_attributes).permit(:street, :city, :state, :country, :zip_code)
  end

  def params_establishment
    params.require(:establishment).permit(:name, :schedule, :phone)
  end
end
