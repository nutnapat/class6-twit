class User < ApplicationRecord
    has_many :posts

    has_secure_password
    validates :email, uniqueness: true ,presence: true
    validates :name ,presence: true
    validates :password ,presence: true ,length: { in: 6..20 }



    has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :followees, through: :followed_users
    has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :followers, through: :following_users
end
