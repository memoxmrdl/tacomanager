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
    @food.build_image
  end

  def create
    @establishment = Establishment.find_by_id params[:establishment_id]

    return redirect_to dashboard_establishment_foods_path, alert: t('.not_found') unless @establishment

    @food = Food.new params_food.except(:image)
    @food.image = Image.new image: params[:food][:image]
    @food.establishment = @establishment

    return redirect_to dashboard_establishment_path(id: @establishment.id), notice: t('.created') if @food.save

    flash.now[:alert] = t('.error')
    render :new
  end

  def edit
    return redirect_to dashboard_establishment_foods_path, alert: t('.not_found') unless @food
  end

  def update
    @food.image.update_attribute(:image, params[:food][:image]) if params[:food][:image]

    if @food.update_attributes params_food.except(:image)
      return redirect_to dashboard_establishment_path(id: params[:establishment_id]), notice: t('.updated')
    end

    flash.now[:alert] = @food.errors.inspect
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
    params.require(:food).permit :name, :price, :description, :image
  end
end
