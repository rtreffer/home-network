include build/sbc.mk
include build/openwrt.mk

# sbc nodes
#$(eval $(call build-sbc-node,openhab,tinkerboard,armbian-beta-bionic))
$(eval $(call build-sbc-node,openhab,rpi3,ubuntu-bionic-arm64))
$(eval $(call build-sbc-node,prometheus,rpi3,ubuntu-bionic-arm64))
$(eval $(call build-sbc-node,mqtt,rpi3,ubuntu-cosmic-arm64))

# openwrt build container
$(eval $(call openwrt-build-container,18.06.2,ar71xx,generic))
$(eval $(call openwrt-build-container,18.06.2,lantiq,xrx200))
$(eval $(call openwrt-build-container,18.06.2,ramips,mt7620))
$(eval $(call openwrt-build-container,18.06.2,ramips,mt7621))
$(eval $(call openwrt-build-container,snapshot,ar71xx,generic))
$(eval $(call openwrt-build-container,snapshot,ramips,mt7621))
$(eval $(call openwrt-build-container,snapshot,lantiq,xrx200))

# openwrt nodes
$(eval $(call build-node,ap-work,18.06.2,ar71xx,generic,archer-c7-v2))
$(eval $(call build-node,ap-living,snapshot,ar71xx,generic,archer-c5-v1))
$(eval $(call build-node,ap-bedroom,snapshot,ar71xx,generic,archer-c5-v1))
$(eval $(call build-node,ap-guest,snapshot,ar71xx,generic,archer-c7-v5))
$(eval $(call build-node,ap-balcony,snapshot,ar71xx,generic,archer-c7-v2))
$(eval $(call build-node,dsl,snapshot,lantiq,xrx200,tplink_vr200v))
$(eval $(call build-node,ffgateway,18.06.2,ramips,mt7620,wrtnode))
$(eval $(call build-node,router,snapshot,ramips,mt7621,ubnt-erx))

clean:
	@rm -rf ./target/*
	@rm -rf ./build/tmp/*
