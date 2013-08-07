require "test_helper"

describe Dashboard::OrdersController do
  let(:order) { orders(:one) }
  let(:params) { { name: 'Tragones', establishment_id: 100 } }
  let(:establishment) { establishments(:one) }

  describe 'GET index' do
    it 'should display orders that user logged' do
      login_user

      get :index

      must_response_with :success
      must_render_template :index
    end
  end

  describe 'GET new' do
    it 'should render new to create order' do
      login_user

      get :new

      must_response_with :success
      must_render_template :new
    end
  end

  describe 'POST create' do
    it 'should create a order' do
      login_user

      post :create, order: params

      order_last = Order.last
      must_redirect_to dashboard_order_path(id: order_last.id)
      flash[:notice].wont_be_nil
    end

    it 'should create a order with invalid params' do
      login_user

      invalid_params = params.merge({ name:'' })
      post :create, order: invalid_params

      must_response_with :success
      must_render_template :new
    end
  end

  describe 'GET show' do
    it 'should display a order' do
      login_user

      get :show, id: order.id

      must_response_with :success
      must_render_template :show
    end

    it 'should not display a order when not exists' do
      login_user

      get :show, id: 300

      must_redirect_to dashboard_orders_path
      flash[:alert].wont_be_nil
    end
  end

  describe 'GET edit' do
    it 'should render edit' do
      login_user

      get :edit, id: order.id

      must_response_with :success
      must_render_template :edit
    end

    it 'should not render edit whe not exists' do
      login_user

      get :edit, id: 300

      must_redirect_to dashboard_orders_path
      flash[:alert].wont_be_nil
    end
  end

  describe 'PUT update' do
    it 'should update name that an order' do
      login_user

      put :update, id: order.id, order: { name: 'La preferidad' }

      must_redirect_to dashboard_orders_path
      flash[:notice].wont_be_nil
    end

    it 'should update invalid params' do
      login_user

      put :update, id: order.id, order: { name: '' }

      must_response_with :success
      must_render_template :edit
    end
  end

  describe 'DELETE destroy' do
    it 'should delete valid order' do
      login_user

      delete :destroy, id: order.id

      must_redirect_to dashboard_orders_path 
      flash[:notice].wont_be_nil
    end

    it 'should delete invalid order' do
      login_user

      delete :destroy, id: 203

      must_redirect_to dashboard_orders_path
      flash[:alert].wont_be_nil
    end
  end
end
