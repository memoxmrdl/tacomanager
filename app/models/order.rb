class Order < ActiveRecord::Base
  has_many :orderfoods
  has_many :foods, through: :orderfoods
end
