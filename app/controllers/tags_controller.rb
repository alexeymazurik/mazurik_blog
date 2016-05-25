class TagsController < ApplicationController

  def index
    @tags = ActsAsTaggableOn::Tag.all.order(:id)
  end
end
