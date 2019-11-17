class PostsController < ApplicationController
  before_action :authenticate_user,{only: [:new, :create, :show, :edit, :update, :destroy]}
  before_action :correct_user,   only: :destroy
  def index
    @posts = Post.all.order(created_at: :desc)
    @posts = Post.page(params[:page]).per(8)
  end

  def new
    @post=Post.new
  end

  def create
    @post = Post.find_by(id: params[:id])
    @post = Post.new(
      content: params[:content],
      detail: params[:detail],
      user_id: @current_user.id,
      image_name: "default_image.jpg")

     if @post.save
      if params[:image]
        @post.image_name = "#{@post.id}.jpg"
        image = params[:image]
        File.binwrite("public/posts_images/#{@post.image_name}",image.read)

      end
        redirect_to posts_path
        flash[:notice] = "投稿しました"
        
      else
        @error_message = "入力内容に誤りがあります"
        render("posts/new")

     end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
    @like_count = Like.where(post_id: @post.id).count

  end

  def edit
    @post = Post.find_by(id: params[:id])
  end
 
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.detail = params[:detail]

    if @post.save

      if params[:image]
      @post.image_name = "#{@post.id}.jpg"
      image = params[:image]
      File.binwrite("public/posts_images/#{@post.image_name}",image.read)
  
    end
    redirect_to(posts_path)
    flash[:notice] = "投稿を編集しました"
     end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to(posts_path)
    flash[:notice] = "投稿を削除しました"
  end


private

  def correct_user
    @post = @current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end


  


end
