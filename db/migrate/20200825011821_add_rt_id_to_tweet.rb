class AddRtIdToTweet < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :re_ref, :integer
  end
end
