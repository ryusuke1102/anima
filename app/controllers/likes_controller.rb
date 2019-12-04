class LikesController < ApplicationController
    include ApplicationHelper
    before_action :authenticate_user
    
    def create
        @post = Post.find(params[:post_id])
        unless @post.like?(current_user)
            @post.like(current_user)
            respond_to do |format|
                format.html { redirect_to request.referrer ||  post_path}
                format.js
      end
    end
      end
    
      def destroy
        @post = Like.find(params[:id]).post
        if @post.like?(current_user)
            @post.unlike(current_user)
            respond_to do |format|
                format.html { redirect_to request.referrer ||  post_path}
                format.js
      end
    end
    end

  end
  