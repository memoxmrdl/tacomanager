class Dashboard::DashboardController < DashboardController
  def index
    @establishments = Establishment.where(user: current_identity.user)
    @orders = Order.where(user: current_identity.user)
  end
end
