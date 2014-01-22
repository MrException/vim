#!/bin/sh

root=`pwd`

if [ ! -d 'vim-pathogen' ]
then
    echo 'No Pathogen! Filing'
    exit 1
fi

echo 'Updating pathogen'
cd vim-pathogen
git pull
cd $root

cd bundle

for d in `ls`
do
    echo 'Updating ' $d
    cd $d

    if [ -d '.git' ]
    then
        git pull
    fi
    if [ -d '.bzr' ]
    then
        bzr pull
    fi

    cd ..
done

cd $root
