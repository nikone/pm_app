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

  Board.insertBoardToList = function(board_list, board) {
    var arrLength = Object.keys(board_list).length;
    board_list[arrLength] = board;
    return board_list;
  };

  Board.prototype.create = function(project_id) {
    var board = this;
    return $http.post('/projects/' + project_id + '/boards', board).then(function(response) {
      board.id = response.data.id;
      return board;
    });
  }

  return Board;
}]);