json.array! @projects do |project|
  json.title project.title
  json.description project.description
end