module Api
  class TagsController < ApplicationController
    def index
      name = params[:name].to_s
      @tags = Tag.where("name LIKE?", "#{name}%")
      render json: @tags
    end

    def create
      name = params[:name].to_s
      unless @tag = Tag.find_by(name: name)
        @tag = Tag.create(name: name)
      end
      render json: @tag
    end
  end
end
