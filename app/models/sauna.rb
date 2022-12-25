class Sauna < ApplicationRecord
  attachment :image
  validates :name, presence: true
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :comments, dependent: :destroy
end
