class User < ApplicationRecord
  has_many :posts, foreign_key: 'creator_id', class_name: 'Post', dependent: :destroy

  validates :name, :dob, :email, :phone_number, :address, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/ }
end
