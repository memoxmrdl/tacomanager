class DashboardController < ApplicationController
  before_filter :authenticate!

  protected

  def get_info_dashboard
    @establishments = Establishment.where(user: current_identity.user)
    @orders = Order.where(user: current_identity.user)
  end

  private

  def redirect_message(model, saved, key='')
    if !model
      { alert: 'not_found' }
    elsif saved
      { notice: "#{key}" }
    end || {}
  end
end
