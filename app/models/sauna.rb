class Sauna < ApplicationRecord
  attachment :image
  belongs_to :user
  validates :name, presence: true
end
