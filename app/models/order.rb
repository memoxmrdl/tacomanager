class Order < ActiveRecord::Base
  before_save :order_secuency

  belongs_to :user
  belongs_to :establishment
  has_many :order_details, dependent: :delete_all
  has_many :users, through: :order_details

  validate :check_payments, on: :update

  scope :my_current_orders,
    -> (user) { where(user: user).order('created_at DESC') }

  def total
    order_details.sum(:subtotal)
  end

  private

  def check_payments
    unless order_details.where(payment: false).any? || order_details.where(payment: true).any?
      errors.add(:payment, I18n.t('.not_have_foods'))
      self.payment = false
    end
  end

  def get_last_id
    !Order.last ? 1 : (Order.last.id + 1)
  end

  def order_secuency
    self.name = "Orden ##{get_last_id}"
  end
end
