class Post < ApplicationRecord
  validates :title, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 50}
  validates :body, presence: true, length: {maximum: 100000}
end
