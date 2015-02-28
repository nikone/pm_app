class AddAssociationsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :creator_id, :integer
    add_column :tasks, :board_id, :integer
    add_column :tasks, :assignee_id, :integer
  end
end