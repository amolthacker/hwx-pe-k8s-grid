var app = angular.module('virtus', [
    'ng',
    'ui.router',
    'ngAnimate',
    'ngMaterial',
    'ngAria',
    'ngCookies',
    'md.data.table'
]);

app.filter('unsafe', function($sce) { return $sce.trustAsHtml; });

angular.module('virtus')
    .config(function($mdThemingProvider) {
        $mdThemingProvider.theme('default')
            .primaryPalette('green')
            .accentPalette('grey');
    });