require "test_helper"

describe Dashboard::OrderDetailsController do
  let(:params) { { food_id: 200, quantity: 2 }  }
  let(:order_detail) { order_details(:one)  }

  describe 'POST create' do
    it 'should create a order_details' do
      #login_user

      #post :create, order_id: order_detail.order.id, order_detail: params
    end
  end
end
