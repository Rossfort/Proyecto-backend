class User < ApplicationRecord
  has_many :orders
  validates :email, presence: true
end
