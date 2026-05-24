include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy2
PKG_VERSION:=2.1.16
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/DNSCrypt/dnscrypt-proxy.git
PKG_SOURCE_VERSION:=2.1.16
PKG_MIRROR_HASH:=skip

PKG_MAINTAINER:=Forced Build
PKG_LICENSE:=ISC

include $(INCLUDE_DIR)/package.mk
include golang-package.mk

define Package/dnscrypt-proxy2
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=DNSCrypt-proxy version 2
  URL:=https://github.com/DNSCrypt/dnscrypt-proxy
  DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/dnscrypt-proxy2/description
  Flexible DNS proxy, with support for encrypted DNS protocols.
endef

define Package/dnscrypt-proxy2/install
	$(call GoPackage/Package/Install/Bin,$(1))
	$(INSTALL_DIR) $(1)/etc/dnscrypt-proxy
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/dnscrypt-proxy/example-dnscrypt-proxy.toml $(1)/etc/dnscrypt-proxy/dnscrypt-proxy.toml
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/dnscrypt-proxy.init $(1)/etc/init.d/dnscrypt-proxy
	$(INSTALL_DATA) ./files/blocked-names.txt $(1)/etc/dnscrypt-proxy/blocked-names.txt
endef

$(eval $(call BuildPackage,dnscrypt-proxy2))
