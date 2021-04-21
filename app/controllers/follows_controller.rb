class FollowsController < ApplicationController
    
    def create
        follow = Follow.new(user_id: current_user.id, follow_id: params[:follow_id])
        if follow.save
            redirect_to root_path, notice: 'siguiendo'
        else
            redirect_to root_path, alert: 'hubo un problemar'
        end
    end

    def destroy
        follow = Follow.find_by(user_id: current_user.id, follow_id: params[:follow_id])
        follow.destroy

        redirect_to root_path, notice: 'dejaste de seguir'
    end 
end