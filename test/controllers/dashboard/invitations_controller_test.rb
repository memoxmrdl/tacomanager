require "test_helper"

describe Dashboard::InvitationsController do
  let(:params) { [100, 101]  }
  let(:establishment) { establishments(:one) }

  describe 'GET new' do
    it 'must form render users for send invitation' do
      login_user

      get :new, establishment_id: establishment.id, order_id: establishment.orders.first.id

      must_response_with :success
      must_render_template :new
    end
  end

  describe 'POST create' do
    it 'must send invitation to users' do
      login_user

      post :create, establishment_id: establishment.id, order_id: establishment.orders.first.id, user_ids: params

      must_response_with :redirect
    end
  end
end
