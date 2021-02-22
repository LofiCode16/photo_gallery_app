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

    describe 'Validations' do
        
        context 'Name' do
            
            it 'cant be blank' do
                subject.name = nil
                expect(subject).to_not be_valid
            end

            it 'must have 3 chars minumum' do
                subject.name = 'ab'
                expect(subject).to_not be_valid
            end

            it 'must have 50 chars maximun' do
                subject.name = 'a' * 51
                expect(subject).to_not be_valid
            end

            it 'only can have letters and spaces' do
                subject.name = 'user_123@!'
                expect(subject).to_not be_valid
            end
        end
    end
end