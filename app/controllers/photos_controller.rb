class PhotosController < ApplicationController

    def index
        @users = User.all.with_attached_profile_image
        @photos = Photo.random(10)
    end
end