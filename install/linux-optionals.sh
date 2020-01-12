#!/bin/bash


### go ###

# install go
[ -d $HOME/bin ] || mkdir $HOME/bin
curl -sL -o ~/bin/gimme https://raw.githubusercontent.com/travis-ci/gimme/master/gimme
chmod +x ~/bin/gimme
eval "$(gimme stable)"

# sometimes required for go dependencies
sudo dnf install -y mercurial

### bazel ###

# install bazelisk instead of single bazel version
go get github.com/bazelbuild/bazelisk

# link bazelisk instead of bazel
sudo ln -s $HOME/go/bin/bazelisk /usr/bin/bazel


### install pyenv ###

# install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# requirements for building python versions
sudo dnf install -y zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel \
                    openssl-devel xz xz-devel libffi-devel findutils

# set python version default for system
pyenv global 2.7.17
