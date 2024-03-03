class Public::SearchesController < ApplicationController
  
  def search
    # @range = params[:range]
    # @range == "Post"
    @posts = Post.looks(params[:search], params[:word])
  end
  
end
