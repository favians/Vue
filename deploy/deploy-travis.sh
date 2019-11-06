if [ ${TRAVIS_PULL_REQUEST} = "true" -a ${TRAVIS_BRANCH} = $DEVELOPMENT_BRANCH ]; then
	openssl aes-256-cbc -k "${SSH_ENCRYPT_PASSWORD}" -in ./lucent.pem.enc -out ./lucent.pem -d
	chmod 600 ./lucent.pem
	ssh-add ./lucent.pem
	ssh-keygen -R $DEVELOPMENT_HOST
	ssh-keyscan -H $DEVELOPMENT_HOST >> ~/.ssh/known_hosts
	ssh -v -i lucent.pem $DEVELOPMENT_SSH_USER@$DEVELOPMENT_HOST DEVELOPMENT_APP_PATH=$DEVELOPMENT_APP_PATH DEVELOPMENT_BRANCH=$DEVELOPMENT_BRANCH 'bash -s' < ./deploy-devel.sh