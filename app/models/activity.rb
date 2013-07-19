class Activity < ActiveRecord::Base
	 belongs_to :user
	 has_many :comments, dependent: :destroy
	 default_scope order: 'activities.created_at DESC'

	 attr_accessible :user_id, :category, :name, :description
	 validates :category, presence: true
	 validates :name, presence: true
	 validates :description,presence: true, length: {maximum: 199}
	 validates :user_id, presence: true
end

