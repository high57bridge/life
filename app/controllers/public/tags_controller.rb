class Public::TagsController < ApplicationController
  before_action :authenticate_customer!
  
  def tag
    @tag = Tag.find_by(name: params[:name])
    @posts = @tag.posts
  end
  
end
