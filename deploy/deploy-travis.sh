if [ ${TRAVIS_PULL_REQUEST} = "false" -a ${TRAVIS_BRANCH} = $DEVELOPMENT_BRANCH ]; then
	openssl aes-256-cbc -k "${SSH_ENCRYPT_PASSWORD}" -in /home/travis/build/favians/Vue/deploy/lucent.pem.enc -out /home/travis/build/favians/Vue/deploy/lucent.pem -d
	chmod 600 /home/travis/build/favians/Vue/deploy/lucent.pem
	ssh-add /home/travis/build/favians/Vue/deploy/lucent.pem
	ssh-keygen -R $DEVELOPMENT_HOST
	ssh-keyscan -H $DEVELOPMENT_HOST >> ~/.ssh/known_hosts
	ssh -v -i lucent.pem $DEVELOPMENT_SSH_USER@$DEVELOPMENT_HOST DEVELOPMENT_APP_PATH=$DEVELOPMENT_APP_PATH DEVELOPMENT_BRANCH=$DEVELOPMENT_BRANCH 'bash -s' < /home/travis/build/favians/Vue/deploy/deploy-devel.sh
fi