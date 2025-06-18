#!/usr/bin/env bash

docker exec clab-option1-evpn-mh-client1 apk add bmon

echo "Initial pings to populate MAC+ARP entries"
docker exec clab-option1-evpn-mh-client1 ping -c1 100.0.1.1
docker exec clab-option1-evpn-mh-client1 ping -c1 100.0.2.1
docker exec clab-option1-evpn-mh-client1 ping -c1 100.0.2.101
docker exec clab-option1-evpn-mh-client1 ping -c1 100.0.2.102
docker exec clab-option1-evpn-mh-client1 ping -c1 100.0.2.103
docker exec clab-option1-evpn-mh-client1 ping -c1 100.0.2.104
docker exec clab-option1-evpn-mh-client1 ping -c1 100.0.2.105

docker exec clab-option1-evpn-mh-client2 ping -c1 100.0.1.101
docker exec clab-option1-evpn-mh-client2 ping -c1 100.0.1.102
docker exec clab-option1-evpn-mh-client2 ping -c1 100.0.1.103
docker exec clab-option1-evpn-mh-client2 ping -c1 100.0.1.104
docker exec clab-option1-evpn-mh-client2 ping -c1 100.0.1.105

echo "Starting traffic"
docker exec clab-option1-evpn-mh-client2 pkill iperf3
docker exec -d clab-option1-evpn-mh-client2 iperf3 -c 100.0.1.101 -p5201 -t 50000 -b 2M
docker exec -d clab-option1-evpn-mh-client2 iperf3 -c 100.0.1.101 -p5202 -t 50000 -b 2M
docker exec -d clab-option1-evpn-mh-client2 iperf3 -c 100.0.1.101 -p5203 -t 50000 -b 2M
docker exec -d clab-option1-evpn-mh-client2 iperf3 -c 100.0.1.102 -p5201 -t 50000 -b 2M
docker exec -d clab-option1-evpn-mh-client2 iperf3 -c 100.0.1.102 -p5202 -t 50000 -b 2M
docker exec -d clab-option1-evpn-mh-client2 iperf3 -c 100.0.1.102 -p5203 -t 50000 -b 2M

docker exec -it clab-option1-evpn-mh-client1 bmon -b