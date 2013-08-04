require "test_helper"

describe Establishment do
  let(:establishment) { Establishment.new }
  let(:user) { users(:user) }

  describe 'Validations' do
    it 'must be valid' do
      establishment.name = 'La puerta negra'
      establishment.telephones = '312324567'
      establishment.address = 'Av. Tecnologico #125, Colonia Centro'
      establishment.user = user

      establishment.valid?.must_equal true
    end

    it 'must be invalid without attributes' do
      establishment.valid?.must_equal false

      establishment.errors.size.must_equal 3
      establishment.errors[:name].wont_be_nil
      establishment.errors[:user_id].wont_be_nil
      establishment.errors[:telephones].wont_be_nil
      establishment.errors[:address].wont_be_nil
    end

    it 'musb be invalid with a name unique' do
      Establishment.create do |e|
        e.name = 'El gordo'
        e.telephones = '312332434'
        e.address = 'Av. Sancho'
        e.user = user
      end

      establishment.name = 'El gordo'
      establishment.telephones = '312332434'
      establishment.address = 'Av. Sancho'
      establishment.user = user

      establishment.valid?.must_equal false
      establishment.errors[:name].wont_be_nil
    end
  end
end
