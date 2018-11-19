angular.module('virtus')
    .config(function($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('valengine', {
                url: "/valengine",
                templateUrl: '/static/app/valengine/valengine-view.html',
                controller: 'ValEngineController'
            })
            .state('logs', {
                url: "/logs",
                templateUrl: '/static/app/valengine/log.html'
            })
        ;
        $urlRouterProvider.otherwise("/valengine");


    })
;
