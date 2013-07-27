class ApplicationController < ActionController::Base
  before_action :set_locale
  protect_from_forgery with: :exception

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
