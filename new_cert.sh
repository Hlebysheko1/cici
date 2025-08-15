#!/bin/bash

# !/bin/bash — вказує, що скрипт потрібно виконувати через bash.
# Якщо запускати файл напряму (./script.sh), Linux знає, чим його обробити.

# для запуску з терміналу вводите 2 команди нижче
# перша дає право на виконанн, а друга запускає
# chmod +x new_cert.sh
# ./new_cert.sh
#  Використовується для створення першого сертифіката або додавання нових доменів. 
#  Зупиняє nginx, тому сайт декілька секунд може бути недоступний. 
#  І тому краще використовувати інший спосіб для оновлення сертифікатів

# Всі домени через пропуск
# Email для Let’s Encrypt
EMAIL="hleb.vasvlad2011@gmail.com"
DOMAINS="www.hleb.pp.ua hleb.pp.ua"
# се буде створено відносно місця запуску
CERT_DIR="$(pwd)/letsencrypt"

# Зупини nginx (щоб порт 80 був вільний), якщо він був запущений
docker stop my-nginx || true

# Отримати сертифікат через Docker з мережею хоста (без NAT)
docker run --rm --network host \
  -v "$CERT_DIR:/etc/letsencrypt" \
  certbot/certbot certonly \
  --standalone \
  $(for d in $DOMAINS; do echo -n "-d $d "; done) \
  --email "$EMAIL" \
  --agree-tos \
  --no-eff-email \
  --non-interactive
# Email для повідомлень від Let's Encrypt
# Автоматична згода з умовами використання
# Не підписуватись на розсилку
# Запуск без інтерактивних запитань

# Запусти nginx знову
docker start my-nginx || true