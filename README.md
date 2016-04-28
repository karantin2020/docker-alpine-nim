#Nim-lang docker image
for development

##Use

    docker pull node3030/nim-dev
    docker create -i -t --name nim node3030/nim-dev /bin/sh
    docker start -ai nim

or

    docker run --rm node3030/nim-dev sh -c "echo 'echo("'"Hello World"'")' | nim compile --run -"

or

    sudo docker run --rm -it node3030/nim-dev /bin/sh