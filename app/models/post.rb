class Post < ApplicationRecord
    has_many :likes, dependent: :destroy
    has_many :like_users, through: :likes, source: :user
    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    validates :content, {presence: true, length: {maximum: 100}}
    validates :detail, {presence: true, length: {maximum: 350}}
    validates :user_id, {presence: true}

    def users
        return User.find_by(id: self.user_id)
    end
    
    def like(user)
        likes.create(user_id: user.id)
    end

    def unlike(user)
        likes.find_by(user_id: user.id).destroy
    end

    def like?(user)
        like_users.include?(user)
    end
end