package main

import (
	"encoding/json"
	"log"
	"math/rand"
	"net/http"
	"os"
	"os/exec"
	"strconv"
	"strings"
	"sync"
	"time"

	"bitbucket.org/amdatulabs/amdatu-kubernetes-go/api/v1"
	"bitbucket.org/amdatulabs/amdatu-kubernetes-go/client"
	"github.com/gorilla/mux"
	"github.com/spf13/viper"
)

////////////////////////////////////////////////////////////////////////////////////////////
// Defaults
////////////////////////////////////////////////////////////////////////////////////////////

var HWXPE_COMPUTE_MGR_HTTP_PORT = ":8090"
var HWXPE_COMPUTE_BASE_PATH = "/home/hwxadmin/hwx-pe/compute"

var K8S_PROXIED_API_SERVER_URL = "http://localhost:8001"
var K8S_CMD = "/usr/local/bin/kubectl"
var K8S_DEPLOYMENT = "valengine-prod"
var K8S_NAMESPACE = "default"
var K8S_AGENT_DNS = "localhost"
var K8S_LOG_STREAM_CMD = "/usr/local/bin/restart-container-log-stream"

////////////////////////////////////////////////////////////////////////////////////////////

var SUPPORTED_METRICS = []string{"FwdRate", "ParRate", "NPV", "IRDelta", "OptionPV"}

type PodInfo struct {
	PodName     string
	PodStatus   v1.PodPhase
	PodNodeName string
}

type JobInfo struct {
	JobId        string
	JobMetric    string
	JobSize      string
	JobStartTime time.Time
	JobEndTime   time.Time
	JobStatus    string
}

var cMap = struct {
	sync.RWMutex
	item map[string]*JobInfo
}{item: make(map[string]*JobInfo)}

var kubernetes client.Client

func main() {

	viper.SetConfigName("env")
	viper.AddConfigPath("config")
	err := viper.ReadInConfig()
	if err != nil {
		log.Fatal("Config file not found")
		os.Exit(1)
	}

	HWXPE_COMPUTE_MGR_HTTP_PORT = viper.GetString("hwxpe.compute_manager_http_port")
	HWXPE_COMPUTE_BASE_PATH = viper.GetString("hwxpe.compute_base_path")
	K8S_PROXIED_API_SERVER_URL = viper.GetString("k8s.api_server_url")
	K8S_CMD = viper.GetString("k8s.cmd")
	K8S_DEPLOYMENT = viper.GetString("k8s.deployment")
	K8S_NAMESPACE = viper.GetString("k8s.namespace")
	K8S_AGENT_DNS = viper.GetString("k8s.agent_dns")
	K8S_LOG_STREAM_CMD = viper.GetString("k8s.log_stream_cmd")

	kubernetes = client.NewClient(K8S_PROXIED_API_SERVER_URL, "", "")
	server := http.NewServeMux()
	router := mux.NewRouter()

	staticHandler := http.FileServer(http.Dir("./static"))

	server.Handle("/static/", http.StripPrefix("/static", staticHandler))
	server.HandleFunc("/index", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, "./static/index.html")
	})
	server.HandleFunc("/login", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, "./static/login.html")
	})
	server.Handle("/", router)

	router.HandleFunc("/api/submitJob/{metric}/{numTrades}", handleSubmitJob)
	router.HandleFunc("/api/scaleCompute/{scale}", handleScaleCompute)
	router.HandleFunc("/api/showDeployment", handleShowDeployment)
	router.HandleFunc("/api/showJobs", handleShowJobs)
	router.HandleFunc("/api/deleteJobAudit/{jobId}", handleDeleteJobAudit)
	router.HandleFunc("/api/restartLogStream", handleRestartLogStream)

	log.Printf("Http Server Started [%s]", HWXPE_COMPUTE_MGR_HTTP_PORT)
	http.ListenAndServe(HWXPE_COMPUTE_MGR_HTTP_PORT, server)
}

