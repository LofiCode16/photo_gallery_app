require 'rails_helper'

RSpec.describe Photo, type: :model do
  
  subject {

    user = User.create(
      name: 'user',
      description: 'description for user profile',
      email: 'mail@example.com',
      password: 'abc123@#!',
      profile_image: fixture_file_upload('files/profile_image.jpg', 'image/jpg')
  )

    described_class.new(
      image: fixture_file_upload('files/image_5mb.jpg', 'image/jpg'),
      description: 'this is a description for this photo',
      location: 'city, country',
      user_id: user.id
    )
  }

  describe 'validations' do
    
    context 'image' do
      
      it 'must exist' do
        is_expected.to validate_attached_of(:image)
      end

      it 'must be an image' do
        subject.image.attach(fixture_file_upload('files/profile_image.pdf', 'application/pdf'))
        
        expect(subject).to validate_content_type_of(:image).allowing('image/png', 'image/jpg', 'image/jpeg')
      end

      it 'must have a max size of 5mb' do
        subject.image.attach(fixture_file_upload('files/image_5,1mb.jpg', 'image/jpg'))

        expect(subject).to validate_size_of(:image).less_than_or_equal_to(5120.kilobytes)
      end
    end
  end
end
