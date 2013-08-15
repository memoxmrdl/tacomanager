require 'test_helper'

describe Establishment do
  let(:establishment) { Establishment.new }

  describe 'Validations' do
    it 'must be valid' do
      establishment.name = 'Tacos el gordo'

      establishment.valid?.must_equal true
    end

    it 'must be invalid without attributes' do
      establishment.valid?.must_equal false

      establishment.errors.size.must_equal 1
      establishment.errors[:name].wont_be_nil
    end

    it 'musb be invalid with a name unique' do
      Establishment.create name: 'Pizza Koket'

      establishment.name = 'Pizza Koket'

      establishment.valid?.must_equal false
      establishment.errors[:name].wont_be_nil
    end
  end

  describe 'Methods' do
    it 'must be records when establishment is mine?' do
      establishment = establishments(:one)

      Establishment.is_mine?(users(:user), establishment).must_equal establishment
    end

    it 'must be a establishment information valid' do
      establishment = establishments(:one)

      establishment.info_valid?.must_equal true
    end

    it 'must be a establishment information invalid' do
      establishment = establishments(:two)

      establishment.info_valid?.must_equal false
    end
  end
end
