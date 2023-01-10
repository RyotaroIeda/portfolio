class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :sauna, optional: true
  validates :content, presence: true
end
