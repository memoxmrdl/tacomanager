class Dashboard::InvitationsController < DashboardController
  def new
    @users = User.all
  end

  def create
    users = User.where(id: params[:user_ids])

    users.each do |user|
      InvitationMailer.invitation_order(
        user,
        current_identity.user.nickname,
        dashboard_establishment_order_path(id: params[:order_id], host: 'tacomanager.com')).deliver
    end

    redirect_to dashboard_establishment_order_path(id: params[:order_id]), notice: t('.invited')
  end
end
