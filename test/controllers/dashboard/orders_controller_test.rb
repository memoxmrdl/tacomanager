require "test_helper"

describe Dashboard::OrdersController do
  let(:order) { orders(:one) }
  let(:params) { { name: 'Tragones' } }
  let(:establishment) { establishments(:one) }

  describe 'POST create' do
    it 'should create a order' do
      login_user

      post :create, establishment_id: establishment.id, order: params

      order_last = Order.last
      must_redirect_to dashboard_establishment_order_path(id: order_last.id)
      flash[:notice].wont_be_nil
    end

    it 'should not create when a establishment not exists' do
      login_user

      post :create, establishment_id: 300, order: params

      must_redirect_to dashboard_establishments_path()
      flash[:alert].wont_be_nil
    end
  end

  describe 'GET show' do
    it 'should display a order' do
      login_user

      establishment.foods.first.image =  Image.new image: File.new(Rails.root + 'test/fixtures/images/fixtures.jpg')
      establishment.save

      get :show, establishment_id: establishment.id, id: order.id

      must_response_with :success
      must_render_template :show
    end

    it 'should not display a order when not exists' do
      login_user

      get :show, establishment_id: establishment.id, id: 300

      must_redirect_to dashboard_root_path
      flash[:alert].wont_be_nil
    end
  end

  describe 'PUT update' do
    it 'should update name that an order' do
      login_user

      #put :update, id: order.id, order: { name: 'La preferidad' }
      xhr :put, :update, establishment_id: establishment.id, id: order.id, order: { name: 'La preferidad' }

    end

    it 'should update invalid params' do
      login_user

      xhr :put, :update, establishment_id: establishment.id, id: order.id, order: { name: '' }

    end
  end

  describe 'DELETE destroy' do
    it 'should delete valid order' do
      login_user

      delete :destroy, establishment_id: establishment.id, id: order.id

      must_redirect_to dashboard_establishments_path
      flash[:notice].wont_be_nil
    end

    it 'should delete invalid order' do
      login_user

      delete :destroy, establishment_id: establishment.id, id: 203

      must_redirect_to dashboard_root_path
      flash[:alert].wont_be_nil
    end
  end
end
