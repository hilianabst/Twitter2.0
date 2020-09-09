Rails.application.routes.draw do

 
  ActiveAdmin.routes(self)
  # get 'users/follow'
  resources :tweets  do
    post 'likes', to: 'tweets#likes'
    post 'retweet', to: 'tweets#retweet'
  end
  
  devise_for :users

  
  get 'home/index'
  get 'all_tweets', to: 'home#all_tweets', as: 'all_tweets'

  post 'follow/:user_id', to: 'users#follow', as: 'users_follow'
  


  root 'home#all_tweets'
  #get 'api/news'

  #por si mi api tiene muchos servicios se usa scope
  scope '/api' do
    get '/news', to: 'api#news', as: 'api_news'
    get '/tweets_between_dates/:date1/:date2', to: 'api#tweets_between_dates', as: 'tweets_between_dates'
    post '/tweets', to: 'api#create_tweet'
  end
  #root'home#all_tweets'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
