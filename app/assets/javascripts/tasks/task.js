angular.module('startup')
.factory('Task', ['$http', function($http){
  var Task = function(data) {
    angular.extend(this, data);
  }

  Task.getAll = function(project_id) {
    return $http.get('/projects/' + project_id + '/tasks').then(function(response) {
      return new Task(response.data);
    });
  };

  Task.get = function (task_id) {
    return $http.get('/tasks/' + task_id).then(function(response) {
      return new Task(response.data);
    });
  };

  Task.prototype.create = function(project_id) {
    var task = this;
    return $http.post('/projects/' + project_id + '/tasks', task).then(function(response) {
      task.id = response.data.id;
      return task;
    });
  }

  return Task;
}]);