class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_many :activities, dependent: :destroy

  has_many :comments, dependent: :destroy

  attr_accessible :name,:email, :password, :password_confirmation, :username
  validates :name,length: {maximum: 15}
  validates :username, presence: true, length: {maximum: 20}
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

     def to_param
     username
     end

end
