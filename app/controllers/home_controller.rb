# frozen_string_literal: true

# Controller for the home page.
class HomeController < ApplicationController
  def index
    api_key = '12c051f57c49a893b585f23ed81567bd'
    page = (params[:page] || 1).to_i

    response = Faraday.get("https://api.themoviedb.org/3/movie/now_playing?api_key=#{api_key}&page=#{page}")

    if response.success?
      json = JSON.parse(response.body)
      @movies = json['results'] || []
      @current_page = json['page'].to_i
      @total_pages = [json['total_pages'].to_i, 10].min
    else
      @movies = []
      @current_page = 1
      @total_pages = 1
      flash.now[:alert] = 'Failed to fetch movies'
    end
  rescue StandardError => e
    @movies = []
    @current_page = 1
    @total_pages = 1
    flash.now[:alert] = "Error: #{e.message}"
  end

  def about
    # optional about page
  end
end
