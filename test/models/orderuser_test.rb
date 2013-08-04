require "test_helper"

describe Orderuser do
  let(:orderuser) { Orderuser.new }
  let(:order) { orders(:one) }
  let(:user) { users(:user) }

  describe 'Associatons' do
    it 'must be it have a order and user' do
       orderuser.user = user
       orderuser.order = order

       orderuser.valid?.must_equal true
    end
  end
end
