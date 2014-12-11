#!/bin/sh

################################################################################
# Helper functions:
FAIL() {
    echo "$0: FAIL - $*" >&2
    exit 1
}

#echo; echo; echo "-- $(date) -----------"
#echo "[$PWD] $0 $*"

################################################################################
# Argument parsing:

[ -z "$1" ] && FAIL "No interpreter provided"
INTERPRETER=$1; shift

[ -z "$1" ] && FAIL "No script name provided"
SCRIPT=$1; shift

# Choose the language stack based on the specified image.
case $INTERPRETER in
    python:2.7) IMAGE=python;
              IMAGE_TAG=2.7;
              EXE=python;
              ;;
    python:3.4) IMAGE=python;
              IMAGE_TAG=3.4;
              EXE=python;
              ;;
    *) FAIL "Unknown interpreter '$INTERPRETER'";;
esac

################################################################################
# Run script in appropriate docker container

#docker run -v $PWD/:/src -it ${IMAGE}:${IMAGE_TAG} bash -c "echo HI; ls -altr /src/; chmod +x $SCRIPT; $EXE $SCRIPT" < $SCRIPT

# Determine script location and filename from full path:
SCRIPT_DIR=${SCRIPT%/*}
[ "$SCRIPT_DIR" = "$SCRIPT" ] && SCRIPT_DIR=$PWD
SCRIPT_FILE=${SCRIPT##*/}

# Invoke script in container:
#docker run -v $SCRIPT_DIR/:/src -t ${IMAGE}:${IMAGE_TAG} bash -c "ls -altr /src; echo HELLO; $EXE /src/$SCRIPT_FILE"; } |& tee -a /tmp/docker_run.op
{
set -x;
docker run -v $SCRIPT_DIR/:/src -t ${IMAGE}:${IMAGE_TAG} bash -c "$EXE /src/$SCRIPT_FILE"; } 2>&1| tee -a /tmp/docker_run.op
set +x


  #docker run -it base helloworld.py
