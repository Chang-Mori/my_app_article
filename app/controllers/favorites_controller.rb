class FavoritesController < ApplicationController
  before_action :set_article
  before_action :authenticate_user!

  def create
    if @article.user_id != current_user.id
      @favorite = Favorite.create(user_id: current_user.id, article_id: @article.id)
    end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, article_id: @article.id)
    @favorite.destroy!
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
    @id_name = "#favorite-link-#{@article.id}"
  end
end
