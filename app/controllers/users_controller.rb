class UsersController < ApplicationController
  before_action :authenticate_user,{only: [:edit]}

  def index
    @users = User.all.order(created_at: :asc)
    @users = User.page(params[:page]).per(8)
    @user = User.find_by(id: params[:id])
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
      image_name: "default_users.jpg")

    if @user.save
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/")
    else
      @error_message = "入力内容に誤りがあります"
      render("users/new")

    end
  end

    
  def edit
    @user = User.find_by(id: params[:id])
  end

  def login
    @user = User.find_by(email: params[:email],password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts")
    else
      @error_message = "ユーザーかメールアドレスに誤りがあります"
      render("/users/login_form")
    end 
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
 
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    @post = Post.where(user_id: @user.id)
    @post.destroy_all
    flash[:notice] = "ユーザーを削除しました"
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
    end
    
  end
end
