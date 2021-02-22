require 'rails_helper'

RSpec.describe User, type: :model do

    subject { 
        described_class.new(
            name: 'user',
            description: 'description for user profile',
            email: 'mail@example.com',
            password: 'abc123@#!',
            profile_image: fixture_file_upload('files/profile_image.jpg', 'image/jpg')
        )   
    }

    it 'is valid' do
        expect(subject).to be_valid
    end
end