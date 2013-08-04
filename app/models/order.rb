class Order < ActiveRecord::Base
  has_many :orderfoods
  has_many :foods, through: :orderfoods

  has_many :orderusers
  has_many :users, through: :orderusers

  validates_presence_of :name
end
