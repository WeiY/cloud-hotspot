#!/bin/bash
# This script file is used in build cloud hotspot openwrt, weiy <wei.a.yang@gmail.com>
# $1: full_system  mini_system ar71xx_generic 

OPENWRT_DIR_NAME="openwrt."$1
OPENWRT_DIR="${PWD}/${OPENWRT_DIR_NAME}"
CONFIG_FILE_TYPE="config."$1

###############################################################################
if [ ! -d ${OPENWRT_DIR} ]; then
	git clone git://git.openwrt.org/12.09/openwrt.git ${OPENWRT_DIR}
fi

#echo "make distclean"
#make distclean

# copy over the build config settings and the files directory
cp ${OPENWRT_DIR}/../configs/${CONFIG_FILE_TYPE} ${OPENWRT_DIR}/.config
#cp -r ${OPENWRT_DIR}/../files ${OPENWRT_DIR}

# add the specific cloud hotspot packages as a feed
echo "src-svn packages svn://svn.openwrt.org/openwrt/branches/packages_12.09" > ${OPENWRT_DIR}/feeds.conf.default
echo "src-svn luci http://svn.luci.subsignal.org/luci/branches/luci-0.11/contrib/package" >> ${OPENWRT_DIR}/feeds.conf.default
echo "src-git routing git://github.com/openwrt-routing/packages.git;for-12.09.x" >> ${OPENWRT_DIR}/feeds.conf.default
echo "src-link cloud_hotspot ${OPENWRT_DIR}/../cloud_hotspot_feed" >> ${OPENWRT_DIR}/feeds.conf.default
${OPENWRT_DIR}/scripts/feeds update
cd ${OPENWRT_DIR} && ../config_install_feeds.pl
${OPENWRT_DIR}/scripts/feeds install -a -p cloud_hotspot

# add patches to some components

# and then build the cloud hotspot firmware...
echo
echo " ================================================= "
echo " To compile this custom openwrt build for cloud hotspot, "
echo " just type make V=99 in the path ${OPENWRT_DIR} "
echo " . If you wish to add or change packages type:"
echo " cd openwrt"
echo " make menuconfig #If you wish to add or change packages."
echo " make V=99"
echo  
echo 
echo " Happy hacking! "
echo " ================================================= "
echo 
