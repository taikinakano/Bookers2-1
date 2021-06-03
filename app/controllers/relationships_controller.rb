class RelationshipsController < ApplicationController

  def create
    user = User.find_by_id(params[:user_id])
    if user
      current_user.follow(params[:user_id]) unless current_user.following?(user)
    end
    redirect_to users_path
  end

  def destroy
    user = User.find_by_id(params[:user_id])
    if user
      current_user.unfollow(params[:user_id]) if current_user.following?(user)
    end
    redirect_to users_path
  end

end
