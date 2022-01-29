#!/bin/bash -e

prog_name=$(basename "$0")

usage()
{
  echo "
Usage:
 $prog_name [OPTIONS]

 Gets inner images to embedd in the system container used for Sysbox integration tests.

Options:
 -d, --debug        Debug mode (default false).
 -h, --help         Display this help and exit.
 -c, --clean        Don't get anything; perform cleanup actions.
 "
}

parseCmdArgs()
{
    opts=$(getopt \
               -o dhc \
               -l clean,debug,help \
               -n "$prog_name" \
               -- "$@"
        )

    eval set --$opts

    while :
    do
        case "$1" in
            -c | --clean )
	        clean="clean"
	        shift
	        ;;
            -h | --help )
	        usage
	        exit 0
	        ;;
            -d | --debug )
                debug="debug"
	        shift
	        ;;
            --) # End of all options
	        shift
	        break;
                ;;
            -*)
	        echo "Error: Unknown option: $1" >&2
                usage
	        exit 1
	        ;;
            *)  # No more options
	        break
	        ;;
        esac
    done

    # Check for any remaining unknown params after options
    if [ $# -ne 0 ]
    then
        echo "Error: invalid arguments in command line ($@)"
        exit 1
    fi
}

# the list of inner images to be retrieved
inner_img=( "mysql/mysql-server:8.0,mysql_server_8.0.tar"
            "python:alpine,python_alpine.tar"
            "elasticsearch:7.16.3,elasticsearch_7.16.3.tar"
            "alpine:3.10,alpine_3.10.tar"
            "httpd:alpine,httpd_alpine.tar"
            "fluentd:v1.14-1,fluentd_1.14.1.tar"
            "nginx:mainline-alpine,nginx_mainline_alpine.tar"
            "postgres:alpine,postgres_alpine.tar"
            "prom/prometheus,prometheus.tar"
            "redis:5.0.5-alpine,redis_5.0.5_alpine.tar"
            "influxdb:2.0-alpine,influxdb_2.0-alpine.tar"
            "telegraf:1.21,telegraf-1.21.tar" )

function get_img() {
  for i in "${inner_img[@]}"; do
    img=$(sh -c "echo \"$i\" | cut -f1 -d\",\"")
    tar=$(sh -c "echo \"$i\" | cut -f2 -d\",\"")

    if [ ! -f "$tar" ]; then
      docker pull "$img"
      docker save -o "$tar" "$img"
      docker image rm "$img"
    fi
  done
}

function clean_img() {
  for i in "${inner_img[@]}"; do
    img=$(sh -c "echo \"$i\" | cut -f1 -d\",\"")
    tar=$(sh -c "echo \"$i\" | cut -f2 -d\",\"")

    if [ -f "$tar" ]; then
      rm "$tar"
    fi
  done
}

parseCmdArgs $@

[ -n "$debug" ] && set -x

if [ -n "$clean" ]; then
  clean_img
else
  get_img
fi

exit 0
