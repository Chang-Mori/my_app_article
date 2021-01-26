class Article < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre
  belongs_to :user
  has_many   :comments
  has_many_attached :images
  has_many   :article_tag_relations
  has_many   :tags, through: :article_tag_relations, dependent: :destroy
  has_many   :likes
  has_many   :liking_users, through: :likes, source: :user
  has_many   :favorites, dependent: :destroy

  def avg_score
    unless self.comments.empty?
      comments.average(:recommend).round(1).to_f
    else
      0.0
    end
  end

  def review_score_percentage
    unless self.comments.empty?
      comments.average(:recommend).round(1).to_f*100/5
    else
      0.0
    end
  end
end
