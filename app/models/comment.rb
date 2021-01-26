class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  validates :recommend, presence: true
  validates :text, presence: true
end
