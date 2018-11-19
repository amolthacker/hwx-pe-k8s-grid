angular.module('virtus').factory('apiService', function($http, $rootScope, $q) {
    function signalDownload() {
        // TODO
    }

    function signalUpload() {
        // TODO
    }

    function httpGet(url, params) {
        signalUpload();
        return $http.get(url, params != null?{params: params}:null)
            .then(function(result) {signalDownload(); return result.data;}, function(error) {signalDownload(); throw error.data;});
    }

    return {
        /**
         * submit a job with a given number of trades
         * returns the requestId
         * @param tradeCount
         */
        submitJob: function(metric, tradeCount) {
            return httpGet("/api/submitJob/" + metric + "/" + tradeCount);
        },
        deleteAllJobAudits: function() {
            return httpGet("/api/deleteJobAudit/all");
        },
        deleteJobAudit: function(jobId) {
            return httpGet("/api/deleteJobAudit/" + jobId);
        },
        scaleCompute: function(scale) {
            return httpGet("/api/scaleCompute/" + scale);
        },
        getLogs: function() {
            return httpGet("/api/logs");
        },
        getDeployment: function() {
            return httpGet("/api/showDeployment");
//            return httpGet("/index/app/api-sample/showDeployment.json");
        },
        getJobs: function() {
            return httpGet("/api/showJobs");
//            return httpGet("/index/app/api-sample/showDeployment.json");
        },
        restartLogStream: function() {
            return httpGet("/api/restartLogStream");
        }

    };
});