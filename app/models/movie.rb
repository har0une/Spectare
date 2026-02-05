class Movie < ApplicationRecord
  has_many :watchlists
  has_many :likes
  has_many :ratings

  has_many :users_with_watchlists, through: :watchlists, source: :user
  has_many :users_who_liked, through: :likes, source: :user
  has_many :users_who_rated, through: :ratings, source: :user
end
