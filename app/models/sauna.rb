class Sauna < ApplicationRecord
  attachment :image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :comments, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  with_options presence: true do
    validates :name
    validates :privacy
  end

  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :name_order, -> { order(name: :desc) }
end
