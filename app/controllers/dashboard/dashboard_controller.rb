class Dashboard::DashboardController < DashboardController
  before_action :dashboard

  def index; end

  protected

  def dashboard
    @establishments = Establishment.my_current_establishments current_identity.user
    @orders = Order.my_current_orders current_identity.user
  end
end
