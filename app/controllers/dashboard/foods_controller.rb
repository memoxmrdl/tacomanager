class Dashboard::FoodsController < DashboardController
  def index
    @foods = Food.where establishment_id: params[:establishment_id]
  end

  def show
    @food = Food.find_by_id_and_establishment_id(params[:id], params[:establishment_id])

    return redirect_to dashboard_establishment_foods_path, alert: 'not found' unless @food
  end

  def new
    @food = Food.new
  end

  def create
    @establishment = Establishment.find_by_id(params[:establishment_id])

    return redirect_to dashboard_establishment_foods_path, alert: 'not exists' unless @establishment

    @food = Food.new params_food
    @food.establishment = @establishment

    return redirect_to dashboard_establishment_foods_path, notice: 'created' if @food.save

    flash.now[:alert] = 'error'
    render :new
  end

  def edit
    @food = Food.find_by_id_and_establishment_id(params[:id], params[:establishment_id])

    return redirect_to dashboard_establishment_foods_path, alert: 'not found' unless @food
  end

  def update
    @food = Food.find_by_id_and_establishment_id(params[:id], params[:establishment_id])

    if @food.update_attributes params_food
      return redirect_to dashboard_establishment_foods_path, notice: 'updated'
    end

    flash.now[:alert] = 'error'
    render :edit
  end

  def destroy
    @food = Food.find_by_id_and_establishment_id(params[:id], params[:establishment_id])

    @food.destroy if @food

    redirect_to dashboard_establishment_foods_path, notice: 'deleted'
  end

  private

  def params_food
    params.require(:food).permit(:name, :price, :description)
  end
end
