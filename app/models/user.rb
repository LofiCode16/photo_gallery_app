class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  validates :name, presence: true
  validates :name, length: {minimum: 3, maximum: 50}
  validates :name, format: {with: /^[a-zA-Z\s]*$/, multiline: true}
  validates :description, length: {maximum: 300}
  validates :description, format: {with: /^((?!.*http.*).)*$/, multiline: true}
  validates :profile_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: {less_than: 300.kilobytes}

  has_one_attached :profile_image
  
end
