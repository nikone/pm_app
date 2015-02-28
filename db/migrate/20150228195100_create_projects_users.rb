class CreateProjectsUsers < ActiveRecord::Migration
  def change
    create_table :projects_users do |t|
      t.references :project, index: true
      t.references :user, index: true
    end
    add_foreign_key :projects_users, :projects
    add_foreign_key :projects_users, :users
  end
end
