class HomeController < ApplicationController
  before_filter :redirect_dashboard

  def index
    session[:invitation] ||= params[:invitation]
  end

  protected

  def redirect_dashboard
    redirect_to dashboard_root_path if signed_in?
  end
end
