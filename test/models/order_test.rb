require "test_helper"

describe Order do
  let(:order) { Order.new }

  describe 'Validations' do
    it 'must be valid' do
      order.name = 'New order'

      order.valid?.must_equal true
    end
  end

  describe 'Callbacks' do
    it 'must get first id when it is new' do
      order.save

      order.name.must_equal "Orden ##{Order.last.id}"
    end

    it 'must check payment if one order have some foods was pay' do
      order.save

      order.payment = true
      order.save

      order.errors.size.must_equal 1
      order.errors[:payment].wont_be_nil
    end

    it 'must be correct when change payment and foods have payment true' do
      order = orders(:one)

      order.payment = true
      order.save

      order.valid?.must_equal true
    end
  end
end
