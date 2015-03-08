class Task < ActiveRecord::Base
  validates :title, :creator, :assignee, presence: true

  belongs_to :creator, class_name: 'User'
  belongs_to :assignee, class_name: 'User'
  belongs_to :board
  delegate :project, :to => :board, :allow_nil => true
  has_many :taggings
  has_many :tags, through: :taggings
end
