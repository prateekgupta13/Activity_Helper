class Comment < ActiveRecord::Base
	belongs_to :user, :activity
	attr_accessible :content, :user_id
	validates :content, presence: true, length: {maximum: 199}
	validates :user_id, presence: true

end
