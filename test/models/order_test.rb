require "test_helper"

describe Order do
  let(:order) { Order.new }

  describe 'Validations' do
    it 'must be valid' do
      order.name = 'New order'

      order.valid?.must_equal true
    end

    it 'must be invalid without attributes' do
      order.valid?.must_equal false

      order.errors.size.must_equal 1
      order.errors[:name].wont_be_nil
    end
  end
end
