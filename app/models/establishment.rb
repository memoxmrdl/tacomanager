class Establishment < ActiveRecord::Base
  has_one :address, dependent: :destroy
  has_many :foods, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  belongs_to :user

  acts_as_votable

  validates :name, presence: true, uniqueness: true

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :address

  scope :my_current_establishments,
    -> (user) { where(user: user) }

  def self.is_mine?(id, user)
    begin
      where(user_id: user.id).find(id)
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

  def info_valid?
    valid_estab = foods.count > 0 && !(self.schedule.empty? || self.phone.empty?)
    valid_addrs = !(address.latitude.nil? && address.longitude.nil?)
    valid_estab && valid_addrs
  end
end
