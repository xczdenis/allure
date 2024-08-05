# Allure docker service
Allure docker service - это полноценный сервис, предоставляющий функционал allure в докере. Подробное описание см. [здесь](https://github.com/fescobar/allure-docker-service).

* Сервис доступен здесь: [http://localhost:5252](http://localhost:5252)
* Swagger здесь: [http://localhost:5050](http://localhost:5050)


## Makefile и скрипт make.sh
Для удобного выполнения команд имеется файл Makefile. Но на Windows команда `make` не работает. Для Windows создан скрипт `make.sh` - аналог Makefile. Запускать скрипт можно в консоли GitBash.

Например, команда `env` с помощью скрипта `make.sh` выполняется так:
```bash
. make.sh env
```

## Запустить
Сначала нужно создать файл `.env` - он создается копированием файла `.env.template`:
```bash
make env
# or
. make.sh env
```

На Windows `cmd`:
```bash
copy .env.template .env
```

Можно просто скопировать файл `.env.template` вручную.

Запустить в докере:
```bash
make run
# or
. make.sh run
```

После запуска доступны следующие url:
* [http://localhost:5050](http://localhost:5050) - open api
* [http://localhost:5252](http://localhost:5252) - сам сервис

Учетные данные см. в файле `.env`:
```text
SECURITY_USER=...
SECURITY_PASS=...
```

Остановить:
```bash
make down
# or
. make.sh down
```

Посмотреть логи (`Ctrl+C` чтобы выйти из режима просмотра логов):
```bash
make logs
# or
. make.sh logs <service_name>
```


## Команды

Получить полную информацию про докер (образы, контейнеры, тома и т.п.):
```bash
make di
# or
. make.sh di
```

Сбилдить образы:
```bash
make build
# or
. make.sh build
```

Выполнить команду докера `up -d --build`:
```bash
make up
# or
. make.sh up
```

Посмотреть логи сервиса `allure` (`Ctrl+C` чтобы выйти из режима просмотра логов):
```bash
make logs
# or
. make.sh logs allure
```
