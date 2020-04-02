# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html {
        @posts = @user.posts.page(1).per(8)
        cookies[:page_number] = 1
      }
      format.js   {
        @page_number = (params[:in_de] == 'increment'
          ? (cookies[:page_number] = cookies[:page_number].to_i + 1)
          : (cookies[:page_number] = cookies[:page_number].to_i - 1))

        @posts = @user.posts.page(@page_number).per(8)
      }
    end
  end

  def testlogin
    user = User.find_by(email: 'testuser@testuser.testuser')
    user ||= User.create!(name: 'テストユーザー',
                          email: 'testuser@testuser.testuser',
                          password: 'password')
    sign_in user
    flash[:success] = 'テストユーザーでログインしました。'
    redirect_to root_url
  end

end
