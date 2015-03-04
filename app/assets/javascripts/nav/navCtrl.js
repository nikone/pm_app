angular.module('startup')
.controller('NavCtrl', [
'$scope',
'Auth',
function($scope, Auth){
  $scope.signedIn = Auth.isAuthenticated;
  $scope.logout = Auth.logout;

  if (Auth.isAuthenticated()) {
    $scope.user = Auth._currentUser;
  }

  $scope.$on('devise:new-registration', function (e, user){
    $scope.user = user;
  });

  $scope.$on('devise:login', function (e, user){
    $scope.user = user;
  });

  $scope.$on('devise:logout', function (e, user){
    $scope.user = {};
  });
}]);