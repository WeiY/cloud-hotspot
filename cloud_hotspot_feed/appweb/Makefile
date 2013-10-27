#
# Copyright (C) 2009-2010 OpenWrt.org
# Copyright (C) 2009 Embedthis Software
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# Commercial and other licenses are available from http://www.embedthis.com/.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=appweb
PKG_RELEASE:=1

#
#	Build stable
#
PKG_VERSION:=4.4.1-0
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-src.tgz
PKG_SOURCE_URL:=http://appwebserver.org/software/
PKG_MD5SUM:=818c4369c1ac41b31ab0f6f130dc3bb6

include $(INCLUDE_DIR)/package.mk

# The files in the .tar.gz are
#    src/all/...
#    src/build/...
#    src/test/...
# and so on
#
# What we want is
#    $(PKG_BUILD_DIR)/all/...
#    $(PKG_BUILD_DIR)/build/...
#    $(PKG_BUILD_DIR)/test/...
# and so on
#
# The following two lines make this happen
#    1.  change tar option to strip out the top-level, src in
#        this case
#    2.  change the tar output to the build directory.  The
#        original tar command was
#        $(HOST_TAR) -C/.. $(1) $(TAR_OPTIONS)

TAR_OPTIONS:=--strip-components 1 $(TAR_OPTIONS)
TAR_CMD=$(HOST_TAR) -C $(1) $(TAR_OPTIONS)

define Package/appweb
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=Appweb Web Server
  URL:=http://www.appwebserver.org/
  DEPENDS:=@!avr32 +libpthread +librt
endef

define Package/appweb/description
 Appweb is a powerful, compact embedded web server designed for dynamic web
 applications.
endef

CONFIGURE_ARGS = \
	PROFILE=release \
	BIT_EJS_DB=1 \
	BIT_EJS_MAIL=1 \
	BIT_EJS_MAPPER=1 \
	BIT_EJS_TAR=1 \
	BIT_EJS_TEMPLATE=1 \
	BIT_EJS_WEB=1 \
	BIT_EJS_ZLIB=1 \
	BIT_ESP_MDB=1 \
	BIT_ESP_SDB=1 \
	BIT_MPR_LOGGING=1 \
	BIT_MPR_TRACING=1 \
	BIT_PACK_CGI=1 \
	BIT_PACK_DIR=1 \
	BIT_PACK_EJSCRIPT=1 \
	BIT_PACK_ESP=1 \
	BIT_PACK_EST=1 \
	BIT_PACK_NANOSSL=0 \
	BIT_PACK_MATRIXSSL=0 \
	BIT_PACK_OPENSSL=0 \
	BIT_PACK_PHP=0 \
	BIT_PACK_SQLITE=1

define Build/Compile
	cd $(PKG_BUILD_DIR); $(MAKE) ARCH=mips \
		$(TARGET_CONFIGURE_OPTS) \
		$(CONFIGURE_ARGS) \
		-f projects/appweb-linux-openwrt.mk
endef

define Package/appweb/install
	cd $(PKG_BUILD_DIR) ; $(MAKE) PROFILE=release \
		$(TARGET_CONFIGURE_OPTS) \
		ARCH=mips BIT_ROOT_PREFIX=$(1) \
		$(CONFIGURE_ARGS) \
		-f projects/appweb-linux-openwrt.mk \
		installBinary;
	cp $(PKG_BUILD_DIR)/package/linux/openwrt.bin/* $(PKG_BUILD_DIR)/ipkg-ar71xx/appweb/CONTROL/
	symlinks -c $(PKG_BUILD_DIR)/ipkg-ar71xx/appweb/usr/local/bin/
	cd $(PKG_BUILD_DIR)/samples; esp generate app blog angular-mvc; cd blog; $(TARGET_CONFIGURE_OPTS) esp compile;
endef

$(eval $(call BuildPackage,appweb))
