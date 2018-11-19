# compute-manager

[compute-manager](https://github.com/amolthacker/compute-manager) is a web based management user interface for the 
[compute-engine](https://github.com/amolthacker/compute-engine) that facilitates following operational tasks:
* Submission of valuation jobs to the compute engine
* Scaling of compute
* Aggregated compute engine log stream

The backend is written in Go and frontend with AngularJS


## Running compute-manager

### Pre-requisites
 * Installation of [Go](https://golang.org/doc/install)
 * [compute-engine](https://github.com/amolthacker/compute-engine) running with Docker in a Kubernetes cluster 
 (or locally with [Minikube](https://github.com/kubernetes/minikube))
 * Installation of scripts under the project's `scripts` directory
 
### Instructions

 * Get library dependencies for:
    *  [Kite](https://github.com/koding/kite) micro-service framework
    * Go client for Kubernetes
    * Configuration definition support
```
go get github.com/koding/kite
go get bitbucket.org/amdatulabs/amdatu-kubernetes-go
go get github.com/spf13/viper
```

 * Update the `config/env.toml` file to use the setup environment properties for compute-engine and Kubernetes

 * Run the web server
 ```
 $ cd ${path-to-compute-manager} 
 $ go run ComputeManager.go
 ```

* Access the Web UI
```
http://localhost:8090/login
```

## ToDo

* Replace the partial use of `kubectl` with the use 
[Official Go client for Kubernetes](https://github.com/kubernetes/client-go/tree/v2.0.0)
* Cleanup scripts
* Support for running compute-manager locally on Windows using Minikube
