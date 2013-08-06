class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  scope :without_user, lambda{|user| user ? {:conditions => ["id != ?", user.id]} : {} }
  has_many :activities, dependent: :destroy
  has_many :comments, dependent: :destroy, :through=> :activities
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :messages
  has_many :recipients, through: :messages
  has_many :inverse_messages, class_name: 'Message', :foreign_key => "recipient_id"
  has_many :senders, through: :inverse_messages, :source => :user
    

  attr_accessible :name,:email, :password, :password_confirmation, :username, uniqueness:true
  before_save { |user| user.email = email.downcase }
  validates :name,length: {maximum: 25}
  validates :username, presence: true, length: {maximum: 20}, uniqueness: true
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable




  def to_param
   username
  end
end
