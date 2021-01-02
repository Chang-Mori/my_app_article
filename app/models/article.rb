class Article < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre
  belongs_to :user
  has_many   :comments
  has_many_attached :images

  validates :title, :text, presence: true

  validates :genre_id, numericality: { other_than: 1 }

end
