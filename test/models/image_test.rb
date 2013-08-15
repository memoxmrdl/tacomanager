require 'test_helper'

describe Image do
  let(:image) { Image.new }

  it 'must be valid' do
    image = Image.new image: File.new(Rails.root + 'test/fixtures/images/fixtures.jpg')

    image.valid?.must_equal true
  end
end
