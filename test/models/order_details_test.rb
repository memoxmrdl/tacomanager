require "test_helper"

describe OrderDetails do
  let(:order_details) { OrderDetails.new }

  describe 'Validations' do
    it 'must be valid' do
      order_details.quantity = 1
      order_details.subtotal = 10

      order_details.valid?.must_equal true
    end

    it 'must be invalid without attributes' do
      order_details.valid?.must_equal false

      order_details.errors.size.must_equal 1
      order_details.errors[:quantity].wont_be_nil
    end

    it 'must be invalid with less that quantity' do
      order_details.quantity = 0

      order_details.valid?.must_equal false
    end
  end
end
