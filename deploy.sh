#!/bin/bash

APP_NAME=retry-server
PATH=$PATH:/home/ubuntu/.nvm/versions/node/v16.15.0/bin

# 패키지 재설치
cd /home/ubuntu/drcloud-deploy
rm -rf ./node_modules
npm ci --only=production

# pm2 describe의 exit code가 0이 아니면 (앱이 실행중이지 않으면)
# 앱을 실행하고, 0 이면 (실행중이면) 앱을 재실행한다.
pm2 describe $APP_NAME > /dev/null
RUNNING=$?

if [ ${RUNNING} -ne 0 ]; then
  npm run start:prod
else
  npm run reload:prod
fi