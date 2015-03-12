angular.module('startup')
.controller('TasksCtrl', [
'$scope',
'$stateParams',
'$state',
'Board',
'Task',
function($scope, $stateParams, $state, Board, Task){
  $scope.projectId = $stateParams.projectId;

  tasksPromise = Task.getAll($stateParams.projectId);
  tasksPromise.then(function (boards) {
    $scope.boards = boards;

    if(boards.length) {
      taskPromise = Task.get(boards[0].tasks[0].id);
      taskPromise.then(function (task) {
        $scope.taskAreaEmpty = true;
        $scope.task = task;
      });
    }

  });

  // Task data currently displayed
  $scope.changeActiveTask = function (task_id) {
    $scope.taskAreaEmpty = false;
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
    taskPromise = task.create($scope.projectId);

    taskPromise.then(function (task) {
      $scope.newTask = {};
      $scope.modalShown = false;

      // append the task to the board
      var index = Board.findIndexById($scope.boards, $scope.activeBoard.id);
      $scope.boards[index].tasks.push({
        id: task.id,
        title: task.title 
      });
    });
  };

  $scope.newBoard = {};
  $scope.addBoard = function () {
    var board = new Board();
    board.title = $scope.newBoard.title;
    boardPromise = board.create($scope.projectId);

    boardPromise.then(function (board) {
      $scope.modalNewBoardShown = false;
      $scope.newBoard = {};

      $scope.boards = Board.insertBoardToList($scope.boards, {
        id: board.id,
        title: board.title,
        tasks: []
      });
    });
  }

  // Show new task modal logic
  $scope.modalShown = false;
  $scope.activeBoard = {};
  $scope.toggleNewTaskModal = function(board_id) {
    $scope.activeBoard.id = board_id;
    $scope.modalShown = !$scope.modalShown;
  };

  $scope.modalNewBoardShown = false;
  $scope.toggleNewBoardModal = function() {
    $scope.modalNewBoardShown = !$scope.modalNewBoardShown;
  };

  $scope.toggleHideTasks = function() {
    this.hideTasks = !this.hideTasks;
  };
}])
