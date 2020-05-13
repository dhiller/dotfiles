#!/bin/bash


### go ###

# install go
[ -d $HOME/bin ] || mkdir $HOME/bin
curl -sL -o ~/bin/gimme https://raw.githubusercontent.com/travis-ci/gimme/master/gimme
chmod +x ~/bin/gimme
eval "$(gimme stable)"

# sometimes required for go dependencies
sudo dnf install -y mercurial

# ginkgo and gomega for testing
go get -u github.com/onsi/ginkgo/ginkgo
go get -u github.com/onsi/gomega/...

### bazel ###

# install bazelisk instead of single bazel version
go get github.com/bazelbuild/bazelisk

# link bazelisk instead of bazel
sudo ln -s $HOME/go/bin/bazelisk /usr/bin/bazel


### ansible ###

sudo dnf install -y ansible


### install pyenv ###

# install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# requirements for building python versions
sudo dnf install -y zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel \
                    openssl-devel xz xz-devel libffi-devel findutils

# set python version default for system
pyenv global 2.7.17

# install gcloud tools

sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM

sudo dnf install -y google-cloud-sdk
