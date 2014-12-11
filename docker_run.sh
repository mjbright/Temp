
FAIL() {
    echo "$0: FAIL - $*" >&2
    exit 1
}

[ -z "$1" ] && FAIL "No interpreter provided"
INTERPRETER=$1; shift

[ -z "$1" ] && FAIL "No script name provided"
SCRIPT=$1; shift

case $INTERPRETER in
    python27) IMAGE=python;
              IMAGE_TAG=2.7;
              EXE=python;
              ;;
    *) FAIL "Unknown interpreter '$INTERPRETER'";;
esac


#docker run -v $PWD/:/src -it ${IMAGE}:${IMAGE_TAG} bash -c "echo HI; ls -altr /src/; chmod +x $SCRIPT; $EXE $SCRIPT" < $SCRIPT
set -x
docker run -v $PWD/:/src -it ${IMAGE}:${IMAGE_TAG} bash -c "ls -altr /src; echo HELLO; $EXE /src/$SCRIPT"
set +x


  #docker run -it base helloworld.py
