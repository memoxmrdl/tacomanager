class SessionsController < ApplicationController
  def create
    warden.authenticate!(scope: :authorization)
    redirect_to root_url
  end

  def destroy
    warden.logout(:authorization)
    redirect_to root_url
  end
end
