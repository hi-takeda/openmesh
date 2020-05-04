all: installed

VERSION = 6.3
TARBALL = build/OpenMesh-$(VERSION).tar.gz
TARBALL_URL = http://www.openmesh.org/media/Releases/$(VERSION)/OpenMesh-$(VERSION).tar.gz
SOURCE_DIR = build/OpenMesh-$(VERSION)
MD5SUM_FILE = build/OpenMesh-6.3.tar.gz.md5sum
UNPACK_CMD = tar xzf
INSTALL_DIR = $(shell pwd)

include $(shell rospack find mk)/download_unpack_build.mk

installed: $(SOURCE_DIR)/unpacked
	cd $(SOURCE_DIR) && mkdir -p build
	cd $(SOURCE_DIR)/build && cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_APPS=OFF -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR)/
	cd $(SOURCE_DIR)/build && make && make install
	touch installed
clean:
	-rm -rf $(SOURCE_DIR) installed
wipe: clean
	-rm -rf build
