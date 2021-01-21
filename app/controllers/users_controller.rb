class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @name = user.name
    @articles = user.articles.order("created_at DESC")
    @all_ranks = Article.find(Like.group(:article_id).order('count(article_id) desc').limit(5).pluck(:article_id))
    favorites = Favorite.where(user_id: current_user.id).pluck(:article_id)
    @favorite_list = Article.find(favorites)
  end
end
