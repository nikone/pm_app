angular.module('startup')
.factory('Board', ['$http', function($http){
  var Board = function(data) {
    angular.extend(this, data);
  }

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