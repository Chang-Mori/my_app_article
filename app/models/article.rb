class Article < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre
  belongs_to :user
  has_many   :comments
  has_one_attached :image

  validates :title, :text, presence: true

  validates :genre_id, numericality: { other_than: 1 }

  def self.search(search)
    if search != ""
      Article.where('text LIKE(?)', "%#{search}%")
      # Article.where('title LIKE(?)', "%#{search}%")
    else
      Article.all
    end
  end
end
