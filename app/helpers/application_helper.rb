# frozen_string_literal: true

# Helper methods for home views.
# app/helpers/application_helper.rb
module ApplicationHelper
  def number_with_delimiter(number)
    number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end
end
