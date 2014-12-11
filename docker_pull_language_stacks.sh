
git config --global user.email "github@mjbright.net"
git config --global user.name "Mike Bright"

lang_stacks="python:2.7 python:3.4"

for lang in $lang_stacks; do
    echo "docker pull $lang"
    docker pull $lang
done
