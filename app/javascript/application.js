// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import LoadMoreController from "./load_more_controller"
application.register("load-more", LoadMoreController)
