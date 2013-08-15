class Dashboard::ImageController < DashboardController
  def create
    @image = Image.new
    @image.establishment_id = params[:establishment][:id]
    @image.image = params[:establishment][:image]
    @image.save

    redirect_to dashboard_establishment_path(id: params[:establishment][:id])
  end
end
