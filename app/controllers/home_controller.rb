class HomeController < ApplicationController
  def index
    session[:invitation] ||= params[:invitation]
  end
end
