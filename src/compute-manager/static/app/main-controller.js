angular.module('virtus')
    .controller('MainController', ['$scope', '$interval', '$location', '$cookies',
        function($scope, $interval, $location, $cookies) {

            var isConnected = $cookies.get('connected') === '1';
            if (!isConnected) {
                document.location.href = '/login';
            }

            $scope.logout = function() {
                $cookies.put("connected", 0);
                document.location.href = '/login?';
            };

            $scope.goto = function(state) {
                $location.url(state);
            };

            $scope.date = new Date();
            $interval(function() {
                $scope.date = new Date();
                for(var i = 0 ; i < $scope.maxVmCount ; i++) {
                    $scope.nodes[i] = i < $scope.vmCount;
                }

            }, 1000);
        }
    ]);
