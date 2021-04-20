class PhotosController < ApplicationController

    def index
        @users = User.all.with_attached_profile_image
        @photos = Photo.all.includes(:user).with_attached_image
    end
end