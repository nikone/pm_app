angular.module('startup')
.factory('Task', ['$http', function($http){
  var Task = function(data) {
    angular.extend(this, data);
  }

  Task.get = function(task_id) {
    return $http.get('/tasks/' + task_id).then(function(response) {
      return new Task(response.data);
    });
  };

  return Task;
}]);