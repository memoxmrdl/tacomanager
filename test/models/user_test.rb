require "test_helper"

describe User do
  let(:user) { User.new }
  let(:auth) { auth = { "provider" => 'github', "uid" => '3345444',
    "info" => { "nickname" => 'test_user', "email" => 'test@user.com' } } }

  describe 'Validations' do
    it 'must be valid' do
      user.nickname = 'user test'
      user.email = 'test@tacomanager.com'

      user.valid?.must_equal true
    end

    it 'must be invalid without attributes' do
      user.valid?.must_equal false

      user.errors.size.must_equal 2
      user.errors[:nickname].wont_be_nil
      user.errors[:email].wont_be_nil
    end

    it 'must be invalid without unique email' do
      User.create nickname: 'test user', email: 'test@tacomanager.com'

      user.nickname = 'user test 2'
      user.email = 'test@tacomanager.com'

      user.valid?.must_equal false
      user.errors[:email].wont_be_nil
    end
  end

  describe 'When user' do
    it 'must be a admin' do
      user = users(:user_admin)

      user.admin?.must_equal true
    end

    it 'must be not a admin' do
      user = users(:user)

      user.admin?.must_equal false
    end
  end

  describe 'Method create_from_hash' do
    it 'must be create with valid auth' do
      user = User.create_from_hash!(auth)

      user.valid?.must_equal true
    end

    it "must be not create with invalid auth" do
      lambda { User.create_from_hash! }.must_raise ArgumentError
      lambda { User.create_from_hash!([]) }.must_raise TypeError
    end
  end
end