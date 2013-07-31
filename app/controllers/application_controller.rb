class ApplicationController < ActionController::Base
  layout :set_layout
  before_action :set_locale

  protect_from_forgery with: :exception
  helper_method :current_identity, :signed_in?, :warden

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_layout
    signed_in? ? 'dashboard' : 'application'
  end

  protected

  def warden
    request.env['warden']
  end

  def current_identity
    warden.user(scope: :authorization)
  end

  def signed_in?
    warden.authenticate?(scope: :authorization)
  end

  def authenticate!
    redirect_to root_path, notice: 'hubo problemas' unless signed_in?
  end
end
