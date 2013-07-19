class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :activity
	default_scope order: 'comments.created_at DESC'
	attr_accessible :content,:user_id,:activity_id
	validates :content, presence: true, length: {maximum: 199}
	validates :user_id,presence:true
	validates :activity_id,presence:true

end
