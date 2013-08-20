require "test_helper"

describe Dashboard::OrderDetailsController do
  let(:params) { { food_id: 200, quantity: 2 }  }
  let(:order_detail) { OrderDetail.create user_id: 100, order_id: 100,
    food_id: 200, quantity: 1  }

  describe 'POST create' do
    it 'should create with valid params' do
      login_user

      xhr :post, :create, establishment_id: 100, order_id: 100, order_details: params

      must_response_with :success
      must_render_template :create
    end

    it 'should not create with invalid params' do
      login_user

      invalid_params = params.merge({ quantity: -1 })
      xhr :post, :create, establishment_id: 100, order_id: 100, order_details: invalid_params

      must_response_with :success
      must_render_template :create
    end
  end

  describe 'PUT update' do
    it 'should update with valid params' do
      login_user

      update_params = params.merge({ quantity: 10 })
      xhr :put, :update, establishment_id: 100, order_id: 100, id: order_detail.id, order_details: update_params

      must_response_with :success
      must_render_template :update
    end

    focus
    it 'should not update with invalid params' do
      login_user

      invalid_params = params.merge({ quantity: -2 })
      xhr :put, :update, establishment_id: 100, order_id: 100, id: order_detail.id, order_details: invalid_params

      puts "#{response.inspect}"
      must_response_with :unprocessable_entity
      must_render_template :update
    end
  end

  describe 'DELETE destroy' do
    it 'should delete an order details' do
      login_user

      xhr :delete, :destroy, establishment_id: 100, order_id: 100, id: order_detail.id

      must_response_with :success
      must_render_template :destroy
    end
  end
end
