cd "/opt/Nim"
git fetch origin
if ! git merge FETCH_HEAD | grep "Already up-to-date"; then
    bin/nim c koch
    ./koch boot -d:release
fi