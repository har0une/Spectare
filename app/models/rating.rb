class Rating < ApplicationRecord
  belongs_to :user
  validates :movie_id, presence: true
  validates :value, presence: true
end
