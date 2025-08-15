#!/bin/bash

# !/bin/bash — вказує, що скрипт потрібно виконувати через bash.
# Якщо запускати файл напряму (./script.sh), Linux знає, чим його обробити.

# для запуску з терміналу вводите 2 команди нижче
# перша дає право на виконанн, а друга запускає
# chmod +x init.sh
# ./init.sh

# створюємо папку для бази даних
mkdir mysql

# Встановлення docker
apt-get update
apt-get install -y docker.io

# Встановлення docker-compose (v1)
apt-get install -y docker-compose

# запускаємо скрипт створення першого сертифіката (вкажіть в скрипті свої домени)
chmod +x new_cert.sh
./new_cert.sh

chmod +x reload_cert.sh
echo "0 1 * * 1 bash $(pwd)/reload_cert.sh" | crontab -
# 01:00 - UTC, 04:00 - Kiev
# хвилина година день_місяця місяць день_тижня_понеділок
# echo "..." — виводить рядок у стандартний вивід.
# | — передає цей вивід як вхідні дані для наступної команди.
# crontab - — команда crontab читає завдання з стандартного вводу (через -)
# і встановлює це як crontab для поточного користувача

docker login -u hleb1488 -p zxcvbnm12345
docker-compose up -d