# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#test users
User.create(username: "admin", password: "adminadmin", password_confirmation: "adminadmin", email: "admin@gmail.com")
User.create(username: "employee1", password: "adminadmin", password_confirmation: "adminadmin", email: "employee1@gmail.com")
User.create(username: "employee2", password: "adminadmin", password_confirmation: "adminadmin", email: "employee2@gmail.com")
User.create(username: "employee3", password: "adminadmin", password_confirmation: "adminadmin", email: "employee3@gmail.com")
User.create(username: "employee4", password: "adminadmin", password_confirmation: "adminadmin", email: "employee4@gmail.com")

Company.create(name: "Corp")

Project.create(title: "Zerply", company_id: 1)

Board.create(title: "Backlog", project_id: 1)
Board.create(title: "Ready", project_id: 1)
Board.create(title: "Backend development", project_id: 1)
Board.create(title: "Frontend development", project_id: 1)

Task.create(title: "User Behaviour & Strategies", creator_id: 1 ,board_id: 1, assignee_id: 5)
Task.create(title: "Development API", creator_id: 1 ,board_id: 1, assignee_id: 2)
Task.create(title: "No updates for this discussion", creator_id: 1 ,board_id: 1, assignee_id: 5)
Task.create(title: "User Experience Dynamics", creator_id: 1 ,board_id: 1, assignee_id: 4)
Task.create(title: "Available heatmap tools", creator_id: 1 ,board_id: 2, assignee_id: 3)
Task.create(title: "UX Charts and app flow", creator_id: 1 ,board_id: 2, assignee_id: 2)
Task.create(title: "Android wireframes", creator_id: 1 ,board_id: 2, assignee_id: 5)
Task.create(title: "iOS wireframes", creator_id: 1 ,board_id: 2, assignee_id: 2)
Task.create(title: "Main functions", creator_id: 1 ,board_id: 3, assignee_id: 3)
Task.create(title: "Deployment scripts", creator_id: 1 ,board_id: 3, assignee_id: 2)
Task.create(title: "Data Layer", creator_id: 1 ,board_id: 3, assignee_id: 3)
Task.create(title: "Integration testing", creator_id: 1 ,board_id: 3, assignee_id: 4)
Task.create(title: "Twitter Bootstrap", creator_id: 1 ,board_id: 4, assignee_id: 3)
Task.create(title: "Sprites", creator_id: 1 ,board_id: 4, assignee_id: 4)
Task.create(title: "No updates for this discussion", creator_id: 1 ,board_id: 4, assignee_id: 2)
Task.create(title: "Responsive web", creator_id: 1 ,board_id: 4, assignee_id: 2)
