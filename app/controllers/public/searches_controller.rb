class Public::SearchesController < ApplicationController
  
  def search
    @posts = Post.looks(params[:search], params[:word])
  end
  
end
