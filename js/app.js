// Foundation JavaScript
// Documentation can be found at: http://foundation.zurb.com/docs
$(document).foundation();

var ekivokiApp = angular.module('ekivokiApp', []);

ekivokiApp.controller('CategoryListController', function($scope, $http) {
    $http.get('data.json').success(function(data) {
	$scope.categories = data.categories;
	$scope.category_labels = data.categories.map(function(c) {
	    return c[0];
	});

	$scope.formData = {};

	$scope.formData.cards = [
	    {
		//category: $scope.category_labels[0],
		category: 'Своя категория',
		title: '',
		rule: '',
		goal: ''
	    },
	];

	$scope.formData.selectCategory = function(index, category) {
	    var rule = $scope.categories.filter(function(cat){
		return (cat[0] == category);
	    })[0][1];
	    $scope.formData.cards[index].rule = rule;	    
	}

	$scope.formData.addCard = function() {
	    var lastCard = $scope.formData.cards[$scope.formData.cards.length - 1];
	$scope.formData.cards.push({
	    category: lastCard.category,
	    title: lastCard.title,
	    rule: lastCard.rule,
	    goal: lastCard.goal,
	    selectedCategory: lastCard.selectedCategory
	});	
    }    
	
    });

});
