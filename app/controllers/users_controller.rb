# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @page_number = 1
    respond_to do |format|
      format.html {
        @posts = @user.posts.page(1).per(8)
      }
      format.js   {
        @page_number = params[:page].to_i
        if (params[:in_de] == 'increment')
          @page_number += 1
          @posts = @user.posts.page(@page_number).per(8)
        else
          @page_number -= 1
          @posts = @user.posts.page(@page_number).per(8)
        end
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
