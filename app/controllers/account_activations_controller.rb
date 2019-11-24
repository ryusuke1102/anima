class AccountActivationsController < ApplicationController
  include ApplicationHelper

    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
          user.activate
          log_in user
          flash[:notice] = "アカウントが認証されました"
          redirect_to root_path
        else
          flash[:notice] = "認証エラー"
          redirect_to root_path
        end
      end
    end