func handleSubmitJob(w http.ResponseWriter, r *http.Request) {
	metric := mux.Vars(r)["metric"]
	if !contains(metric, SUPPORTED_METRICS) {
		http.Error(w, metric+" is not a supported metric", http.StatusInternalServerError)
		return
	}
	numTrades := mux.Vars(r)["numTrades"]
	id := rand.Intn(1000)
	idStr := strconv.Itoa(id)

	jobInfo := JobInfo{idStr, metric, numTrades, time.Now(), time.Now(), "Running"}
	addJobInfo(&jobInfo)

	nT, _ := strconv.Atoi(numTrades)
	batchSize := 100
	for nT > batchSize {
		nT = nT - batchSize
		go runJob(idStr, metric, strconv.Itoa(batchSize))
	}
	go runJob(idStr, metric, strconv.Itoa(nT))

	w.Write([]byte("OK"))
}

func handleScaleCompute(w http.ResponseWriter, r *http.Request) {
	scale := mux.Vars(r)["scale"]
	replicas := "--replicas=" + scale
	args := []string{"scale", "deployment", K8S_DEPLOYMENT, replicas}

	log.Printf("Executing cmd: %s %s\n", K8S_CMD, args)
	err := exec.Command(K8S_CMD, args...).Run()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	handleShowDeployment(w, r)
}

func handleShowDeployment(w http.ResponseWriter, r *http.Request) {
	pods, err := kubernetes.ListPods(K8S_NAMESPACE)
	if err != nil {
		panic(err)
	}

	var cluster []PodInfo
	for _, pod := range pods.Items {
		if strings.Contains(pod.Name, K8S_DEPLOYMENT) {
			log.Printf("%s | %s | %s | %s | %s\n",
				pod.Name, pod.Status.Phase, pod.Status.PodIP, pod.Spec.NodeName, pod.Status.HostIP)
			cluster = append(cluster, PodInfo{pod.Name, pod.Status.Phase, pod.Spec.NodeName})
		}
	}

	js, err := json.Marshal(cluster)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(js)
}

func handleRestartLogStream(w http.ResponseWriter, r *http.Request) {
	log.Println("Restarting Container log stream ...")
	err := exec.Command(K8S_LOG_STREAM_CMD).Run()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Write([]byte("OK"))
}

func handleShowJobs(w http.ResponseWriter, r *http.Request) {
	jobs := []*JobInfo{}
	for job := range cMapIter() {
		jobs = append(jobs, job)
	}

	js, err := json.Marshal(jobs)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(js)
}

func handleDeleteJobAudit(w http.ResponseWriter, r *http.Request) {
	jobId := mux.Vars(r)["jobId"]
	if jobId == "all" {
		cMap.item = make(map[string]*JobInfo)
	} else {
		delete(cMap.item, jobId)
	}

	w.Write([]byte("OK"))
}

// send items in concurrent map over channel to facilitate range scan
func cMapIter() <-chan *JobInfo {
	c := make(chan *JobInfo)

	f := func() {
		cMap.Lock()
		defer cMap.Unlock()

		var jobs []*JobInfo
		for _, job := range cMap.item {
			jobs = append(jobs, job)
			c <- job
		}
		close(c)
	}

	go f()

	return c
}

func runJob(id string, metric string, numTrades string) {
	cmd := "go"
	var progPath string = HWXPE_COMPUTE_BASE_PATH + "/compute-engine/eodservice.go"
	args := []string{
		"run",
		progPath,
		id,
		K8S_AGENT_DNS,
		metric,
		numTrades,
	}

	var jobStatus string = "Completed"
	var jobEndTime time.Time

	log.Printf("Executing %s %s", cmd, strings.Join(args, " "))
	err := exec.Command(cmd, args...).Run()
	//err := exec.Command("sleep", "5").Run()
	if err != nil {
		log.Fatalf("Error executing job %s - %s", id, err.Error())
		jobStatus = "Failed"

	}
	jobEndTime = time.Now()

	updateJobInfo(id, jobStatus, jobEndTime)
}

func updateJobInfo(idStr string, jobStatus string, jobEndTime time.Time) {
	cMap.Lock()
	jobInfo := cMap.item[idStr]
	jobInfo.JobStatus = jobStatus
	jobInfo.JobEndTime = jobEndTime
	cMap.Unlock()
}

func addJobInfo(jobInfo *JobInfo) {
	cMap.Lock()
	cMap.item[jobInfo.JobId] = jobInfo
	cMap.Unlock()
}

func contains(a string, list []string) bool {
	for _, b := range list {
		if b == a {
			return true
		}
	}
	return false
}
