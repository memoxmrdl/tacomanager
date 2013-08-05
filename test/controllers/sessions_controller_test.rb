require "test_helper"

describe SessionsController do
  let(:params) { { 'provider' => 'github', 'uid' => '11223344',
      'info' => { 'nickname' => 'Test user', 'email' => 'test@user.com' }
    }  }

  describe 'create' do
    it 'success authentication first time user' do
      @controller.request.env['omniauth.auth'] = params

      post :create

      must_redirect_to dashboard_root_path
      Authorization.find_from_hash(params).wont_be_empty
    end

    it 'success authentication for returning user' do
      Authorization.create_from_hash(params)
      @controller.request.env['omniauth.auth'] = params

      post :create

      must_redirect_to dashboard_root_path
    end

    it 'rejected authorization' do
      auth = Authorization.create_from_hash(params)
      auth.tap do |a|
        a.user.blocked = true
        a.user.save
        a.save
      end

      @controller.request.env['omniauth.auth'] = params

      lambda { post :create }.must_raise(ArgumentError)
    end
  end

  describe 'destroy' do
    it 'success logout' do
      delete :destroy

      must_redirect_to root_url
    end
  end
end
