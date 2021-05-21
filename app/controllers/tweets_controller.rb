class TweetsController < ApplicationController

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


  private

  def tweet_params 
    params.require(:tweet).permit(:name, :text, :price, :category_id, :company_id, :texture_id,
                                    :jan_code, :image)
    end
end
