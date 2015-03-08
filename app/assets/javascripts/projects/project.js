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

  Project.get = function (project_id) {
    return $http.get('/projects/' + project_id).then(function(response) {
      return new Project(response.data);
    });
  };

  Project.prototype.create = function() {
    var project = this;
    return $http.post('/projects', project).then(function(response) {
      project.id = response.data.id;
      return project;
    });
  }

  return Project;
}]);