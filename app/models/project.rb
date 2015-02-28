class Project < ActiveRecord::Base
  validates :title, presence: true

  has_many :boards
end
