# frozen_string_literal: true

# Controller for user profiles.
class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show; end
end
