function BreweriesController($scope, $http) {
    $http.get('breweries.json').success( function(data, status, headers, config) {
        $scope.breweries = data;
    });

    $scope.order = 'name';
    $scope.beers_count = function(brewery){
    	return brewery.beers.length;
    }
    $scope.click = function (order){
        $scope.order = order;
        console.log(order);
    }

    $scope.searchText = '';
}