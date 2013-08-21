require "test_helper"

describe Dashboard::FoodsController do
  let(:establishment) { establishments(:one)  }
  let(:food) { Food.create name: 'Taco de asada',
               price: 12.00, description: 'Bistec a la parrilla',
               establishment_id: 100 }
  let(:params) { { name: 'Taco de adobada', price: 14.00, description: 'good taco' }  }

  describe 'GET index' do
    it 'should displays foods of a establishment with logged user' do
      login_user

      get :index, establishment_id: establishment.id

      must_response_with :success
      must_render_template :index
    end

    it 'should not display foods when not logged user' do
      get :index, establishment_id: establishment.id

      must_redirect_to root_path
      flash[:alert].wont_be_nil
    end
  end

  describe 'GET new' do
    it 'should render new when logged user' do
      login_user

      get :new, establishment_id: establishment.id

      must_response_with :success
      must_render_template :new
    end

    it 'should not render when not logged user' do
      get :new, establishment_id: establishment.id

      must_redirect_to root_path
      flash[:alert].wont_be_nil
    end
  end

  describe 'POST create' do
    it 'should created a new food when logged user' do
      login_user

      post :create, establishment_id: establishment.id, food: params

      must_redirect_to dashboard_establishment_path(id: establishment.id)
      flash[:notice].wont_be_nil
    end

    it 'should redirect with a message when not exists establishment' do
      login_user

      post :create, establishment_id: 300, food: params

      must_redirect_to dashboard_establishments_path
      flash[:alert].wont_be_nil
    end

    it 'should render new when food params is incorrect' do
      login_user

      invalid_params = params.merge({ name:'', price: -1 })
      post :create, establishment_id: establishment.id, food: invalid_params

      must_response_with :success
      must_render_template :new
    end
  end

  describe 'GET edit' do
    it 'should render edit when logged user and exists a food ' do
      login_user

      get :edit, establishment_id: establishment.id, id: food.id

      must_response_with :success
      must_render_template :edit
    end

    it 'should render edit when not exists' do
      login_user

      get :edit, establishment_id: establishment.id, id: 400

      must_redirect_to dashboard_establishment_path(id: establishment.id)
      flash[:notice].wont_be_nil
    end

    it 'should redirect when not logged user' do
      get :edit, establishment_id: establishment.id, id: food.id

      must_redirect_to root_path
      flash[:alert].wont_be_nil
    end
  end

  describe 'PUT update' do
    it 'should update when logged user' do
      login_user

      get :update, establishment_id: establishment.id, id: food.id, food: params

      must_redirect_to dashboard_establishment_path(id: establishment.id)
      flash[:notice].wont_be_nil
    end

    it 'should update when not logged user' do
      get :update, establishment_id: establishment.id, id: food.id, food: params

      must_redirect_to root_path
      flash[:alert].wont_be_nil
    end

    it 'should update with invalid params' do 
      login_user

      invalid_params = params.merge({ name:'', price: -1 })

      get :update, establishment_id: establishment.id, id: food.id, food: invalid_params

      must_response_with :success
      must_render_template :edit
      flash[:alert].wont_be_nil
    end
  end

  describe 'DELETE destroy' do
    it 'should delete a food when for logged user' do
      login_user

      delete :destroy, establishment_id: establishment.id, id: food.id

      must_redirect_to dashboard_establishment_foods_path
      flash[:notice].wont_be_nil
    end

    it 'should not delete when not logged user' do
      delete :destroy, establishment_id: establishment.id, id: food.id

      must_redirect_to root_path
      flash[:alert].wont_be_nil
    end
  end
end
