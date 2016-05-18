class TagsController < ApplicationController
  add_breadcrumb 'Tags', :tags_path, only: %w(index)

  def index
    @tags = ActsAsTaggableOn::Tag.all
  end
end
