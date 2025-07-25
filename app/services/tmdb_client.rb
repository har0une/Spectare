# app/services/tmdb_client.rb
class TmdbClient
  BASE_URL = "https://api.themoviedb.org/3"
  API_KEY = "12c051f57c49a893b585f23ed81567bd"  # Your actual API key here

  def self.movie_details(id)
    response = Faraday.get("#{BASE_URL}/movie/#{id}?api_key=#{API_KEY}")
    JSON.parse(response.body)
  end

  def self.movie_credits(id)
    response = Faraday.get("#{BASE_URL}/movie/#{id}/credits?api_key=#{API_KEY}")
    JSON.parse(response.body)
  end
end

