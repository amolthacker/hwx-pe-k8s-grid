angular.module('virtus')
    .controller('LoginController', ['$scope', '$cookies',
        function($scope, $cookies) {
            $scope.loginForm = {'username': 'test', 'password': 'test'};
            $scope.loginError = null;

            $scope.login = function() {
                if ($scope.loginForm.username != 'test' || $scope.loginForm.username != 'test') {
                    $scope.loginError = "Invalid username/password";
                    return;
                }

                $cookies.put('username', $scope.loginForm.username);
                $cookies.put('connected', '1');
                document.location.href = "/index?";
            };

        }
    ]);
