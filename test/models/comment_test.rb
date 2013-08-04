require "test_helper"

describe Comment do
  let(:comment) { Comment.new }
  let(:establishment) { establishments(:one) }

  describe 'Validations' do
    it 'must be valid' do
      comment.comment = 'this is food good'
      comment.establishment = establishment

      comment.valid?.must_equal true
    end

    it 'must be invalid without attributes' do
      comment.valid?.must_equal false

      comment.errors[:establishment_id].wont_be_nil
    end
  end
end
