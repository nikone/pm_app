class Board < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :project
  has_many :tasks
  has_many :active_tasks, -> { where(completed: false) }, class_name: 'Task'
  has_many :completed_tasks, -> { where(completed: true) }, class_name: 'Task'
end
