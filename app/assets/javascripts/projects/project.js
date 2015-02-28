angular.module('startup')
.factory('Project', ['$http', function($http){
  var Project = function(data) {
    angular.extend(this, data);
  }

  Project.getAll = function() {
    return $http.get('/projects').then(function(response) {
      return new Project(response.data);
    });
  };

  return Project;
}]);