if [ ${TRAVIS_PULL_REQUEST} = "false" -a ${TRAVIS_BRANCH} = $DEVELOPMENT_BRANCH ]; then
	openssl aes-256-cbc -k "${SSH_ENCRYPT_PASSWORD}" -in $TRAVIS_PROJECT_DIR/deploy/lucent.pem.enc -out $TRAVIS_PROJECT_DIR/deploy/lucent.pem -d
	chmod 600 $TRAVIS_PROJECT_DIR/deploy/lucent.pem
	ssh-add $TRAVIS_PROJECT_DIR/deploy/lucent.pem
	ssh-keygen -R $DEVELOPMENT_HOST
	ssh-keyscan -H $DEVELOPMENT_HOST >> ~/.ssh/known_hosts
	ssh -v -i $TRAVIS_PROJECT_DIR/deploy/lucent.pem $DEVELOPMENT_SSH_USER@$DEVELOPMENT_HOST DEVELOPMENT_APP_PATH=$DEVELOPMENT_APP_PATH DEVELOPMENT_BRANCH=$DEVELOPMENT_BRANCH 'bash -s' < $TRAVIS_PROJECT_DIR/deploy/deploy-devel.sh
fi