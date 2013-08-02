class Authorization < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  scope :find_from_hash,
    -> (hash) { where(uid: hash['uid'], provider: hash['provider']) }

  class << self
    def create_from_hash(hash, user = nil)
      user ||= User.create_from_hash!(hash)

      create! do |authorization|
        authorization.user = user
        authorization.uid = hash['uid']
        authorization.provider = hash['provider']
      end
    end
  end
end
