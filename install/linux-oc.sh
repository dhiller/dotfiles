#!/bin/bash

echo "fetching oc"
export oc_filename='oc.tar.gz'
export oc_dirname="${oc_filename%.tar.gz}"
export oc_download_url_base='https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux'
(
    mkdir ${oc_dirname}
    cd ${oc_dirname}
    curl -L -O -o ${oc_filename} ${oc_download_url_base}/${oc_filename}
    tar zxvf ${oc_filename}
    sudo install oc /usr/local/bin/oc
) || ( echo "failed to download ${oc_filename}"; exit 1 )
