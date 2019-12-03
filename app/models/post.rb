class Post < ApplicationRecord
    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    validates :content, {presence: true, length: {maximum: 100}}
    validates :detail, {presence: true, length: {maximum: 350}}
    validates :user_id, {presence: true}
def users
    return User.find_by(id: self.user_id)
end

end
