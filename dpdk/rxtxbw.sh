 
#!/bin/bash
 
ETH_PKT_OVERHEAD=20 # interpacket gap 12B + Preamble 8B
 
query_ethtool () { # $name
    TS_LAST=$TS
    R_PKT_LAST=$R_PKT
    R_BYTE_LAST=$R_BYTE
    T_PKT_LAST=$T_PKT
    T_BYTE_LAST=$T_BYTE
 
    out=($(ethtool -S $1 | awk '/tx_packets_phy/{print $2} /rx_packets_phy/{print $2} /tx_bytes_phy/{print $2} /rx_bytes_phy/{print $2}'))
 
    TS=$(date +%s%6N)
    T_PKT=${out[0]}
    R_PKT=${out[1]}
    T_BYTE=${out[2]}
    R_BYTE=${out[3]}
}
 
NETIF=$1
 
if [ -z "$NETIF" ]; then
    printf "Need interface on which to measure the throughput\n"
    exit 1
fi
 
query_ethtool $NETIF
 
sleep 1
 
while true; do
 
    query_ethtool $NETIF
    
    TS_DIFF=$(($TS - $TS_LAST))
    
    R_PKT_DELTA=$(( $R_PKT - $R_PKT_LAST ))
    R_BIT_DELTA=$(( ($R_BYTE - $R_BYTE_LAST + $ETH_PKT_OVERHEAD * $R_PKT_DELTA) * 8 ))
    R_BIT_RATE=$(( $R_BIT_DELTA / $TS_DIFF))
    
    T_PKT_DELTA=$(( $T_PKT - $T_PKT_LAST ))
    T_BIT_DELTA=$(( ($T_BYTE - $T_BYTE_LAST + $ETH_PKT_OVERHEAD * $T_PKT_DELTA) * 8 ))
    T_BIT_RATE=$(( $T_BIT_DELTA / $TS_DIFF))
    
    printf "%s: %7d Mbps RX  | %7d Mbps TX\n" $NETIF $R_BIT_RATE $T_BIT_RATE 
    sleep 1
done
