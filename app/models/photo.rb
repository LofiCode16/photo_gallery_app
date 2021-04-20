class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes

  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5120.kilobytes }

  scope :random, -> (cant) { all.includes(:user).with_attached_image.shuffle[0...cant] }
end
