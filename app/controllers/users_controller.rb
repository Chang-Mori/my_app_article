class UsersController < ApplicationController
  before_action :set_rank
  def show
    user = User.find(params[:id])
    @name = user.name
    @articles = user.articles.order("created_at DESC")
    favorites = Favorite.where(user_id: current_user.id).pluck(:article_id)
    @favorite_list = Article.find(favorites)
    @user = User.find(params[:id])
    @image = user.image
    @profile = user.profile
  end

  def followings
    user = User.find(params[:id])
    @name = user.name
    @user = User.find(params[:id])
    @users = @user.followings.all
  end

  def followers
    user = User.find(params[:id])
    @name = user.name
    @user = User.find(params[:id])
    @users = @user.followers.all
  end

  private
  def set_rank
    @all_ranks = Article.find(Like.group(:article_id).order('count(article_id) desc').limit(5).pluck(:article_id))
  end

  def user_params
    params.require(:user).permit(:id, :name, :email, :image, :profile)
  end
end
