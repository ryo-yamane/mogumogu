class TweetsController < ApplicationController
  before_action :set_tweet,only: [:edit, :show, :update]
  def index
    @tweets = Tweet.all  
  end

  def new 
    @tweet = Tweet.new
  end
 
  def create
    @tweet = Tweet.new(tweet_params)
    unless @tweet.save
      render :new
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
    
  end

  def update
    
    @tweet.update(tweet_params)
  end

  def show
    
  end

  private

  def tweet_params 
    params.require(:tweet).permit(:name, :text, :price, :category_id, :company_id, :texture_id,
                                    :jan_code, :image)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
  
end
