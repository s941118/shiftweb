class PostTag < ApplicationRecord
  belongs_to :tag,  counter_cache: :posts_count
  belongs_to :post,  counter_cache: :tags_count
end