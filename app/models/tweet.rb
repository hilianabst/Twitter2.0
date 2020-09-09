class Tweet < ApplicationRecord
include ActionView::Helpers::UrlHelper

  before_save :add_hashtags
  validates :content, presence: true

  belongs_to :user,  :dependent => :destroy
  has_many :likes
  has_many :liking_users, :through => :likes, :source => :user

  paginates_per 5

  scope :tweets_for_me, -> (user){ where(user_id: user.friends.pluck(:friend_id).push(user.id)) }

  #Hashtags
  def add_hashtags
    new_array = []
    self.content.split(" ").each do |word|
      if word.start_with?("#")
        word_parsed = word.sub '#','%23'
        word = link_to( word, Rails.application.routes.url_helpers.root_path+"?search="+word_parsed )
      end
     new_array.push(word)
    end

    self.content = new_array.join(" ")
  end
 

  def is_liked?(user)
      if self.liking_users.include?(user)
        true
      else
        false
      end
  end

  def remove_like(user)
    Like.where(user: user, tweet: self).first.destroy

  end

  def add_like(user)
      Like.create(user: user, tweet: self)
  end

  def like_icon(user)
    if is_liked?(user)
      'fas fa-star'
    else
      'far fa-star'
    end 
  end
  
def count_rt
  Tweet.where(re_ref: self.id).count

end

def is_retweet
  re_ref ? true : false
end

def tweet_ref
Tweet.find(self.re_ref)
end

end
