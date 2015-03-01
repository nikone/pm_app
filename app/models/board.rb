class Board < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :project
  has_many :tasks
end
