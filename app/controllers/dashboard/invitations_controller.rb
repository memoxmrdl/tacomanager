class Dashboard::InvitationsController < DashboardController
  def new
    @users = User.all
  end

  def create
  end
end
