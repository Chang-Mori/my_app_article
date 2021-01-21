class LikesController < ApplicationController

  before_action :article_params

  def like
    if @article.user_id != current_user.id
      like = current_user.likes.new(article_id: @article.id)
      like.save
    end
  end

  def unlike
    like = current_user.likes.find_by(article_id: @article.id).destroy
  end

  private

  def article_params
    @article = Article.find(params[:article_id])
    @id_name = "#like-link-#{@article.id}"
  end
end
