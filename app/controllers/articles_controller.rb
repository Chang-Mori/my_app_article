class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :destroy]
  before_action :move_to_index, except: [:index, :show, :search]
  before_action :search_article, only: [:index, :search]
  before_action :set_article_rank, only: [:index, :new, :show]

  def index
    @articles = Article.includes(:user).order("created_at DESC")
    set_article_column
  end

  def new
    @article = ArticlesTag.new
  end

  def create
    @article = ArticlesTag.new(article_params)
    if @article.valid?
      @article.save
      return redirect_to articles_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @article.comments.includes(:user).order("created_at DESC")
  end

  def edit
    @article = ArticlesTag.new(article[:id])
  end

  def update
    @article = ArticlesTag.find(params[:id])
    @article.update(article_params)
  end

  def destroy
    @article.destroy data: { confirm: "削除してもよろしいですか？" }
  end

  def search
    # @articles = SearchArticlesService.search(params[:keyword])
    @articles = @a.result.includes(:title)

  end

  # def search(tag)
  #   return nil if params[:keyword] == ""
  #   tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"] )
  #   render json:{ keyword: tag}
  # end

  private
  def article_params
    params.require(:articles_tag).permit(:title, :text, :genre_id, :tag_name, images: []).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def search_article
    @a = Article.ransack(params[:q])
  end

  def set_article_column
    @article_title = Article.select("title").distinct
  end

  def set_article_rank
    @all_ranks = Article.find(Like.group(:article_id).order('count(article_id) desc').limit(5).pluck(:article_id))
  end
end