angular.module('startup')
.controller('TasksCtrl', [
'$scope',
'$stateParams',
'$state',
'$timeout',
'Board',
'Task',
'Project',
function($scope, $stateParams, $state, $timeout, Board, Task, Project){
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

  $scope.openProject = function (project_id) {
    $state.go('tasks', {projectId: project_id})
  }

  // Create new task and append to board
  $scope.newTask = {};
  $scope.addTask = function () {
    // request to create the task
    var task = new Task();
    task.title = $scope.newTask.title;
    task.creator_id = 1;
    task.assignee_id = 1;
    task.board_id = $scope.activeBoard.id;
    task.completed = false;
    taskPromise = task.create($scope.projectId);

    taskPromise.then(function (task) {
      $scope.newTask = {};
      $scope.modalShown = false;

      // append the task to the board
      var index = Board.findIndexById($scope.boards, $scope.activeBoard.id);
      $scope.boards[index].tasks.push({
        id: task.id,
        title: task.title,
        completed: false
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
        tasks: [],
        completed_tasks: 0
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

  $scope.popoverProjectsShown = false;
  $scope.projectList = {};
  $scope.toggleProjectsList = function() {
    if (_.size($scope.projectList) == 0) {
      var projectsPromise = Project.getAll();
      projectsPromise.then(function (projects) {
        $scope.projectList = projects;
      });
    }
    $scope.popoverProjectsShown = !$scope.popoverProjectsShown;
  }

  $scope.toggleCompletedTasks = function(board_id) {
    index = Board.findIndexById($scope.boards, board_id);
    $scope.boards[index].showCompletedTasks = !$scope.boards[index].showCompletedTasks;
    if ($scope.boards[index].showCompletedTasks) {
      boardPromise = Board.getCompletedTasks(board_id);
      boardPromise.then(function (tasks) {
        for (i = 0; i < Object.keys(tasks).length; i++) {
          $scope.boards[index].tasks.push({
            id: tasks[i].id,
            title: tasks[i].title,
            completed: tasks[i].completed
          });
        }
      });
    } else {
      $scope.boards[index].tasks = _.filter($scope.boards[index].tasks, function(task){ 
        return task.completed == false; 
      });
    }
  };

  $scope.toggleCompleted = function (task, board) {
    task.completed = !task.completed;

    var task_model = new Task(task);
    task_model.completed = task.completed;
    task_model.update()

    if (task.completed == true) {
      board.completed_tasks += 1;
    } else {
      board.completed_tasks -= 1;
    }

    if (board.showCompletedTasks) {
      $timeout(function(){
        board.tasks = _.sortBy(board.tasks, 'completed');
      }, 1500);
    } else {
      $timeout(function(){
        board.tasks = _.filter(board.tasks, function(task){ 
          return task.completed == false; 
        });
      }, 1500);
    }
  }
}])