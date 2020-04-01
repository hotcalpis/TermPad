# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # respond_to do |format|
    #   format.html { @posts = @user.posts.page(1).per(8) }
    #   format.js   { @posts = @user.posts.page(2).per(8) }
    # end
    @posts = @user.posts.page(1).per(8)
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

  def increment
    user = User.find(params[:id])
    @posts = user.posts.page(2).per(8)
  end

  def decrement
    user = User.find(params[:id])
    @posts = user.posts.page(2).per(8)
  end

end
