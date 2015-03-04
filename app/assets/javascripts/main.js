angular.module('startup', ['ui.router', 'templates', 'Devise'])
.config([
'$stateProvider',
'$urlRouterProvider',
function($stateProvider, $urlRouterProvider) {

  var auth = function ($q, $state, Auth) {
    var defer = $q.defer();
    Auth.currentUser().then(function(user) {
      defer.resolve();
    }, function(error) {
      $state.go('login');
    });
    return defer.promise;
  };

  $stateProvider
    .state('home', {
      url: '/home',
      templateUrl: 'home/_home.html',
      controller: 'MainCtrl',
      resolve: { auth: auth }
    })
    .state('login', {
      url: '/login',
      templateUrl: 'auth/_login.html',
      controller: 'AuthCtrl'
    })
    .state('register', {
      url: '/register',
      templateUrl: 'auth/_register.html',
      controller: 'AuthCtrl',
      onEnter: ['$state', 'Auth', function($state, Auth) {
        Auth.currentUser().then(function (){
          $state.go('home');
        })
      }]
    })
    .state('projects', {
      url: '/projects',
      templateUrl: 'projects/_index.html',
      controller: 'ProjectsCtrl',
      resolve: { auth: auth }
    })
    .state('tasks', {
      url: '/projects/:projectId/tasks',
      templateUrl: 'tasks/_index.html',
      controller: 'TasksCtrl',
      resolve: { auth: auth }
    });

  $urlRouterProvider.otherwise('home');
}])