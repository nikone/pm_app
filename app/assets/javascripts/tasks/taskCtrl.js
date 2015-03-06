angular.module('startup')
.controller('TaskCtrl', [
'$scope',
'$stateParams',
'Task',
function($scope, $stateParams, Task){
  taskPromise = Task.get($stateParams.taskId);
  taskPromise.then(function (task) {
    $scope.activeTask = task;
  });
}])
