class DashboardController < ApplicationController
  before_filter :authenticate!
  before_filter :redirect_invitation?

  private
  def redirect_invitation?
    redirect_to params[:invitation] if params[:invitation]
  end

  def redirect_message(model, saved, key = '')
    if !model
      { alert: 'not_found' }
    elsif saved
      { notice: "#{key}" }
    end || {}
  end
end
