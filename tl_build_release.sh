#! sh

# Script to build binary release artifacts for Tim Littlefair's
# github fork of the orphan tinyb library originally owned by 
# intel-iot-core

osname=$(uname --kernel-name)
archname=$(uname --machine)
if [ "$osname" != "Linux" ]
then
    echo This script presently only supports Linux
    exit 1
else
    so_arch_libdir="linux-$archname"
fi

rm -rf build
mkdir build
cd build
cmake -DBUILDJAVA=ON ..
make all

cp ./java/tinyb.jar ../precompiled-release-artifacts/tinyb-0.5.1.tl250617.jar
cp ./src/libtinyb.so ../precompiled-release-artifacts/linux-x86_64
cp ./java/jni/libjavatinyb.so ../precompiled-release-artifacts/linux-x86_64

git diff --name-only ../precompiled-release-artifacts > changed_PRAs.txt
ls -l changed_PRAs.txt
echo The following precompiled artifacts have changed: { $(cat changed_PRAs.txt) }




