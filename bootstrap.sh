#!/usr/bin/env bash
apt-get update --yes
apt-get install curl git tmux vim --yes

# Install rvm and setup
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
source  /etc/profile.d/rvm.sh

# Installl the latest ruby
rvm install ruby --latest


# Install linuxbrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
echo 'export PATH="$HOME/.linuxbrew/bin:$PATH"' >>~/.bash_profile
brew install neovim/neovim/neovim

# Install tmux  2.2 and configure
install_tmux() {
    tmux_version=$(tmux -V)
    if [[ "$tmux_version" -eq "2.2"]]
    then
      return
    fi

    # Install the dependencies.
    apt-get install -f --yes
    apt-get install libevent-dev --yes
    apt-get install ncurses-dev --yes

    Download and install tmux
    cd ~
    wget https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz
    tar -zxf tmux-2.2.tar.gz
    cd tmux-2.2
    ./configure && make

    # Replace old tmux with the new one
    cp tmux-2.2/tmux /usr/bin/tmux
}

