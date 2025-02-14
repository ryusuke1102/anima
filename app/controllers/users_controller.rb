class UsersController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user,{only: [:edit]}
  before_action :logged_in_user, only: [:index, :update, :destroy, :following, :followers]


  def index
    
    if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
      @q = User.ransack(search_params, activated_true: true)
    else
      @q = User.ransack(activated_true: true)
    end
      @users = @q.result.page(params[:page]).per(8)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(id: params[:id])
    @user = User.new(
      name: params[:name], 
      email: params[:email], 
      password: params[:password],
      image_name: "default_users.jpg",)

    if @user.save
      @user.send_activation_email
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/")
    else
      @error_message = "入力内容に誤りがあります"
      render("users/new")

    end
  end

    
  def edit
    @user = User.find_by(id: params[:id])
    redirect_to root_url and return unless @user.activated?
    @posts = Post.where(user_id: @user.id).page(params[:page]).per(4)
    
    
  end

  def login
    @user = User.find_by(email: params[:email],password: params[:password])
    
    if @user && @user.activated?
      log_in @user
      params[:remember_me] == '1' ? remember(@user): forget(@user)
      remember @user
      flash[:notice] = "ログインしました"
      redirect_to("/posts")
    else
      @error_message = "ユーザーかメールアドレスに誤りがあります"
      render("/users/login_form")
    end 
  end

  def logout
    session[:user_id] = nil
    forget(@current_user)
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
 
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    @post = Post.where(user_id: @user.id)
    @post.destroy_all
    flash[:notice] = "ユーザーを削除しました"
    session[:user_id] = nil
    redirect_to("/")

  end
  
  def show
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]

    if params[:image]
     @user.image_name = "#{@user.id}.jpg"
     image = params[:image]
     File.binwrite("public/users_images/#{@user.image_name}",image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました。"
      redirect_to("/users/#{@user.id}/edit")
    else
      @error_message = "入力内容に誤りがあります"
      render("users/show")
    end
    
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(12)

    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(12)
    render 'show_follow'
  end

  private
  def logged_in_user
    unless logged_in?
      flash[:notice] = "ログインが必要です"
      redirect_to login_url
    end
  end

  def search_params
    params.require(:q).permit(:name_cont)
  end
end
