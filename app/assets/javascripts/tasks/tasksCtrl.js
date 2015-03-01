angular.module('startup')
.controller('TasksCtrl', [
'$scope',
'$stateParams',
'Board',
function($scope, $stateParams, Board){
  boardPromise = Board.get($stateParams.projectId);
  boardPromise.then(function(boards) {
    $scope.boards = boards;
  });
}])