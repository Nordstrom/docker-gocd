#!/bin/bash

touch /var/log/go-agent/go-agent.log
/usr/share/go-agent/agent.sh
exec tail -f /var/log/go-agent/go-agent.log
