#!/bin/bash

# Exit in case of any error
set -e

source ./scripts/logger.sh
source ./scripts/utils.sh

run_docker_compose() {
    USER_UID=$(id -u)
    USER_GID=$(id -g)
    docker-compose -f docker-compose.yml "$@"
}

PROJECT_ROOT_DIR="$HOME/projects/allure"

log_header "Запуск проекта в докере"

whoami

log_info "Переход в корневую директорию проекта '$PROJECT_ROOT_DIR'"
cd "$PROJECT_ROOT_DIR"

log_info "Pull из удаленного репозитория"
git pull

log_info "Остановка и удаление запущеных докер контейнеров"
run_docker_compose down

projects_path="projects"
if [[ ! -d "$projects_path" ]]; then
    log_info "Создание каталога проектов '$projects_path'"
    mkdir -p "$projects_path"
fi
chmod 777 "$projects_path"

log_info "Запуск докер контейнеров"
run_docker_compose up -d --build

log_info "Удаление зависших и неисопльзуемых контейнеров, сетей, образов"
docker system prune -f
