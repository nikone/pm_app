angular.module('startup')
.controller('ProjectsCtrl', [
'$scope',
'Project',
function($scope, Project){
  //to retrive all projects
  var projectPromise = Project.getAll();
  projectPromise.then(function (projects) {
    $scope.projects = projects;
  });
}])