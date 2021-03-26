class ArticlesTag
  include ActiveModel::Model
  attr_accessor :tag_name, :title, :text, :genre_id, :image, :user_id

  validates :title, :text, presence: true
  validates :genre_id, numericality: { other_than: 1 }

  def save
    article = Article.create(title: title, text: text, genre_id: genre_id, image: image, user_id: user_id)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save

    ArticleTagRelation.create(article_id: article.id, tag_id: tag.id)
  end

end