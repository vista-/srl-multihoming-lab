#!/usr/bin/env bash

# Install iperf3 and bmon2
docker exec clab-option2-hostrouting-client1 apk add iperf3 bmon tcpdump
docker exec clab-option2-hostrouting-client2 apk add iperf3 bmon tcpdump

# Start iperf3 servers
## Client1
docker exec clab-option2-hostrouting-client1 iperf3 -s -B 100.0.1.101 -p5201 -D
docker exec clab-option2-hostrouting-client1 iperf3 -s -B 100.0.1.101 -p5202 -D
docker exec clab-option2-hostrouting-client1 iperf3 -s -B 100.0.1.101 -p5203 -D
docker exec clab-option2-hostrouting-client1 iperf3 -s -B 100.0.1.102 -p5201 -D
docker exec clab-option2-hostrouting-client1 iperf3 -s -B 100.0.1.102 -p5202 -D
docker exec clab-option2-hostrouting-client1 iperf3 -s -B 100.0.1.102 -p5203 -D

# Start iperf3 clients
## Client2
docker exec -d clab-option2-hostrouting-client2 iperf3 -c 100.0.1.101 -p5201 -t 50000 -M 1400 -b 2M
docker exec -d clab-option2-hostrouting-client2 iperf3 -c 100.0.1.101 -p5202 -t 50000 -M 1400 -b 2M
docker exec -d clab-option2-hostrouting-client2 iperf3 -c 100.0.1.101 -p5203 -t 50000 -M 1400 -b 2M
docker exec -d clab-option2-hostrouting-client2 iperf3 -c 100.0.1.102 -p5201 -t 50000 -M 1400 -b 2M
docker exec -d clab-option2-hostrouting-client2 iperf3 -c 100.0.1.102 -p5202 -t 50000 -M 1400 -b 2M
docker exec -d clab-option2-hostrouting-client2 iperf3 -c 100.0.1.102 -p5203 -t 50000 -M 1400 -b 2M

# View traffic on client1
docker exec -it clab-option2-hostrouting-client1 bmon -b