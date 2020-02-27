# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save ? (redirect_to @post) : (render :new)
  end

  def index
    @posts = Post.all
  end

  def show; end

  def edit; end

  def update
    @post.update(post_params) ? (redirect_to @post) : (render :edit)
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to current_user
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:theme, :description)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
