class User < ApplicationRecord
  require 'open-uri'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :profile_image
  has_many :photos
  has_many :likes
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: {minimum: 3, maximum: 50}
  validates :name, format: {with: /^[a-zA-ZÀ-ÿ\u00f1\u00d1\s]*$/, multiline: true}
  validates :description, length: {maximum: 300}
  validates :description, format: {with: /^((?!.*http.*).)*$/, multiline: true}
  validates :profile_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: {less_than: 300.kilobytes}

  @@mail_number = 0

  def my_likes 
    self.likes.map { |like| like.photo}
  end

  def liked?(photo)
    self.my_likes.include? photo
  end

  def self.from_omniauth(auth)

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

      url_image = URI(auth.info.image)
      image = URI.open(url_image)

      if auth.info.email
        user.email = auth.info.email
      else
        user.email = "example#{@@mail_number}@mail.com"
      end

      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.profile_image.attach(io: image, filename: 'profile_pic.jpg') 
      
    end

  end

end
