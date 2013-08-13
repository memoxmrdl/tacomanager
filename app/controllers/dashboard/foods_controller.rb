class Dashboard::FoodsController < DashboardController
  before_filter :food_find_by_id_and_establishment_id, except: [:index, :create]

  def index
    @foods = Food.find_by_establishment_id params[:establishment_id]
  end

  def show
    return redirect_to dashboard_establishment_foods_path, alert: 'not found' unless @food
  end

  def new
    @food = Food.new
  end

  def create
    @establishment = Establishment.find_by_id params[:establishment_id]

    return redirect_to dashboard_establishment_foods_path, alert: t('.not_found') unless @establishment

    @food = Food.new params_food
    @food.image = Image.new image: params[:food][:image]
    @food.establishment = @establishment

    return redirect_to dashboard_establishment_path(id: @establishment.id), notice: t('.created') if @food.save

    flash.now[:alert] = t('.error')
    render :new
  end

  def edit
    return redirect_to dashboard_establishment_foods_path, alert: 'not found' unless @food
  end

  def update
    if @food.update_attributes params_food
      return redirect_to dashboard_establishment_foods_path, notice: 'updated'
    end

    flash.now[:alert] = 'error'
    render :edit
  end

  def destroy
    @food.destroy if @food

    redirect_to dashboard_establishment_foods_path, notice: 'deleted'
  end

  private

  def food_find_by_id_and_establishment_id
    @food = Food.find_by_id_and_establishment_id params[:id], params[:establishment_id]
  end

  def params_food
    params.require(:food).permit :name, :price, :description
  end
end
