angular.module('startup')
.directive('popover', function() {
  return {
    restrict: 'E',
    scope: {
      show: '='
    },
    replace: true, // replace with the template below
    transclude: true, // insert custom content in directive
    link: function(scope, element, attrs) {
      scope.dialogStyle = {};
      if (attrs.width)
        scope.dialogStyle.width = attrs.width;
      if (attrs.height)
        scope.dialogStyle.height = attrs.height;
      if (attrs.top)
        scope.dialogStyle.top = attrs.top;
      if (attrs.left)
        scope.dialogStyle.left = attrs.left;
      scope.hideModal = function() {
        scope.show = false;
      };
    },
    templateUrl: "tasks/_popover.html"
  };
});