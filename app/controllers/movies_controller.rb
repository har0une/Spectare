class MoviesController < ApplicationController
  def show
    # Safer API key handling with fallback
    api_key = ENV.fetch("TMDB_API_KEY")


    # Guard clause: block invalid movie IDs
    unless params[:id].to_s.match?(/\A\d+\z/)
      redirect_to root_path, alert: "Invalid movie ID" and return
    end

    # Fetch movie details
    movie_response = Faraday.get("https://api.themoviedb.org/3/movie/#{params[:id]}?api_key=#{api_key}&language=en-US")
    @movie = JSON.parse(movie_response.body)

    # Fetch cast and crew
    credits_response = Faraday.get("https://api.themoviedb.org/3/movie/#{params[:id]}/credits?api_key=#{api_key}")
    credits = JSON.parse(credits_response.body)
    @cast = credits["cast"]&.first(10) || []
    @crew = credits["crew"] || []
    @directors = @crew.select { |member| member["job"] == "Director" }

    # Fetch trailers and videos
    videos_response = Faraday.get("https://api.themoviedb.org/3/movie/#{params[:id]}/videos?api_key=#{api_key}&language=en-US")
    @videos = JSON.parse(videos_response.body)["results"] || []
  end

  def surprise
    api_key = ENV.fetch("TMDB_API_KEY")

    response = Faraday.get("https://api.themoviedb.org/3/movie/now_playing?api_key=#{api_key}")
    movies = JSON.parse(response.body)["results"]

    if movies.present?
      valid_movies = movies.select { |m| m["id"].present? && m["title"].present? }
      random_movie = valid_movies.sample
      redirect_to movie_path(random_movie["id"])
    else
      redirect_to root_path, alert: "No movies available right now."
    end
  end
end




