require "test_helper"

describe Dashboard::DashboardController do
  describe 'GET index' do
    it 'verify authenticate when a user is logged' do
      login_user

      get :index

      must_response_with :success
      must_render_template :index
    end

    it 'verify authenticate when a user is not logged' do
      get :index

      must_redirect_to root_path
      flash[:alert].wont_be_nil
    end
  end
end
