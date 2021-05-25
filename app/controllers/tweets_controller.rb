class TweetsController < ApplicationController
  before_action :set_tweet,only: [:edit, :show, :update]
  before_action :move_to_index, except: [:index, :show, :search]
  
  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
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
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  private

  def tweet_params 
    params.require(:tweet).permit(:name, :text, :price, :category_id, :company_id, :texture_id,
                                    :jan_code, images: []).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
  
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
