class SessionsController < ApplicationController
  def create
    warden.authenticate!(scope: :authorization)
    unless session[:invitation].nil?
      url_magic = session[:invitation]
      session[:invitation] = nil
      return redirect_to "#{url_magic}", notice: 'Bienvenido empieze a ordernar'
    end
    redirect_to dashboard_root_path
  end

  def destroy
    warden.logout(:authorization)
    redirect_to root_url
  end
end
