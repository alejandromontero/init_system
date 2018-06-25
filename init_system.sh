#/bin/bash

OS_VERSION=$(cat /etc/*-release | grep -e "^NAME" | sed s/NAME=//)

[ $OS_VERSION = "Fedora" ] && INSTALL_CMD="dnf install -y"
[ $OS_VERSION = "Ubuntu" ] && INTALL_CMD="apt install -y"

if [ -s ./packages ]; then
	cmd=("sudo" "$INSTALL_CMD")
	while read -r line; do
		cmd+=("$line")
	done < ./packages
	${cmd[@]}
fi

# Configure Bash
if [ -d ./config/bash ]; then
	cp ./config/bash/bashrc ~/.bashrc
	cp ./config/bash/bash_welcome ~/.bash_welcome
fi

# Configure terminator
[ -d ./config/terminator ] && cp -r ./config/terminator ~/.config

# Configure vim
[ -d ./config/vim ] && cp ./config/vim/vimrc ~/.vimrc
