class Tag < ActiveRecord::Base
  validates :name, presence: true
  has_many :taggings
  has_many :tasks, through: :taggings
  has_many :lols
end
