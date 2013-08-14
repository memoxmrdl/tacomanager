class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :establishment
  has_many :order_details, dependent: :delete_all
  has_many :users, through: :order_details

  validate :check_payments, on: :update
  validates_presence_of :name
  before_save :order_secuency

  def total
    order_details.sum(:subtotal)
  end

  private

  def check_payments
    unless order_details.where(payment: false).any?
      errors.add(:payment, I18n.t('.not_have_foods'))
      self.payment = false
    end
  end

  def order_secuency
    self.name = "Orden ##{Order.last.try(id).to_i + 1}"
  end
end
