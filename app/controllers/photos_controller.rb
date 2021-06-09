class PhotosController < ApplicationController

    def index
        @users = User.all.with_attached_profile_image

        if helpers.user_signed_in?
            @photos = Photo.last_photos_for_me(current_user, 10)
        else
            @photos = Photo.random(10)
        end
    end
end