class Post < ApplicationRecord
    validates :content, {presence: true, length: {maximum: 30}}
    validates :detail, {presence: true, length: {maximum: 500}}
    validates :user_id, {presence: true}
    has_many :comments
def users
    return User.find_by(id: self.user_id)
end
end
