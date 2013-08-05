require "test_helper"

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
end
