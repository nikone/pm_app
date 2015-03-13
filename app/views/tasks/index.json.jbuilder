json.array! @boards do |board|
  json.id board.id
  json.title board.title
  json.completed_tasks board.completed_tasks.count
  json.tasks board.active_tasks do |task|
    json.id task.id
    json.title task.title
    json.assignee_id task.assignee_id
    json.created_at task.created_at
    json.completed task.completed
    json.tags task.tags, :id, :name
  end
end