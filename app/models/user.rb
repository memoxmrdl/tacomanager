class User < ActiveRecord::Base
  has_many :authorizations
  has_many :establishments
  has_one :image
  has_many :comments

  has_many :order_details
  has_many :orders, through: :order_details

  validates_presence_of :nickname, :email
  validates_uniqueness_of :email

  acts_as_voter

  class << self
    def create_from_hash!(hash)
      create! do |user|
        user.nickname = hash['info']['nickname']
        user.email = hash['info']['email']
      end
    end
  end
end
