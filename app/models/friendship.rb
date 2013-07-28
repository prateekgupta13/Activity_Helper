class Friendship < ActiveRecord::Base
	
	belongs_to :user
	belongs_to :friend, :class_name => "User"
	has_many :messages, dependent: :destroy
	attr_accessible :user_id,:friend_id,:status
	validates :user_id, presence:true
	validates :friend_id, presence:true
	
end
