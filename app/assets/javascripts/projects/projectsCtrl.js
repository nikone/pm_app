angular.module('startup')
.controller('ProjectsCtrl', [
'$scope',
'$state',
'Project',
function($scope, $state, Project){
  //to retrive all projects
  var projectsPromise = Project.getAll();
  projectsPromise.then(function (projects) {
    $scope.projects = projects;

    projectPromise = Project.get(projects[0].id);
    projectPromise.then(function (project) {
      $scope.projectAreaEmpty = true;
      $scope.project = project;
    });
  });

  $scope.changeActiveProject = function (project_id) {
    $scope.projectAreaEmpty = false;
    $state.go('projects.show', {projectId: project_id})
  };

  $scope.newProject = {};
  $scope.createProject = function () {
    // request to create the task
    var project = new Project();
    project.title = $scope.newProject.title;
    project.description = $scope.newProject.description;
    projectPromise = project.create();

    projectPromise.then(function (project) {
      console.log(project);
      //after the project is create it is added to users project list

      // close modal and reset input
      $scope.newProject = {};
      $scope.modalShown = false;

      // append the project to the list
      index = project.id - 1;
      $scope.projects[index] = {
        id: project.id,
        title: project.title 
      };
      console.log($scope.projects);
    });
  }

  $scope.newModalShown = false;
  $scope.toggleNewProjectModal = function () {
    $scope.newModalShown = !$scope.newModalShown;
  }
}])