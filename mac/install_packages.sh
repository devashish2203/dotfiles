#!/bin/bash

#install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew install bash-completion
#install python
#brew install python

#install byobu
brew install byobu

#install powerline-shell
pip3 install --user powerline-shell

#install powerline fonts
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts


mkdir -p ~/tools
#Download git completion
curl https://github.com/git/git/blob/master/contrib/completion/git-completion.bash -o ~/tools/git-completion.bash


