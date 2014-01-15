#!/bin/sh

#iptables -A INPUT -p tcp -m tcp --dport 5127 -j ACCEPT
#iptables -A INPUT -p tcp -m tcp --sport 5127 -j ACCEPT

#iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
#iptables -A INPUT -p tcp -m tcp --sport 22 -j ACCEPT

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
