#!/bin/bash


sudo apt-get update

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	sudo apt-get install -y build-essential \
      fzf \
      fd-find \
      ripgrep \
      zsh \
      unzip \
      curl \
      direnv \
      powerline \
      clang-format \
      tmux
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

./_install.sh
mkdir -p ~/tools
mkdir -p ~/todo

sudo chown -R sarah:sarah ~/
cd ~/tools

# Install zsh plugins
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions already installed"
fi
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search ]; then
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
else
    echo "zsh-history-substring-search already installed"
fi
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo "zsh-syntax-highlighting already installed"
fi
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/forgit ]; then
    git clone https://github.com/wfxr/forgit.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/forgit
else
    echo "forgit already installed"
fi

if [ ! -d $HOME/.zsh/pure ]; then
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
else
    echo "pure already installed"
fi

# Install neovim
if ! vim --version | grep "NVIM" -q; then
    cd ~/tools
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt-get update
	sudo apt-get install -y neovim
	sudo update-alternatives --install /usr/bin/vim vim $(which nvim) 200
    elif [[ "$OSTYPE" == "darwin"* ]]; then
	NEOVIM_VERSION="0.6.0"
        wget https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/nvim-macos.tar.gz
        tar -xzf nvim-macos.tar.gz
        rm nvim-macos.tar.gz
        sudo ln -sf $HOME/tools/nvim-osx64/bin/nvim $HOME/bin/nvim
    fi
else
    echo "NVIM $NEOVIM_VERSION already installed"
fi

# Install baton (Spotify CLI)
BATON_VERSION="0.1.7"
if ! which baton > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cd ~/tools
        curl -LO https://github.com/joshuathompson/baton/releases/download/$BATON_VERSION/baton-${BATON_VERSION}-linux-amd64
        mv baton-${BATON_VERSION}-linux-amd64 "$HOME/bin/baton"
        sudo chmod +x "$HOME/bin/baton"
        ~/bin/baton auth
    fi
else
    echo "baton already installed"
fi
