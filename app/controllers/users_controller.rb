class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @name = user.name
    @articles = user.articles.order("created_at DESC")
  end
end
