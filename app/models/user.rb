class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :followers, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following_users, through: :followers, source: :followed
  
  has_many :followings, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :follower_users, through: :followings, source: :follower

  def follow(user_id)
    followers.create(followed_id: user_id)
  end

  def unfollow(user_id)
    followers.find_by(followed_id: user_id).delete
  end

  def following?(user)
    following_users.include?(user)
  end

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true

  validates :introduction,    length: { maximum: 50 }

  with_options on: :update? do
   validates :introduction, presence: true
  end

end
