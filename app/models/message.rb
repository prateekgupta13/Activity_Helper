class Message < ActiveRecord::Base
	default_scope order: 'messages.created_at DESC'
	belongs_to :recipients, class_name: 'User'
	belongs_to :user
	belongs_to :friendship
	attr_accessible :message, :user_id, :recipient_id,:status
	validates :message, presence:true, length:{maximum:50}
	validates :user_id, presence:true
	validates :recipient_id, presence:true

	
	

end
