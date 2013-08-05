require "test_helper"

describe Food do
  let(:food) { Food.new }

  describe 'Validations' do
    it 'must be valid' do
      food.name = 'Hot dogo'
      food.price = '12.00'

      food.valid?.must_equal true
    end

    it 'must be invalid without attributes' do
      food.valid?.must_equal false

      food.errors.size.must_equal 3
      food.errors[:name].wont_be_nil
      food.errors[:price].wont_be_nil
    end

    it 'must be invalid when a price is less than 0' do
      food.name = 'Taco de asada'
      food.price = -1

      food.valid?.must_equal false
    end
  end
end
