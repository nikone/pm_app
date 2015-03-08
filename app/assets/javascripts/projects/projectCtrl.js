angular.module('startup')
.controller('ProjectCtrl', [
'$scope',
'$stateParams',
'Project',
function($scope, $stateParams, Project){
  projectPromise = Project.get($stateParams.projectId);
  projectPromise.then(function (project) {
    $scope.projectAreaEmpty = false;
    $scope.project = project;
  });
}])
