class WorkTag < ApplicationRecord
  belongs_to :tag,  counter_cache: :works_count
  belongs_to :work,  counter_cache: :tags_count
end