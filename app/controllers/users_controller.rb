class UsersController < ApplicationController
  def index
  end

  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @tweets = user.tweets
    @likes = Like.all
  end
end
