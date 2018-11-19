package main

import (
	"math/rand"
	"net/http"
	"os/exec"
	"runtime"
	"strconv"
	"time"

	"github.com/koding/kite"
	"github.com/koding/logging"
)

const veVersion = "1.0.0"
const qlVersion = "1.9.2"

func main() {

	go startHealthService()

	k := kite.New("valengine", veVersion)
	k.Config.Port = 6000
	k.Config.DisableAuthentication = true

	logging.Info("Starting HWX Valuation Engine [%s (QuantLib: %s)] ...", veVersion, qlVersion)

	k.HandleFunc("FwdRate", func(r *kite.Request) (interface{}, error) {
		return simulatedCompute("FwdRate", r)
	})

	k.HandleFunc("ParRate", func(r *kite.Request) (interface{}, error) {
		return simulatedParRateCompute(r)
		//return simulatedCompute("ParRate", r)
	})

	k.HandleFunc("NPV", func(r *kite.Request) (interface{}, error) {
		return simulatedCompute("NPV", r)
	})

	//cmd := "stress"
	k.HandleFunc("IRDelta", func(r *kite.Request) (interface{}, error) {
		//return simulatedIRDeltaCompute(cmd, r)
		return simulatedCompute("IRDelta", r)
	})

	k.HandleFunc("OptionPV", func(r *kite.Request) (interface{}, error) {
		return simulatedCompute("OptionPV", r)
	})

	k.Run()
}

func simulatedParRateCompute(r *kite.Request) (interface{}, error) {
	val := extractArgs(r)
	var sim int = int(val * 1000)
	return montecarloPi(sim), nil
}

func simulatedCompute(metric string, r *kite.Request) (interface{}, error) {
	var numTrades int = int(extractArgs(r))
	result := computeMetric(metric, numTrades)
	return result, nil
}

func simulatedIRDeltaCompute(cmd string, r *kite.Request) (interface{}, error) {
	val := extractArgs(r)
	stressTime := strconv.Itoa(int(val * 0.01))
	args := []string{"-c", "1", "-t", stressTime}
	exec.Command(cmd, args...).Run()
	return val * val, nil
}

func extractArgs(r *kite.Request) float64 {
	a := r.Args.One().MustFloat64()
	logging.Info("Processing Valuation Request %s [QL: %s] from '%s' for %s ...\n", r.ID, qlVersion, r.Client.Name, r.Method)
	return a
}

func startHealthService() {
	healthMux := http.NewServeMux()
	healthMux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
	})
	logging.Panic("", http.ListenAndServe(":8000", healthMux))
}

func computeMetric(metric string, numTrades int) float64 {
	cmd := "sh compute.sh"
	args := []string{metric, strconv.Itoa(numTrades)}
	if out, err := exec.Command(cmd, args...).Output(); err != nil {
		logging.Panic("Cannot compute metric ", err)
		return 0.0
	} else {
		if val, err := strconv.ParseFloat(string(out[0:len(out)-1]), 64); err != nil {
			logging.Panic("Cannot convert result to float ", err)
			return 0.0
		} else {
			return val
		}
	}

}

func init() {
	runtime.GOMAXPROCS(runtime.NumCPU())
	rand.Seed(time.Now().UnixNano())
}

func montecarloPi(samples int) float64 {
	cpus := runtime.NumCPU()

	threadSamples := samples / cpus
	results := make(chan float64, cpus)

	for j := 0; j < cpus; j++ {
		go func() {
			var inside int
			r := rand.New(rand.NewSource(time.Now().UnixNano()))
			for i := 0; i < threadSamples; i++ {
				x, y := r.Float64(), r.Float64()

				if x*x+y*y <= 1 {
					inside++
				}
			}
			results <- float64(inside) / float64(threadSamples) * 4
		}()
	}

	var total float64
	for i := 0; i < cpus; i++ {
		total += <-results
	}

	return total / float64(cpus)
}
