include build/sbc.mk
include build/openwrt.mk

# sbc nodes
$(eval $(call build-sbc-node,openhab,tinkerboard,armbian-beta-bionic))
$(eval $(call build-sbc-node,prometheus,rpi3,ubuntu-bionic-arm64))

# openwrt build container
$(eval $(call openwrt-build-container,18.06.1,ar71xx,generic))
$(eval $(call openwrt-build-container,18.06.1,lantiq,xrx200))
$(eval $(call openwrt-build-container,18.06.1,ramips,mt7620))
# openwrt nodes
$(eval $(call build-node,ap-work,18.06.1,ar71xx,generic,archer-c7-v2))
$(eval $(call build-node,ap-living,18.06.1,ar71xx,generic,archer-c5-v1))
$(eval $(call build-node,ap-bedroom,18.06.1,ar71xx,generic,archer-c5-v1))
$(eval $(call build-node,gateway,18.06.1,lantiq,xrx200,tplink_tdw8970))
$(eval $(call build-node,ffgateway,18.06.1,ramips,mt7620,wrtnode))
