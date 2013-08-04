require "test_helper"

describe Food do
  let(:food) { Food.new }
  let(:food1) { foods(:one) }
  let(:establishment) { establishments(:one) }

  describe 'Validations' do
    it 'must be valid' do
      food.name = 'Taco de asada'
      food.price = '12.00'
      food.establishment = establishment

      food.valid?.must_equal true
    end

    it 'must be invalid  without attributes' do
      food.valid?.must_equal false

      food.errors.size.must_equal 4
      food.errors[:name].wont_be_nil
      food.errors[:price].wont_be_nil
      food.errors[:establishment_id].wont_be_nil
    end

    it 'must be invalid when a price is less than 0' do
      food1.price = -1

      food1.valid?.must_equal false
      food1.errors[:price].wont_be_nil
    end
  end
end
