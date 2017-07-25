class BookTagsController < ApplicationController
  before_action :logged_in_user

  def manager
    binding.pry

  end

  private
  def tag_params

  end
end
