class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :name, length: {minimum: 3, maximum: 50}
  validates :name, format: {with: /^[a-zA-Z\s]*$/, multiline: true}

  has_one_attached :profile_image
end
