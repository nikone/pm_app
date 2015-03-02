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

  Board.findIndexById = function(boards, id) {
    var arrLength = Object.keys(boards).length;
    for (var i = 0; i < arrLength; i++) {
      if (boards[i].id == id) {
        return i;
      };
    };
  };

  return Board;
}]);