class Dashboard::DashboardController < DashboardController
  before_action :get_info_dashboard

  def index
  end

  protected

  def get_info_dashboard
    @establishments = Establishment.my_current_establishments current_identity.user
    @orders = Order.my_current_orders current_identity.user
  end
end
