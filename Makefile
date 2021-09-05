include build/sbc.mk
include build/openwrt.mk

# sbc nodes
#$(eval $(call build-sbc-node,openhab,tinkerboard,armbian-beta-bionic))
$(eval $(call build-sbc-node,openhab,rpi3,ubuntu-bionic-arm64))
$(eval $(call build-sbc-node,prometheus,rpi3,ubuntu-focal-arm64))
$(eval $(call build-sbc-node,mqtt,rpi3,ubuntu-cosmic-arm64))

# openwrt build container
$(eval $(call openwrt-build-container,snapshot,ramips,mt7621))
$(eval $(call openwrt-build-container,snapshot,ramips,mt7620))
$(eval $(call openwrt-build-container,snapshot,lantiq,xrx200))
$(eval $(call openwrt-build-container,snapshot,ath79,generic))
$(eval $(call openwrt-build-container,21.02.0,ramips,mt7621))
$(eval $(call openwrt-build-container,21.02.0,ramips,mt7620))
$(eval $(call openwrt-build-container,21.02.0,lantiq,xrx200))
$(eval $(call openwrt-build-container,21.02.0,ath79,generic))


# openwrt nodes
$(eval $(call build-node,ap-living,21.02-SNAPSHOT,ath79,generic,tplink_archer-c5-v1))
$(eval $(call build-node,ap-bedroom,21.02-SNAPSHOT,ath79,generic,tplink_archer-c5-v1))
$(eval $(call build-node,ap-guest,21.02-SNAPSHOT,ath79,generic,tplink_archer-c7-v5))
$(eval $(call build-node,ap-max,21.02-SNAPSHOT,ath79,generic,tplink_archer-c7-v2))
$(eval $(call build-node,ap-balcony,21.02-SNAPSHOT,ath79,generic,tplink_archer-c7-v2))

$(eval $(call build-node,router,21.02.0,ramips,mt7621,ubnt_edgerouter-x))
$(eval $(call build-node,switch,21.02.0,ramips,mt7621,ubnt_edgerouter-x))

$(eval $(call build-node,dsl-router,snapshot,lantiq,xrx200,avm_fritz7362sl))
$(eval $(call build-node,lte,snapshot,ramips,mt7620,wrtnode_wrtnode))

clean:
	@rm -rf ./target/*
	@rm -rf ./build/tmp/*
