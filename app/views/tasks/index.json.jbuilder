json.array! @boards do |board|
  json.id board.id
  json.title board.title
  json.tasks board.tasks[0,4] do |task|
    json.id task.id
    json.title task.title
    json.assignee_id task.assignee_id
    json.created_at task.created_at
    json.tags task.tags, :id, :name
  end
end