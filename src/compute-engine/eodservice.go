package main

import (
	"os"
	"strconv"
	"github.com/koding/kite"
	"github.com/koding/logging"
)

func main() {

	numArgs := len(os.Args)

	if numArgs != 5 {
		exitOnUsageErr()
	}

	id  := os.Args[1]
	dns := os.Args[2]

	supportedMetrics := []string{"FwdRate", "ParRate", "NPV", "IRDelta", "OptionPV"}
	metric := os.Args[3]
	if !contains(metric, supportedMetrics) {
		exitOnUsageErr()
	}

	numTrades, err := strconv.Atoi(os.Args[4])
	if err != nil {
		exitOnUsageErr()
	}

	k := kite.New("eodservice-" + id, "1.0.0")
	client := k.NewClient("http://" + dns + ":6000/kite")
	client.Dial()

	var nT int = numTrades
	batchSize := 100
	for nT > batchSize {
		nT = nT - batchSize
		dispatchValRequests(client, metric, batchSize)

	}
	dispatchValRequests(client, metric, nT)

}

func dispatchValRequests(client *kite.Client, metric string, nT int){
	logging.Info("Requesting %s for %d Trades ...\n", metric, nT)
	response, err := client.Tell(metric, nT)
	if err == nil{
		logging.Info("Agg %s for %d Trades : %g\n", metric, nT, response.MustFloat64())
	} else {
		exitOnNoResponse()
	}
}


func exitOnUsageErr(){
	usage()
	os.Exit(1)
}

func exitOnNoResponse(){
	logging.Panic("No Reponse")
	os.Exit(1)
}

func usage(){
	logging.Info("go run eodservice.go <id(int)> <valengineDNS(string)> <metric(FwdRate|ParRate|NPV|IRDelta|OptionPV)> <numRequests(int)>")
}

func contains(a string, list []string) bool {
	for _, b := range list {
		if b == a {
			return true
		}
	}
	return false
}
