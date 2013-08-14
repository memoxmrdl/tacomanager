require "test_helper"

describe Dashboard::EstablishmentsController do
  let(:establishment) {
    establishments(:one)
  }

  let(:params) { { name: 'Don panchito', 
    address_attributes: { street: 'Av. Constitucion #24', city: 'Colima',
    state: 'Colima', country: 'Mexico', zip_code: '28917' } }  }

  describe 'GET index' do
    it 'should display all establishments for logged user' do
      login_user

      get :index

      must_response_with :success
      must_render_template :index
    end

    it 'should not display all establishments when not logged user' do
      get :index

      must_redirect_to root_path
      flash[:alert].wont_be_nil
    end
  end

  describe 'GET new' do
    it 'should display new form establishment for logged user' do
      login_user

      get :new

      must_response_with :success
      must_render_template :new
    end

    it 'should redirect to establishment whent not logged user' do
      get :new

      must_redirect_to root_path
      flash[:alert].wont_be_nil
    end
  end

  describe 'GET show' do
    it 'should show establishment for that all users to be logged' do
      login_user

      get :show, id: establishment.id

      must_response_with :success
      must_render_template :show
    end

    it 'should not show establishment when not logged user' do
      get :show, id: establishment.id

      must_redirect_to root_path
      flash[:alert].wont_be_nil
    end
  end

  describe 'POST create' do
    it 'should create new establishment for logged user' do
      login_user

      post :create, establishment: params

      must_redirect_to dashboard_establishments_path
      flash[:notice].wont_be_nil
    end

    it 'should not created when params are invalid' do
      login_user

      invalid_params = params.merge({ name: '' })

      post :create, establishment: invalid_params

      must_response_with :success
      must_render_template :new
      flash.now[:alert].wont_be_nil
    end
  end

  describe 'GET edit' do
    it 'should edit a establishment when it is that logged user' do
      login_user

      get :edit, id: establishment.id

      must_response_with :success
      must_render_template :edit
    end

    it 'should not edit a establishment when not logged user' do
      get :edit, id: establishment.id

      must_redirect_to root_path
      flash[:alert].wont_be_nil
    end

    it 'should redirect when not exists a establishments' do
      login_user

      get :edit, id: 300

      must_redirect_to dashboard_establishments_path
      flash[:alert].wont_be_nil
    end
  end

  describe 'PUT update' do
    it 'should update a establishment for logged user' do
      login_user

      put :update, id: establishment.id, establishment: params

      must_redirect_to dashboard_establishments_path
      flash[:notice].wont_be_nil
    end

    it 'should not updated when not logged user' do
      put :update, id: establishment.id, establishment: params

      must_redirect_to root_path
      flash[:alert].wont_be_nil
    end

    it 'should render edit when not exists' do
      login_user

      put :update, id: 200, establishment: params

      must_redirect_to dashboard_establishments_path
      flash[:alert].wont_be_nil
    end
  end

  describe 'DELETE destroy' do
    it 'should delete when logged user is admin' do 
      login_user 201

      delete :destroy, id: establishment.id

      must_redirect_to dashboard_establishments_path
      flash[:notice].wont_be_nil

    end
    it 'should not delete when logged user is not admin' do
      login_user

      delete :destroy, id: establishment.id

      must_redirect_to dashboard_establishments_path
      flash[:alert].wont_be_nil
    end
  end
end
