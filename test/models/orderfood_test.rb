require "test_helper"

describe Orderfood do
  let(:orderfood) { Orderfood.new }
  let(:food) { foods(:one) }
  let(:order) { orders(:one) }

  describe 'Assoctiations' do
    it 'must be it have a food and order' do
      orderfood.food = food
      orderfood.order = order

      orderfood.valid?.must_equal true
    end
  end
end
