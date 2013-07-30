class User < ActiveRecord::Base
  has_many :authorizations

  class << self
    def create_from_hash!(hash)
      create(name: hash['user_info']['name'])
    end
  end
end
