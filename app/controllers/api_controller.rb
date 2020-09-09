class ApiController < ApplicationController
skip_before_action :verify_authenticity_token 

  #tweets con un formato solicitado
  def news
   #render json: Tweet.last(50)
    
    tweets = Tweet.last(50)
      hash = tweets.map do |tweet|
        {
          :id => tweet.id,
          :content => tweet.content,
          :user_id => tweet.user_id,
          :like_count => tweet.likes.count,
          :retweets_count => tweet.count_rt,
          :retweeted_from => tweet.re_ref.nil? ? "" : tweet.re_ref
        }
      end
    render json: hash 
  end

  #tweets entre fechas api
  def tweets_between_dates
    date1 = Date.parse(params[:date1])
    date2 = Date.parse(params[:date2])

    tweets = Tweet.where(created_at: date1..date2)
    hash = tweets.map do |tweet|
      {
        :id => tweet.id,
        :content => tweet.content,
        :user_id => tweet.user_id,
        :like_count => tweet.likes.count,
        :retweets_count => tweet.count_rt,
        :retweeted_from => tweet.re_ref.nil? ? "" : tweet.re_ref
      }
    end
    render json: hash

  end

  def create_tweet
    user = User.authenticate(params[:email], params[:password])
    if !user.nil?

      @tweet = Tweet.new(tweet_params)
      @tweet.user = user
        if @tweet.save 
          render json: @tweet
        else
          render json: { erros: "error"}
        end
    else
      render json: { erros: "error credential"}  
    end   
  end



  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end

end











