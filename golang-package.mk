# Minimal golang-package.mk using system Go
# Overrides SDK golang-package.mk to avoid CGO issues with cross-compiler
 
export GOTOOLCHAIN := local
export GOROOT := $(shell go env GOROOT)
export GOPATH := $(BUILD_DIR)/gopath
export GOCACHE := $(BUILD_DIR)/go-cache
export PATH := $(GOROOT)/bin:$(PATH)
 
GO_ARCH_DEPENDS:=@(aarch64||arm||i386||i686||mips||mips64||mipsel||mips64el||x86_64)
 
GO_PKG_BUILD_BIN_DIR := $(PKG_INSTALL_DIR)/usr/bin
 
define Build/Compile
	mkdir -p $(GO_PKG_BUILD_BIN_DIR)
	cd $(PKG_BUILD_DIR)/dnscrypt-proxy && \
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 CC="" CXX="" \
	go build -v -trimpath \
		-tags "$(GO_PKG_TAGS)" \
		-ldflags="-s -w" \
		-o $(GO_PKG_BUILD_BIN_DIR)/dnscrypt-proxy .
endef
 
define GoPackage/Package/Install/Bin
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/* $(1)/usr/bin/ 2>/dev/null || true
endef
