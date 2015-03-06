angular.module('startup')
.controller('TasksCtrl', [
'$scope',
'$stateParams',
'$state',
'Board',
'Task',
function($scope, $stateParams, $state, Board, Task){
  // Initial data when page is loaded, board and tasks
  boardPromise = Board.get($stateParams.projectId);
  $scope.projectId = $stateParams.projectId;

  boardPromise.then(function (boards) {
    $scope.boards = boards;

    taskPromise = Task.get(boards[0].tasks[0].id);
    taskPromise.then(function (task) {
      $scope.activeTask = task;
    });
  });

  // Task data currently displayed
  $scope.changeActiveTask = function (task_id) {
    $state.go('tasks.show', {taskId: task_id})
  };

  // Create new task and append to board
  $scope.newTask = {};
  $scope.addTask = function () {
    // request to create the task
    var task = new Task();
    task.title = $scope.newTask.title;
    task.creator_id = 1;
    task.assignee_id = 1;
    task.board_id = $scope.activeBoard.id;
    task.create();

    // close modal and reset input
    $scope.newTask.title = "";
    $scope.modalShown = false;

    // append the task to the board
    var index = Board.findIndexById($scope.boards, $scope.activeBoard.id);
    $scope.boards[index].tasks.push({
      id: task.id,
      title: task.title 
    });
  };

  // Show new task modal logic
  $scope.modalShown = false;
  $scope.activeBoard = {};
  $scope.toggleNewTaskModal = function(board_id) {
    if (board_id) {
      $scope.activeBoard.id = board_id;
    }
    $scope.modalShown = !$scope.modalShown;
  };
}])
