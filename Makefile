include build/sbc.mk
include build/openwrt.mk

# sbc nodes
$(eval $(call build-sbc-node,openhab,rpi3,ubuntu-bionic-arm64))
$(eval $(call build-sbc-node,mqtt,rpi3,ubuntu-cosmic-arm64))

# openwrt build container
#$(eval $(call openwrt-build-container,snapshot,ramips,mt7621))
#$(eval $(call openwrt-build-container,snapshot,ramips,mt7620))
#$(eval $(call openwrt-build-container,snapshot,lantiq,xrx200))
#$(eval $(call openwrt-build-container,22.03.3,ramips,mt7621))
$(eval $(call openwrt-build-container,23.05.2,ath79,generic))
$(eval $(call openwrt-build-container,23.05.2,ramips,mt7621))
$(eval $(call openwrt-build-container,23.05.2,bcm27xx,bcm2708))
$(eval $(call openwrt-build-container,23.05.2,bcm27xx,bcm2710))
$(eval $(call openwrt-build-container,23.05.2,realtek,rtl838x))

# openwrt nodes
$(eval $(call build-node,ap-living,23.05.2,ramips,mt7621,totolink_x5000r))
$(eval $(call build-node,ap-bedroom,23.05.2,ramips,mt7621,totolink_x5000r))
$(eval $(call build-node,ap-guest,23.05.2,ramips,mt7621,totolink_x5000r))
$(eval $(call build-node,ap-max,23.05.2,ramips,mt7621,totolink_x5000r))
$(eval $(call build-node,ap-balcony,23.05.2,ath79,generic,tplink_archer-c7-v2))

$(eval $(call build-node,router,23.05.2,ramips,mt7621,ubnt_edgerouter-x))
$(eval $(call build-node,switch,23.05.2,ramips,mt7621,ubnt_edgerouter-x))
$(eval $(call build-node,otg,21.02.3,ramips,mt7620,ravpower_rp-wd03))
$(eval $(call build-node,lte,21.02.3,ramips,mt7620,wrtnode_wrtnode))
$(eval $(call build-node,rpi-fallback,23.05.0,bcm27xx,bcm2710,rpi-3))

$(eval $(call build-node,dsl-router,snapshot,lantiq,xrx200,avm_fritz7362sl))

$(eval $(call build-node,core-switch,23.05.2,realtek,rtl838x,d-link_dgs-1210-28))

target/ubuntu-22.04-prometheus.img: $(wildcard sbc-all/*) $(wildcard sbc-prometheus/*)
	piccu --output $@ \
	      --ubuntu jammy \
	      --plain sbc-all/env --plain sbc-prometheus/env --pass sbc \
	      --boot.firmware.file sbc-prometheus/meta-data \
	      --boot.firmware.file sbc-prometheus/network-config \
	      sbc-all/ \
	      sbc-prometheus/

prometheus: target/ubuntu-22.04-prometheus.img

target/ubuntu-22.04-epaper.img: $(wildcard sbc-all/*) $(wildcard sbc-prometheus/*)
	piccu --output $@ \
		--ubuntu jammy \
		--plain sbc-all/env --plain sbc-prometheus/env \
		--boot.firmware.file sbc-epaper/meta-data \
		--boot.firmware.file sbc-epaper/network-config \
		sbc-all/ \
		sbc-epaper/

epaper: target/ubuntu-22.04-epaper.img

clean:
	@rm -rf ./target/*
	@rm -rf ./build/tmp/*
