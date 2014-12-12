
#ssh -i /c/Progs/Boot2Docker/id_boot2docker -p 2022 -L 10086:localhost:10086 docker@127.0.0.1
#echo $0 $*

INTERPRETER=python3
[ ! -z "$1" ] && INTERPRETER="$1"

SCRIPT=""
[ ! -z "$2" ] && SCRIPT="$2"
chmod a+rx $SCRIPT

shift
shift

FAILED() {
	echo "$0: FAILED - $*" >&2
	echo "Press <return>" >&2
	read _DUMMY
	exit 1
}

checkInterpreter() {
    case $1 in
    	python:2.7) return;;
    	python:3.4) return;;
    	*) FAILED "Unknown interpreter $INTERPRETER";;
    esac
}

checkInterpreter $INTERPRETER

FILE=$(/usr/bin/cygpath -u $SCRIPT)
VM_SCRIPT=${FILE##*/}

echo \$FILE=$FILE
echo \$VM_SCRIPT=$VM_SCRIPT
#FAILED "JUST TESTING"

SSH_PORT=2022
SSH_KEY="/cygdrive/c/Progs/Boot2Docker/id_boot2docker"
SCP_COMMAND="/usr/bin/scp -P $SSH_PORT -i $SSH_KEY $FILE docker@127.0.0.1:"
SSH_COMMAND="/usr/bin/ssh -p $SSH_PORT -i $SSH_KEY docker@127.0.0.1 ./docker_run.sh $INTERPRETER $VM_SCRIPT"


set -x
$SCP_COMMAND
$SSH_COMMAND
set +x

