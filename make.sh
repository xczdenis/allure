#!/bin/bash

if [ -f .env ]; then
    . .env
fi


source scripts/logger.sh
source scripts/utils.sh


ping() {
    echo "PONG"
}


run_docker_compose() {
    docker-compose "$@"
}


# display info about running docker containers, images, volumes
di() {
    log_header "Running containers:"
    docker ps
    echo
    log_header "All containers:"
    docker ps -a
    echo
    log_header "Images:"
    docker images
    echo
    log_header "Volumes:"
    docker volume ls
    echo
    log_header "Networks:"
    docker network ls
}


# stop and remove all running containers
down() {
    log_header "Down containers"
    run_docker_compose down
}


# build all docker images
build() {
    log_header "Build all images"
    run_docker_compose build
}


# run docker containers in demon mode
up() {
    log_header "Run docker containers in daemon mode"
    run_docker_compose up -d --build
}


# stop and remove all running containers and then run docker containers in demon mode
run() {
    down
    up
}


# display logs for a specific service
logs() {
    if [ -z "$1" ]; then
        msg_error "Необходимо указать имя контейнера"
    fi

    local service_name="$1"
    run_docker_compose logs -f "${service_name}"
}

case "$1" in
    ping)
        ping
        ;;
    env)
        create_or_overwrite_file ".env.template" ".env"
        ;;
    di)
        di
        ;;
    down)
        down
        ;;
    up)
        up
        ;;
    build)
        build
        ;;
    run)
        run
        ;;
    logs)
        logs "$2"
        ;;
    *)
        msg_error "Команда не указана или указана не правильно"
        ;;
esac
