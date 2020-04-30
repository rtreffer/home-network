include build/sbc.mk
include build/openwrt.mk

# sbc nodes
#$(eval $(call build-sbc-node,openhab,tinkerboard,armbian-beta-bionic))
$(eval $(call build-sbc-node,openhab,rpi3,ubuntu-bionic-arm64))
$(eval $(call build-sbc-node,prometheus,rpi3,ubuntu-bionic-arm64))
$(eval $(call build-sbc-node,mqtt,rpi3,ubuntu-cosmic-arm64))

# openwrt build container
$(eval $(call openwrt-build-container,19.07.2,ramips,mt7621))
$(eval $(call openwrt-build-container,snapshot,ramips,mt7621))
$(eval $(call openwrt-build-container,19.07.2,ramips,mt7620))
$(eval $(call openwrt-build-container,19.07.2,lantiq,xrx200))
$(eval $(call openwrt-build-container,snapshot,lantiq,xrx200))
$(eval $(call openwrt-build-container,19.07.2,ath79,generic))
$(eval $(call openwrt-build-container,snapshot,ath79,generic))

# openwrt nodes
$(eval $(call build-node,ap-living,snapshot,ath79,generic,tplink_archer-c5-v1))
$(eval $(call build-node,ap-bedroom,snapshot,ath79,generic,tplink_archer-c5-v1))
$(eval $(call build-node,ap-guest,snapshot,ath79,generic,tplink_archer-c7-v5))
$(eval $(call build-node,ap-balcony,snapshot,ath79,generic,tplink_archer-c7-v2))
$(eval $(call build-node,dsl,19.07.2,lantiq,xrx200,tplink_vr200v))
$(eval $(call build-node,router,19.07.2,ramips,mt7621,ubnt-erx))
$(eval $(call build-node,dsl-router,snapshot,lantiq,xrx200,avm_fritz7362sl))
# TODO: snapshot switched from swconfig to linux DSA
# $(eval $(call build-node,router,snapshot,ramips,mt7621,ubnt_edgerouter-x))

clean:
	@rm -rf ./target/*
	@rm -rf ./build/tmp/*
