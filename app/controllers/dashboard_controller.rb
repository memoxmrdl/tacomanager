class DashboardController < ApplicationController
  before_filter :authenticate!

  private

  def redirect_message(model, saved, key='')
    if !model
      { alert: 'not_found' }
    elsif saved
      { notice: "#{key}" }
    end || {}
  end
end
