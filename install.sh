#! /bin/bash
#
#  install.sh
#

install='install.sh'

echo "Executing all install.sh in each folder"

# Looping all folder here
for i in $(ls -d */)
do
    if [ -f "$i$install" ]; then
        cd $i
        bash $install
        cd ..
    fi
done
