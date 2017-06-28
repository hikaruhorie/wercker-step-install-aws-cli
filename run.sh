#!/bin/bash

if [ ! -n "$WERCKER_INSTALL_AWS_CLI_KEY" ]; then
	error "Input your access key."
	exit 1
fi

if [ ! -n "$WERCKER_INSTALL_AWS_CLI_SECRET" ]; then
	error "Input your secret."
	exit 1
fi

if [ ! -n "$WERCKER_INSTALL_AWS_CLI_REGION" ]; then
	echo "[WARN] No region specified."
	exit 1
fi

echo 'Installing apt packages'
sudo apt-get update
sudo apt-get -y --no-install-recommends install curl python

echo "Installing pip"
curl -kL https://bootstrap.pypa.io/get-pip.py | python
pip install --upgrade

echo "Installing AWS CLI"
pip install awscli awsebcli

echo "Configuring AWS CLI"
aws configure set aws_access_key_id $WERCKER_INSTALL_AWS_CLI_KEY
aws configure set aws_secret_access_key $WERCKER_INSTALL_AWS_CLI_SECRET
if [ -n "$WERCKER_INSTALL_AWS_CLI_REGION" ]; then
	aws configure set default.region $WERCKER_INSTALL_AWS_CLI_REGION
fi

echo "Done."

