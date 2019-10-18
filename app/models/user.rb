class User < ApplicationRecord
validates :name,{ presence: true}
validates :email, {presence: true}
validates :email, {uniqueness: true}
def posts
    return Post.where(user_id: self.id)
  end
end
