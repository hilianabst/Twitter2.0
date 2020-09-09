class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :friends
  has_many :tweets
  has_many :likes
  has_many :liked_tweets, :through => :likes, :source => :tweet

 
#   def arr_friends_id
#     self.friends.pluck(:friend_id)
#  end
  # def admin
  #   if self.admin == true
       
  #   else 
  #   false

  #   end
  # end
  
  def users_followed
    arreglo_ids = self.friends.pluck(:friend_id)
    User.find(arreglo_ids)
  end

  def is_following?(user)
      users_followed.include? (user)
  end

#      :friends_count
#    :tweets_count
#  :likes_give_it
#   :retweets_give_it
 

  def friends_count
    self.friends.count
  end


  def tweets_count
   #Tweet.where(user_id: self.id).where(re_ref: nil).count
   self.tweets.where(re_ref: nil).count
  end


  def likes_give_it
    self.likes.count
  end


  def retweets_give_it
    self.tweets.where.not(re_ref: nil).count
    
  end

  def  self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

end














