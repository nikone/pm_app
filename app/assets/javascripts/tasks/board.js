angular.module('startup')
.factory('Board', ['$http', function($http){
  var Board = function(data) {
    angular.extend(this, data);
  }

  Board.get = function(project_id) {
    return $http.get('/projects/' + project_id + '/boards').then(function(response) {
      return new Board(response.data);
    });
  };

  return Board;
}]);