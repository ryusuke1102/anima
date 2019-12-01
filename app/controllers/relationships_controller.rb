class RelationshipsController < ApplicationController
    include ApplicationHelper
    before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
        format.html { redirect_to edit_user_path(@user) }
        format.js
      end    
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
        format.html { redirect_to edit_user_path(@user) }
        format.js
      end  
    end

    private
    def logged_in_user
      unless logged_in?
        flash[:notice] = "ログインが必要です"
        redirect_to login_url
      end
    end
end