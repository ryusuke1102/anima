class User < ApplicationRecord
    has_many :post
    validates :name,{ presence: true}
    validates :email, {presence: true}
    validates :email, {uniqueness: true}
    validates :password, {presence: true}
def posts
    return Post.where(user_id: self.id)
  end
end
