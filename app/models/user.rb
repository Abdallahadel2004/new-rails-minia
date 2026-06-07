class User < ApplicationRecord
  validates :name, :dob, :email, :phone_number, :address, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/ }
end
