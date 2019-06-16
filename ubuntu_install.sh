#!/bin/sh
#
# This script installs the tools on top of a normal Ubuntu box.
#
# This script should be run via curl:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/wayne-optin/personal/master/ubuntu_install.sh)"
# or wget:
#   sh -c "$(wget -qO- https://raw.githubusercontent.com/wayne-optin/personal/master/ubuntu_install.sh)"
#
setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

install_base_packages() {
    apt-get install -y wget curl vim git zip bzip2 fontconfig python g++ libpng-dev build-essential software-properties-common
}

install_jdk() {
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
    sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
    apt-get install -y adoptopenjdk-11-hotspot
}

install_nodejs() {
    wget https://nodejs.org/dist/v10.16.0/node-v10.16.0-linux-x64.tar.gz -O /tmp/node.tar.gz
    tar -C /usr/local --strip-components 1 -xzf /tmp/node.tar.gz
    npm install -g npm
}

install_jhipster() {
    npm install -g yo generator-jhipster
}

setup_workspace() {
    mkdir /home/wstidolph/workspace
    chown -R wstidolph:wstidolph /home/wstidolph/workspace
}

main() {

	setup_color

	printf "$BLUE"
	cat <<-'EOF'
 _  _  _                            _______              ___ _       
(_)(_)(_)                          (_______)            / __|_)      
 _  _  _ _____ _   _ ____  _____    _       ___  ____ _| |__ _  ____ 
| || || (____ | | | |  _ \| ___ |  | |     / _ \|  _ (_   __) |/ _  |
| || || / ___ | |_| | | | | ____|  | |____| |_| | | | || |  | ( (_| |
 \_____/\_____|\__  |_| |_|_____)   \______)___/|_| |_||_|  |_|\___ |
              (____/                                          (_____|
	EOF
	printf "$RESET"
    
    install_base_packages

    install_jdk

    install_nodejs

    install_jhipster

    setup_workspace

	printf "$BLUE"
	cat <<-'EOF'
    Congratulations, setup is complete!
	EOF
	printf "$RESET"
}

main "$@"