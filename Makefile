include build/sbc.mk
include build/openwrt.mk

# sbc nodes
$(eval $(call build-sbc-node,openhab,rpi3,ubuntu-bionic-arm64))
$(eval $(call build-sbc-node,mqtt,rpi3,ubuntu-cosmic-arm64))

# openwrt build container
$(eval $(call openwrt-build-container,snapshot,ramips,mt7621))
$(eval $(call openwrt-build-container,snapshot,ramips,mt7620))
$(eval $(call openwrt-build-container,snapshot,lantiq,xrx200))
$(eval $(call openwrt-build-container,snapshot,ath79,generic))
$(eval $(call openwrt-build-container,21.02.2,ramips,mt7621))
$(eval $(call openwrt-build-container,21.02.2,ramips,mt7620))
$(eval $(call openwrt-build-container,21.02.2,lantiq,xrx200))
$(eval $(call openwrt-build-container,21.02.2,ath79,generic))
$(eval $(call openwrt-build-container,22.03-SNAPSHOT,ath79,generic))
$(eval $(call openwrt-build-container,22.03-SNAPSHOT,ramips,mt7621))
$(eval $(call openwrt-build-container,22.03.0-rc1,ath79,generic))
$(eval $(call openwrt-build-container,22.03.0-rc1,ramips,mt7621))


# openwrt nodes
$(eval $(call build-node,ap-living,22.03.0-rc1,ramips,mt7621,totolink_x5000r))
$(eval $(call build-node,ap-bedroom,22.03.0-rc1,ramips,mt7621,totolink_x5000r))
$(eval $(call build-node,ap-guest,22.03.0-rc1,ramips,mt7621,totolink_x5000r))
$(eval $(call build-node,ap-max,22.03.0-rc1,ath79,generic,tplink_archer-c7-v2))
$(eval $(call build-node,ap-balcony,22.03.0-rc1,ath79,generic,tplink_archer-c7-v2))

$(eval $(call build-node,router,22.03.0-rc1,ramips,mt7621,ubnt_edgerouter-x))
$(eval $(call build-node,switch,22.03.0-rc1,ramips,mt7621,ubnt_edgerouter-x))
$(eval $(call build-node,otg,21.02.2,ramips,mt7620,ravpower_rp-wd03))
$(eval $(call build-node,lte,21.02.2,ramips,mt7620,wrtnode_wrtnode))

$(eval $(call build-node,dsl-router,snapshot,lantiq,xrx200,avm_fritz7362sl))

target/ubuntu-22.04-prometheus.img: $(wildcard sbc-all/*) $(wildcard sbc-prometheus/*)
	piccu --output $@ \
	      --ubuntu jammy \
	      --plain sbc-all/env --plain sbc-prometheus/env --pass sbc \
	      --boot.firmware.file sbc-prometheus/meta-data \
	      --boot.firmware.file sbc-prometheus/network-config \
	      sbc-all/ \
	      sbc-prometheus/

prometheus: target/ubuntu-22.04-prometheus.img

clean:
	@rm -rf ./target/*
	@rm -rf ./build/tmp/*
