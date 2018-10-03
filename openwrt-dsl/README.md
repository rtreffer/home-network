DSL modem
---------

A VDSL2 modem in bridge mode.
All ethernet ports are bridged with the modems ethernet layer.

The device performs:
- VDSL2 modem negotation
- ATM / lower level VDSL2 protocols
- Bridging of all ehternet ports to the VDSL2 modem
- Monitoring (prometheus)

Another device must perform
- PPPoE
- VLAN Tagging
