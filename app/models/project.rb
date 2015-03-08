class Project < ActiveRecord::Base
  validates :title, presence: true

  has_many :boards
  has_and_belongs_to_many :users
  belongs_to :company
  has_many :tasks, through: :boards
end
