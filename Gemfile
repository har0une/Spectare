# frozen_string_literal: true

source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "propshaft"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

gem "tzinfo-data", platforms: %i[windows jruby]

gem "inline_svg"
gem "solid_cable"
gem "solid_cache"
gem "solid_queue"

gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

gem "devise"
gem "faraday"
gem "tailwindcss-rails"

# -----------------------------
# Development & Test
# -----------------------------
group :development, :test do
  gem "sqlite3", ">= 2.1"
  gem "dotenv-rails"

  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

# -----------------------------
# Development only
# -----------------------------
group :development do
  gem "web-console"
end

# -----------------------------
# Production only
# -----------------------------
group :production do
  gem "pg"
end

# -----------------------------
# Test only
# -----------------------------
group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
