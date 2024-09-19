package main

import (
	"flag"
	"fmt"
	"net/http"
	"log"
	"os"
	"os/signal"
	"context"
)

type PortFlag struct {
	Value *int
}

func (port *PortFlag) Set(value string) error {
	var p int
	_, err := fmt.Sscanf(value, "%d", &p)
	if err != nil || p < 1 || p > 65535 {
		return fmt.Errorf("invalid port: %s", value)
	}
	*port.Value = p
	return nil
}

func (port *PortFlag) String() string {
	return fmt.Sprintf("%d", *port.Value)
}

func main() {
	portPtr := new(int)
	portFlag := PortFlag{Value: portPtr}
	flag.Var(&portFlag, "port", "port to listen on (1-65535), default 8080")
	flag.Parse()

	fs := http.FileServer(http.Dir("./static"))
	http.Handle("/", fs)

	log.Printf("Listening on :%d...\n", *portPtr)

	server := &http.Server{Addr: fmt.Sprintf(":%d", *portPtr)}

	go func() {
		if err := server.ListenAndServe(); err != nil {
			log.Fatal(err)
		}
	}()

	// Wait for a signal to shutdown
	sig := make(chan os.Signal, 1)
	signal.Notify(sig, os.Interrupt)
	<-sig

	log.Println("Shutting down...")
	if err := server.Shutdown(context.Background()); err != nil {
		log.Fatal(err)
	}
}
