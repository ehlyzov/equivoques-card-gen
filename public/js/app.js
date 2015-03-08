// Foundation JavaScript
// Documentation can be found at: http://foundation.zurb.com/docs
$(document).foundation();

var ekivokiApp = angular.module('ekivokiApp', []);

ekivokiApp.controller('CategoryListController', function($scope, $http) {
    $http.get('data.json').success(function(data) {
	$scope.categories = data.categories;
	$scope.Category = data.categories[0];
    });

    $scope.$watch('Category', function(newValue) {
	$scope.Rule = newValue[1];
    });
});
