class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
    @posts = Post.page(params[:page]).per(8)
    @post = Post.find_by(id: params[:id])
  end
end
