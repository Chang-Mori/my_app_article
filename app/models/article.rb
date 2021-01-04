class Article < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre
  belongs_to :user
  has_many   :comments
  has_many_attached :images
  has_many   :article_tag_relations
  has_many   :tags, through: :article_tag_relations, dependent: :destroy
end
