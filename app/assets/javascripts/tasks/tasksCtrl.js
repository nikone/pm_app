angular.module('startup')
.controller('TasksCtrl', [
'$scope',
'$stateParams',
'Board',
'Task',
function($scope, $stateParams, Board, Task){
  boardPromise = Board.get($stateParams.projectId);
  boardPromise.then(function (boards) {
    $scope.boards = boards;

    taskPromise = Task.get(boards[0].tasks[0].id);
    taskPromise.then(function (task) {
      $scope.activeTask = task;
    });
  });

  $scope.changeActiveTask = function (task_id) {
    taskPromise = Task.get(task_id);
    taskPromise.then(function (task) {
      $scope.activeTask = task;
    });
  }
}])