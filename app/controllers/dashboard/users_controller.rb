class Dashboard::UsersController < DashboardController
  before_filter :super_admin?

  def index
    @users = User.where.not(id: current_identity.user.id)
  end

  def update
    return redirect_to dashboard_users_path, alert: t('.error') unless params[:user_ids]

    params[:user_ids].each do |user|
      User.find(user).update_column(:blocked, true)
    end

    redirect_to dashboard_users_path, notice: t('.updated')
  end

  protected

  def super_admin?
    redirect_to dashboard_root_path, alert: t('.not_access') unless current_identity.user.admin?
  end
end
