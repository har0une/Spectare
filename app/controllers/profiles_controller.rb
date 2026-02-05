# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!  # Make sure user is signed in
  TMDB_API_KEY = '12c051f57c49a893b585f23ed81567bd'

  # ========================
  # Profile Pages
  # ========================

  # Watchlist movies
  def watchlist
    movie_ids = current_user.watchlists.pluck(:movie_id)
    @watchlist_movies = fetch_movies_from_tmdb(movie_ids)
  end

  # Liked movies
  def favorites
    movie_ids = current_user.likes.pluck(:movie_id)
    @liked_movies = fetch_movies_from_tmdb(movie_ids)
  end

  # Rated movies
  def ratings
    movie_ids = current_user.ratings.pluck(:movie_id)
    # Also get the user's rating
    @rated_movies = fetch_movies_from_tmdb(movie_ids).map do |movie|
      rating = current_user.ratings.find_by(movie_id: movie['id'])&.rating
      movie.merge('user_rating' => rating)
    end
  end

  # ========================
  # Actions for buttons
  # ========================

  # Add movie to watchlist
  def add_to_watchlist
    movie_id = params[:movie_id]
    unless current_user.watchlists.exists?(movie_id: movie_id)
      current_user.watchlists.create(movie_id: movie_id)
    end
    redirect_back(fallback_location: profile_path, notice: "Added to watchlist")
  end

  # Remove movie from watchlist
  def remove_from_watchlist
    movie_id = params[:movie_id]
    watchlist_item = current_user.watchlists.find_by(movie_id: movie_id)
    watchlist_item&.destroy
    redirect_back(fallback_location: profile_path, notice: "Removed from watchlist")
  end

  # Add movie to favorites/likes
  def add_to_favorites
    movie_id = params[:movie_id]
    unless current_user.likes.exists?(movie_id: movie_id)
      current_user.likes.create(movie_id: movie_id)
    end
    redirect_back(fallback_location: profile_path, notice: "Added to favorites")
  end

  # Remove movie from favorites/likes
  def remove_from_favorites
    movie_id = params[:movie_id]
    like_item = current_user.likes.find_by(movie_id: movie_id)
    like_item&.destroy
    redirect_back(fallback_location: profile_path, notice: "Removed from favorites")
  end

# Show rating form
def new_rating
  @movie_id = params[:movie_id]

  response = Faraday.get(
    "https://api.themoviedb.org/3/movie/#{@movie_id}?api_key=#{TMDB_API_KEY}"
  )
  @movie = JSON.parse(response.body)

  @rating = current_user.ratings.find_or_initialize_by(movie_id: @movie_id)
end

# Create rating
def rate_movie
  rating = current_user.ratings.find_or_initialize_by(movie_id: params[:movie_id])
  rating.rating = params[:rating]

  if rating.save
    redirect_to profile_ratings_path, notice: "Movie rated successfully"
  else
    redirect_back fallback_location: root_path, alert: "Could not save rating"
  end
end

# Update rating
def update_rating
  rating = current_user.ratings.find_by!(movie_id: params[:movie_id])

  if rating.update(rating: params[:rating])
    redirect_to profile_ratings_path, notice: "Rating updated"
  else
    redirect_back fallback_location: root_path, alert: "Could not update rating"
  end
end


  # Helper to fetch movie details from TMDB
  def fetch_movies_from_tmdb(movie_ids)
    movie_ids.map do |id|
      begin
        response = Faraday.get("https://api.themoviedb.org/3/movie/#{id}?api_key=#{TMDB_API_KEY}")
        JSON.parse(response.body)
      rescue
        nil
      end
    end.compact
  end
end

