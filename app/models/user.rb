# frozen_string_literal: true

# Model representing a user.
class User < ApplicationRecord
  # Make sure Devise modules are included
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :watchlists
  has_many :likes
  has_many :ratings
end
