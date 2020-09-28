#!/bin/bash

# Install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

./install.sh
mkdir -p ~/Tools
mkdir -p ~/todo
cd ~/Tools

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


NEOVIM_VERSION="v0.4.3"
# Install neovim
if ! vim --version | grep "NVIM $NEOVIM_VERSION" -q; then
    cd ~/Tools
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        wget https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/nvim.appimage
        chmod u+x nvim.appimage
        sudo mv nvim.appimage ~/bin/.
        sudo update-alternatives --install /usr/bin/vim vim ~/bin/nvim.appimage 200
        curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        wget https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/nvim-macos.tar.gz
        tar -xzf nvim-macos.tar.gz
        rm nvim-macos.tar.gz
        sudo ln -sf $HOME/Tools/nvim-osx64/bin/nvim $HOME/bin/nvim
    fi
else
    echo "NVIM $NEOVIM_VERSION already installed"
fi

# install global nodejs
if ! which node > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sudo apt-get install nodejs
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install node
    fi
else
    echo "nodejs already installed"
fi

# install global yarn
if ! which yarn > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list\n
        sudo apt update
        sudo apt install yarn
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install yarn
    fi
else
    echo "yarn already installed"
fi

# Install fzf
if ! which fzf > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cd ~/Tools
        wget https://github.com/junegunn/fzf/archive/0.18.0.tar.gz
        mkdir -p fzf
        tar -xzf 0.18.0.tar.gz -C fzf
        cd fzf/fzf-0.18.0
        ./install
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install fzf
    fi
else
    echo "fzf already installed"
fi

# Install ripgrep
if ! which rg > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cd ~/Tools
        curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
        sudo dpkg -i ripgrep_11.0.2_amd64.deb
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install rg
    fi
else
    echo "ripgrep already installed"
fi

# Install fd
if ! which fd > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cd ~/Tools
        curl -LO https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb
        sudo dpkg -i fd_7.4.0_amd64.deb
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install fd
    fi
else
    echo "fd already installed"
fi

# Install ranger
if ! which ranger > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cd ~/Tools
        git clone git@github.com:ranger/ranger.git
        cd ranger && sudo make install
    fi
else
    echo "ranger already installed"
fi

if ! which delta > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cd ~/Tools
        mkdir -p delta
        curl -L https://github.com/dandavison/delta/releases/download/0.0.16/delta-0.0.16-x86_64-unknown-linux-musl.tar.gz | tar xzf -
        mv delta*/delta $HOME/bin/delta
    fi
else
    echo "delta alredy installed"
fi

# Install go-jira
if ! which jira > /dev/null; then
    cd ~/Tools
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        curl -LO https://github.com/go-jira/jira/releases/download/v1.0.23/jira-linux-amd64
        sudo ln -sf ~/Tools/jira-linux-amd64 /usr/bin/jira
        sudo chmod +x /usr/bin/jira
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        curl -LO https://github.com/go-jira/jira/releases/download/v1.0.23/jira-darwin-amd64
        sudo ln -sf ~/Tools/jira-darwin-amd64 $HOME/bin/jira
        sudo chmod +x $HOME/bin/jira
    fi
else
    echo "go-jira already installed"
fi

# Install github CLI
GH_VERSION="1.0.0"
if ! which gh > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cd ~/Tools
        curl -LO https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.deb
        sudo dpkg -i gh_${GH_VERSION}_linux_amd64.deb
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install github/gh/gh
    fi
else
    echo "github CLI already installed"
fi

# Install baton (Spotify CLI)
if ! which baton > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cd ~/Tools
        curl -LO https://github.com/joshuathompson/baton/releases/download/0.1.7/baton-0.1.7-linux-amd64
        mv baton-0.1.7-linux-amd64 "$HOME/bin/baton"
        sudo chmod +x "$HOME/bin/baton"
        baton auth
    fi
else
    echo "baton already installed"
fi
