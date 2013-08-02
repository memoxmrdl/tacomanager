class User < ActiveRecord::Base
  has_many :authorizations
  has_many :establishments
  has_one :image

  validates_uniqueness_of :email

  class << self
    def create_from_hash!(hash)
      create(nickname: hash['info']['nickname'], email: hash['info']['email'])
    end
  end
end
