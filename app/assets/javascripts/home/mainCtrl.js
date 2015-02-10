angular.module('startup')
.controller('MainCtrl', [
'$scope',
function($scope){
  $scope.test = 'Hello world!';
}])