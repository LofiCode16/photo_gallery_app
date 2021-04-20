class LikesController < ApplicationController

    def create
        like = Like.new(user_id: current_user.id, photo_id: params[:photo_id])

        redirect_to root_path if like.save
    end

    def destroy
        like = Like.find_by(user_id: current_user.id, photo_id: params[:photo_id])
        like.destroy

        redirect_to root_path
    end
end