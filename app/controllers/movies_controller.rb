# frozen_string_literal: true

# Controller for managing movies.
class MoviesController < ApplicationController
  def show
    api_key = '12c051f57c49a893b585f23ed81567bd'

    # Guard clause for invalid movie IDs
    redirect_to root_path, alert: 'Invalid movie ID' and return unless params[:id].to_s.match?(/\A\d+\z/)

    # Movie details
    movie_response = Faraday.get("https://api.themoviedb.org/3/movie/#{params[:id]}?api_key=#{api_key}&language=en-US")
    @movie = JSON.parse(movie_response.body)

    # Cast & crew
    credits_response = Faraday.get("https://api.themoviedb.org/3/movie/#{params[:id]}/credits?api_key=#{api_key}")
    credits = JSON.parse(credits_response.body)
    @cast = credits['cast']&.first(10) || []
    @crew = credits['crew'] || []
    @directors = @crew.select { |member| member['job'] == 'Director' }

    # Videos
    videos_response = Faraday.get("https://api.themoviedb.org/3/movie/#{params[:id]}/videos?api_key=#{api_key}&language=en-US")
    @videos = JSON.parse(videos_response.body)['results'] || []
  end

  def surprise
    api_key = '12c051f57c49a893b585f23ed81568bd'

    response = Faraday.get("https://api.themoviedb.org/3/movie/now_playing?api_key=#{api_key}")
    movies = JSON.parse(response.body)['results']

    if movies.present?
      valid_movies = movies.select { |m| m['id'].present? && m['title'].present? }
      random_movie = valid_movies.sample
      redirect_to movie_path(random_movie['id'])
    else
      redirect_to root_path, alert: 'No movies available right now.'
    end
  end
end
