class Identity < ActiveRecord::Base
  validates :uid, :provider, :username, presence: true

  scope :my_identity, -> (uid, provider) { where(uid: uid, provider: provider) }

  class << self
    def create_with_omniauth(auth)
      create! do |identity|
        identity.provider = auth['provider']
        identity.uid = auth['uid']
        identity.username = auth['info']['nickname']
        identity.email = auth['info']['email']
      end
    end
  end
end
