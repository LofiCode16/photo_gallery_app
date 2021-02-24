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

        context 'Description' do
            
            it 'must have 300 chars maximum' do
                subject.description = 'a' * 301
                expect(subject).to_not be_valid
            end

            it 'cant have links to another sites' do
                subject.description = 'go to https://www.google.cl please!'
                expect(subject).to_not be_valid
            end

        end

        context 'Profile image' do
            
            it 'must have an image' do
                subject.profile_image.purge

                expect(subject).to_not be_valid
            end

            it 'must be an image' do
                subject.profile_image.attach(fixture_file_upload('files/profile_image.pdf', 'application/pdf'))

                expect(subject).to validate_content_type_of(:profile_image).allowing('image/png', 'image/jpg', 'image/jpeg')
            end

            it 'must have a max size of 5mb' do
                subject.profile_image.attach(fixture_file_upload('files/image_500kb.jpg', 'image/jpg'))

                expect(subject).to validate_size_of(:profile_image).less_than_or_equal_to(300.kilobytes)
            end
            
        end
    end
end