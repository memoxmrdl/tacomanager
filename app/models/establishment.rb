class Establishment < ActiveRecord::Base
  has_one :address
  has_many :foods
  has_many :orders
  has_many :comments
  has_many :images
  belongs_to :user

  acts_as_votable

  validates_uniqueness_of :name
  validates_presence_of :name

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :address

  def info_valid?
    valid_estab = foods.count > 0 && !(self.schedule.empty? && self.phone.empty?)
    valid_addrs = !(address.latitude.nil? && address.longitude.nil?)
    valid_estab && valid_addrs
  end
end
