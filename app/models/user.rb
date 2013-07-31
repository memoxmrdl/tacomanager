class User < ActiveRecord::Base
  has_many :authorizations

  class << self
    def create_from_hash!(hash)
      create(nickname: hash['info']['nickname'].to_s)
    end
  end
end
