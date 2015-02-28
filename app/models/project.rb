class Project < ActiveRecord::Base
  validates :title, presence: true

  has_many :boards
  belongs_to :company
end
