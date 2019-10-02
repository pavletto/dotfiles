#!/usr/bin/bash

sudo pacman -Suy
sudo pacman -S awesome zsh git vim compton yaourt nodejs tmux xclip rxvt-unicode

yay -S --noconfirm   rofi \ 
    ranger ttf-font-awesome-4 w3m \
    imgur-screenshot-git \
    rcm sublime-text-dev ffcast ttf-dejavu-sans-mono-powerline


sudo npm i eslint

# git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
# curl -o $HOME/.oh-my-zsh/themes/hyperzsh.zsh-theme    https://raw.githubusercontent.com/tylerreckart/hyperzsh/master/hyperzsh.zsh-theme
git clone https://github.com/pkkolos/urxvt-scripts.git $HOME/.urxvt/ext
git clone https://github.com/tmux-plugins/tpm.git $HOME/.tmux/plugins/tpm
git clone https://github.com/creationix/nvm.git $HOME/.nvm
git clone https://github.com/sos4nt/dynamic-colors.git $HOME/.dynamic-colors
git clone https://github.com/granin/Telegram-Solarized.git $HOME/.config/telegram
curl -o $HOME/.oh-my-zsh/themes/hyperzsh.zsh-theme  https://raw.githubusercontent.com/tylerreckart/hyperzsh/master/hyperzsh.zsh-theme

git clone --recursive https://github.com/pavletto/dotfiles.git $HOME/.dotfiles

rcup -v 
chsh -s $(which zsh) $USER

echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

