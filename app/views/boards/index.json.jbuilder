json.array! @boards do |board|
  json.title board.title
  json.tasks board.tasks[0,4], :title, :created_at
end