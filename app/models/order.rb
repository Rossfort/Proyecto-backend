class Order < ApplicationRecord
  after_create :reload_uuid
  has_many :payments, dependent: :destroy
  enum status: { pendiente: 0, pagado: 1, enviado: 2, cancelado: 3, error: 4 }
  belongs_to :user
  has_many :line_items, dependent: :destroy

  scope :from_token, ->(token) { find_by(token: token) }

  scope :filter_by_status, ->(status) { where status: status }

  scope :filter_by_email, ->(email) { joins(:user).where("user.email": email) }

  scope :filter_by_id, ->(id) { where id: id }

  validates :name, :last_name, :address, :city, :comuna, :phone, :status, presence: true
  validates :pay_method, presence: true, inclusion: { in: PaymentMethods.values }

  def payed_mail
    @order = Order.find(id)
    OrderMailer.with(order: @order).order_payed.deliver_later
  end

  def status_payed?
    status == 'pagado'
  end

  def reload_uuid
    self[:uuid] = self.class.where(id: id).pluck(:uuid).first if attributes.key? 'uuid'
  end

  delegate :email, to: :user
end
