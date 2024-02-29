class Public::TagsController < ApplicationController

  def tag
    @tag = Tag.find_by(name: params[:name])
    @posts = @tag.posts
  end
  
end
