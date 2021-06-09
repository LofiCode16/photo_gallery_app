class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes

  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5120.kilobytes }

  scope :random, -> (cant) { all.includes(:user, :likes).with_attached_image.shuffle[0...cant] }
  scope :last_photos_for_me, -> (user, cant) { where(user_id: user.my_follows.pluck(:id).push(user.id)).includes(:likes, :user).order(created_at: :desc).limit(cant) }
end
