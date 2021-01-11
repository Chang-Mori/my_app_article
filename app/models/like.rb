class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article, counter_cache: :likes_count
end
