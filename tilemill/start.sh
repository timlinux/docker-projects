#!/bin/bash

# Map the linked container's postgresql port to appear as if it is
# running locally on 5432

# The ADDR and PORT env vars below are automatically set to the linked
# container for you by docker
socat TCP-LISTEN:5432,reuseaddr,fork TCP:$PG_PORT_5432_TCP_ADDR:$PG_PORT_5432_TCP_PORT

supervisord -n
