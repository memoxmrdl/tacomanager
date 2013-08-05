require "test_helper"

describe Address do
  let(:address) { Address.new }

  it 'must be valid' do
    address.street = 'Av. Insurgentes #456'
    address.city = 'Villa de Alvarez'
    address.state = 'Colima'
    address.country = 'Mexico'
    address.zip_code = '28017'

    address.valid?.must_equal true
  end

  it 'must be valid within attributes' do
    address.valid?.must_equal true
  end
end
