cd $DEVELOPMENT_APP_PATH

git checkout development
git pull origin development
git branch -D $DEVELOPMENT_BRANCH
git fetch origin
git checkout $DEVELOPMENT_BRANCH
git pull origin $DEVELOPMENT_BRANCH

cp /deploy/docker-compose-dev.yaml ./docker-compose.yaml

sudo docker-compose down
sudo docker-compose up --build -d