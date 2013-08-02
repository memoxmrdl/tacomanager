require "test_helper"

describe Authorization do
  let(:authorization) { Authorization.new }
  let(:user) { users(:user) }
  let(:auth) { auth = { "provider" => 'github', "uid" => '33453344',
    "info" => { "nickname" => 'test_user', "email" => 'test@user.com' } } }

  describe 'Validations' do
    it 'must be valid' do
      authorization.uid = '1223445'
      authorization.provider = 'github'
      authorization.user = user

      authorization.valid?.must_equal true
    end

    it 'must be invalid without attributes' do
      authorization.valid?.must_equal false

      authorization.errors.size.must_equal 3
      authorization.errors[:user_id].wont_be_nil
      authorization.errors[:uid].wont_be_nil
      authorization.errors[:provider].wont_be_nil
    end

    it 'must be uniqued' do
      Authorization.create user: user, uid: '1223445', provider: 'github'

      authorization.uid = '1223445'

      authorization.valid?.must_equal false
      authorization.errors[:uid].wont_be_nil
    end
  end

  describe 'Scope' do
    it 'must be find with valid auth' do
      auth['uid'] = '1234556'

      authorization = Authorization.find_from_hash(auth)

      authorization.size.must_equal 1
      authorization.first.must_be_kind_of Authorization
    end

    it 'must be find with invalid auth' do
      lambda { Authorization.find_from_hash }.must_raise ArgumentError
      lambda { Authorization.find_from_hash([]) }.must_raise TypeError
    end
  end

  describe 'Method instance create_from_hash' do
    it 'must be create with valid auth' do
      authorization = Authorization.create_from_hash(auth)

      authorization.valid?.must_equal true
    end

    it 'must be create other authorization with Twitter provider when a user had more' do
      auth['uid'] = '1234542'
      auth['provider'] = 'twitter'

      authorization = Authorization.create_from_hash(auth, user)

      authorization.valid?.must_equal true
      user.authorizations.size.must_equal 2
    end

    it 'must be create with invalid auth' do
      lambda { Authorization.create_from_hash }.must_raise ArgumentError
      lambda { Authorization.create_from_hash([]) }.must_raise TypeError
    end
  end
end