#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	sudo apt-get install -y build-essential zsh unzip curl direnv powerline
fi

# Install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

./install.sh
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

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerline10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
    echo "powerlevel10k already installed"
fi

# Install neovim
if ! vim --version | grep "NVIM" -q; then
    cd ~/tools
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt-get update
	sudo apt-get install -y neovim
	sudo update-alternatives --install /usr/bin/vim vim $(which nvim) 200
        curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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

# install global nodejs
if ! which node > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
        fnm install
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install node
    fi
else
    echo "nodejs already installed"
fi

# install global yarn
if ! which yarn > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
	sudo npm install --global yarn
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install yarn
    fi
else
    echo "yarn already installed"
fi

# Install fzf
FZF_VERSION=0.27.2
if ! which fzf > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cd ~/tools
        wget https://github.com/junegunn/fzf/archive/$FZF_VERSION.tar.gz
        mkdir -p fzf
        tar -xzf $FZF_VERSION.tar.gz -C fzf
        cd fzf/fzf-$FZF_VERSION
        ./install
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install fzf
    fi
else
    echo "fzf already installed"
fi

# Install ripgrep
RG_VERSION=13.0.0
if ! which rg > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cd ~/tools
        curl -LO https://github.com/BurntSushi/ripgrep/releases/download/$RG_VERSION/ripgrep_${RG_VERSION}_amd64.deb
        sudo dpkg -i ripgrep_${RG_VERSION}_amd64.deb
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install rg
    fi
else
    echo "ripgrep already installed"
fi

# Install fd
FD_VERSION=8.2.1
if ! which fd > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cd ~/tools
        curl -LO https://github.com/sharkdp/fd/releases/download/v$FD_VERSION/fd_${FD_VERSION}_amd64.deb
        sudo dpkg -i fd_${FD_VERSION}_amd64.deb
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install fd
    fi
else
    echo "fd already installed"
fi

# Install ranger
if ! which ranger > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cd ~/tools
        git clone git@github.com:ranger/ranger.git
        cd ranger && sudo make install
    fi
else
    echo "ranger already installed"
fi

DELTA_VERSION=0.8.3
if ! which delta > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cd ~/tools
        mkdir -p delta
        curl -L https://github.com/dandavison/delta/releases/download/$DELTA_VERSION/delta-$DELTA_VERSION-x86_64-unknown-linux-gnu.tar.gz | tar xzf -
        mv delta*/delta $HOME/bin/delta
    fi
else
    echo "delta alredy installed"
fi

# Install github CLI
GH_VERSION="2.0.0"
if ! which gh > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cd ~/tools
        curl -LO https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.deb
        sudo dpkg -i gh_${GH_VERSION}_linux_amd64.deb
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install github/gh/gh
    fi
else
    echo "github CLI already installed"
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

# drop into a shiny new shell (hopefully)
zsh
