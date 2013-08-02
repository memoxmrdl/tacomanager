class Orders < ActiveRecord::Base
  has_many :foods
  has_many :orderfoods through: :orderfoods
end
