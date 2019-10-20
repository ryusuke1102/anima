class Post < ApplicationRecord
    validates :content, {presence: true, length: {maximum: 30}}
    validates :detail, {presence: true, length: {maximum: 350}}
    validates :user_id, {presence: true}
def users
    return User.find_by(id: self.user_id)
end

end
