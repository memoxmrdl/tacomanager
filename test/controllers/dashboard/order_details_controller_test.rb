require "test_helper"

describe Dashboard::OrderDetailsController do
  let(:params) { { food_id: 200, quantity: 2 }  }
  let(:order_detail) { OrderDetails.create user_id: 100, order_id: 100,
    food_id: 100, quantity: 1, subtotal: 24.00  }

  describe 'POST create' do
    it 'should create with valid params' do
      login_user

      xhr :post, :create, order_id: 100, order_details: params

      must_response_with :success
      must_render_template :create
    end

    it 'should not create with invalid params' do
      login_user

      invalid_params = params.merge({ quantity: -1 })
      xhr :post, :create, order_id: 100, order_details: invalid_params

      must_response_with :success
      must_render_template :create
    end
  end

  describe 'PUT update' do
    it 'should update with valid params' do
      login_user

      update_params = params.merge({ quantity: 10 })
      xhr :put, :update, order_id: 100, id: order_detail.id, order_details: update_params

      must_response_with :success
      must_render_template :update
    end

    it 'should not update with invalid params' do
      login_user

      invalid_params = params.merge({ quantity: -2 })
      xhr :put, :update, order_id: 100, id: order_detail.id, order_details: invalid_params

      must_response_with :success
      must_render_template :update
    end
  end

  describe 'DELETE destroy' do
    it 'should delete an order details' do
      login_user

      xhr :delete, :destroy, order_id: 100, id: order_detail.id

      must_response_with :success
      must_render_template :destroy
    end
  end
end
