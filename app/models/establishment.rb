class Establishment < ActiveRecord::Base
  belongs_to :user
  has_many :foods
  has_many :comments
  has_many :images

  accepts_nested_attributes_for :images, allow_destroy: true

  validates_uniqueness_of :name
end
