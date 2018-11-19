angular.module('virtus')
    .controller('ValEngineController', ['$scope', '$http', '$timeout', '$interval', '$mdToast', 'apiService',
        function($scope, $http, $timeout, $interval, $mdToast, apiService) {
            $scope.logs = ["Loading..."];

            $scope.metricTypes = ["FwdRate", "ParRate", "NPV", "IRDelta", "OptionPV"];

            $scope.jobOrder = "id";

            $scope.query = {
                order: '-JobStartTime'
            };

            var ws;

            $scope.initWebSocketConnection = function() {
                ws = new WebSocket('ws://' + window.location.hostname + ':8888/');
                ws.onmessage = function(event) {
                    $scope.logs.push(event.data);
                    $scope.$apply(function() {
                        $timeout(function() {
                            var logsDiv = document.getElementById("logs");
                            logsDiv.scrollTop = logsDiv.scrollHeight + 40;
                        }, 100);
                    });

                    // $timeout(function() {
                    //     var logsDiv = document.getElementById("logs");
                    //     logsDiv.scrollTop = logsDiv.scrollHeight;
                    // }, 100);
                };

                ws.onclose = function(e) {
                    console.log("connection lost, trying to connect again...");
                    $scope.initWebSocketConnection();
                }
            };

            $scope.initWebSocketConnection();

            $scope.valEngineCount = 2;
            $scope.currentValEngineCount = 0;
            $scope.date = new Date().getTime();

            $scope.ansiToHtml = function(log) {
                return ansi_up.ansi_to_html(log);
            };

            $scope.getPodColor = function(pod) {
                switch(pod.PodStatus) {
                    case "Running": return 'green';
                    case "Starting": return 'orange';
                    default: return 'grey';
                }
            };

            $scope.scaleValEngine = function(scale) {
                $scope.valEngineCount = scale;
                apiService.scaleCompute(scale).then(function() {
                    $timeout(function() {
                        apiService.restartLogStream();
                    });
                    $mdToast.show(
                        $mdToast.simple()
                            .textContent('Scaling Valuation Engine to ' + scale + ' !')
                            .position('top right')
                            .hideDelay(2000)
                    );
                });
            };

            $scope.restartLogStream = function() {
                apiService.restartLogStream().then(function() {
                    $mdToast.show(
                        $mdToast.simple({'position': 'top'})
                            .textContent('Log Stream Restarted!')
                            .position('top right')
                            .hideDelay(2000)
                    );
                });
            };

            $scope.refreshDeployment = function() {
                apiService.getDeployment().then(function(deployment) {
                    // get pods by node
                    $scope.currentValEngineCount = 0;
                    $scope.podsByNodeName = {};
                    for(var i = 0 ; i < deployment.length ; i++) {
                        var pod = deployment[i];
                        pods = $scope.podsByNodeName[pod.PodNodeName];
                        if (pods == null) {
                            pods = [];
                            $scope.podsByNodeName[pod.PodNodeName] = pods;
                        }
                        if (pod.PodStatus === 'Running') {
                            $scope.currentValEngineCount++;
                        }
                        pods.push(pod);

                    }
                    if ($scope.currentValEngineCount !== $scope.valEngineCount) {
                        apiService.restartLogStream();
                        $mdToast.show(
                            $mdToast.simple({'position': 'top'})
                                .textContent('Valuation Engine scaled to ' + $scope.currentValEngineCount)
                                .position('top right')
                                .hideDelay(2000)
                        );

                        $scope.valEngineCount = $scope.currentValEngineCount;
                    }

                });
            };

            $scope.getJobDuration = function(job) {
                var endTime = (job.JobEndTime !== null)?job.JobEndTime:new Date();
                var duration = endTime.getTime() - job.JobStartTime.getTime();
                if (duration < 1000) {
                    return duration + "ms";
                } else if (duration < 60000) {
                    return Math.round(duration / 1000) + "s";
                } else if (duration < 3600000) {
                    return Math.round(duration / (60 * 1000)) + "min";
                } else {
                    return Math.round(duration / (60 * 60 * 1000)) + "h";
                }
            };

            $scope.refreshJobs = function() {
                apiService.getJobs().then(function(jobs) {
                    jobs.forEach(function(job) {
                        if (job.JobStartTime != null) job.JobStartTime = new Date(job.JobStartTime);
                        if (job.JobStatus != 'Completed') job.JobEndTime = null;
                        if (job.JobEndTime != null) job.JobEndTime = new Date(job.JobEndTime);
                    });

                    $scope.jobs = jobs;
                });
            };


            // $scope.refreshLogs = function() {
            //     apiService.getLogs().then(function(logs) {
            //         $scope.logs = logs;
            //         $timeout(function() {
            //             var logsDiv = document.getElementById("logs");
            //             logsDiv.scrollTop = logsDiv.scrollHeight;
            //         }, 100);
            //     });
            // };

            // refresh deployment every 5 seconds
            $interval($scope.refreshDeployment, 5000);
            $interval($scope.refreshJobs, 5000);
//            $interval($scope.refreshLogs, 5000);

            $scope.refreshDeployment();
            $scope.refreshJobs();
//            $scope.refreshLogs();

            $scope.processingJob = false;

            $scope.jobRequest = {tradeCount: 10, metricType: "NPV"};
            $scope.jobs = [];


            $scope.clearJob = function(jobId) {
                apiService.deleteJobAudit(jobId).then(function() {
                    $scope.refreshJobs();
                    $mdToast.show(
                        $mdToast.simple({'position': 'top'})
                            .textContent('Jobs Audit deleted!')
                            .position('top right')
                            .hideDelay(2000)
                    );
                });
            }

            $scope.clearJobs = function() {
                apiService.deleteAllJobAudits().then(function() {
                    $scope.refreshJobs();
                    $mdToast.show(
                        $mdToast.simple({'position': 'top'})
                            .textContent('All Jobs Audit deleted!')
                            .position('top right')
                            .hideDelay(2000)
                    );
                });
            };

            $scope.submitJob = function() {
                $scope.processingJob = true;
                apiService.submitJob($scope.jobRequest.metricType, $scope.jobRequest.tradeCount).then(function(job) {
                    $scope.processingJob = false;
                    $scope.refreshJobs();
                    $mdToast.show(
                        $mdToast.simple({'position': 'top'})
                            .textContent('Job submitted!')
                            .position('top right')
                            .hideDelay(2000)
                    );
                });
            }
        }
    ]);
