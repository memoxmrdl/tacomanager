class ApplicationController < ActionController::Base
  before_action :set_locale

  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?, :warden

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  protected

  def warden
    request.env['warden']
  end

  def current_user
    @current_user ||= warden.user(scope: :user)
  end

  def signed_in?
    warden.authenticate?(scope: :user)
  end

  def authenticate!
    redirect_to root_path, notice: 'hubo problemas' unless signed_in?
  end
end
