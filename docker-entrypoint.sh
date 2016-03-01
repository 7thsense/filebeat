#!/bin/bash

set -e

# Add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
        set -- filebeat "$@"
fi

# ECS will report the docker interface without help, so we override that with host's private ip
#if [ -f /sys/hypervisor/uuid ] && [ `head -c 3 /sys/hypervisor/uuid` == ec2 ]; then
#fi

# Drop root privileges if we are running filebeat
if [ "$1" = 'filebeat' ]; then
        # Change the ownership of /usr/share/elasticsearch/data to elasticsearch
        chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data

	set -- "$@"
    exec gosu daemon filebeat "$@"
else
	# As argument is not related to elasticsearch,
	# then assume that user wants to run his own process,
	# for example a `bash` shell to explore this image
	exec "$@"
fi

