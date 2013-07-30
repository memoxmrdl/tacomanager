class ApplicationController < ActionController::Base
  before_action :set_locale

  protect_from_forgery with: :exception

  helper_method :current_identity, :identity_signed_in?, :warden

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  protected

  def warden
    request.env['warden']
  end

  def current_identity
    warden.user(scope: :identity)
  end

  def identity_signed_in?
    warden.authenticate?(scope: :identity)
  end

  def authenticate!
    redirect_to root_path, notice: 'hubo problemas' unless identity_signed_in?
  end
end
