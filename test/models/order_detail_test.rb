require "test_helper"

describe OrderDetail do
  let(:order_detail) { OrderDetail.new }

  describe 'Validates' do
    it 'must be valid' do
      order_detail.quantity = 2
      order_detail.food = Food.new name: 'Torta', price: '12', establishment_id: 100

      order_detail.valid?.must_equal true
    end

    it 'must be invalid' do
      order_detail.valid?.must_equal false

      order_detail.errors.size.must_equal 1
      order_detail.errors[:price].wont_be_nil
    end
  end

  describe 'Methods' do
    it 'must get subtotal' do
      order_detail = order_details(:one)

      order_detail.calculate_subtotal.must_equal 48
    end
  end
end
