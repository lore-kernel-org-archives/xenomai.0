From: Dario Binacchi <dariobin@libero.it>
Subject: [PATCH v5 0/8] drivers/can: add support for Bosch C_CAN controller
Date: Sun, 19 Dec 2021 10:38:00 +0100
Message-Id: <20211219093809.21765-1-dariobin@libero.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Michael Trimarchi <michael@amarulasolutions.com>, Jan Kiszka <jan.kiszka@siemens.com>, Dario Binacchi <dariobin@libero.it>, Philippe Gerum <rpm@xenomai.org>, Gianluca Falavigna <gianluca.falavigna@inwind.it>, "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>

The series was created to optimize the use of the C_CAN controller
(maximum number of message objects, use of FIFO, ...) to get the
best possible RX/TX throughput from hardware.

To emphasize the purpose of the series I also added the patch
which adds multi-message support to `sendmsg ', rather than'
submitting it separately. In fact, it too has contributed to
increasing transmission throughput.

The patches prior to the one adding the BOSCH C_CAN controller driver,
are a backporting of commits from the linux kernel that also impacted
on the driver itself and I found it necessary to add to the series.

The latest patch, as described in its commit, modified Stephen
Battazzo's patch [1] with bug fixes, backporting of commits from the
linux kernel, extension of message objects to 64 and improvements in
FIFO handling. This series was in fact preceded by the creation of
patches which I sent to the Linux kernel and which were then accepted:

387da6bc7a82 ("can: c_can: cache frames to operate as a true FIFO")
28e86e9ab522 ("can: c_can: support tx ring algorithm")
a54cdbba9dee ("can: c_can: exit c_can_do_tx() early if no frames have been sent")
5064e40596f4 ("can: c_can: remove struct c_can_priv::priv field")
06fc143b2ede dt-bindings: net: can: c_can: convert to json-schema
132f2d45fb23 ("can: c_can: add support to 64 message objects")
13831ce69c77 ("can: c_can: prepare to up the message objects number")
fcbded019855 ("can: c_can: use 32-bit write to set arbitration register")
eddf67115040 ("can: c_can: add a comment about IF_RX interface's use")
c8a6b44388cb ("can: c_can: fix indentation")
f65735c203d5 ("can: c_can: remove unused code")

The patch was tested on a custom board mounting an AM335x SOC for the
next configurations:
- CONFIG_XENO_DRIVERS_CAN=m, CONFIG_XENO_DRIVERS_CAN_VIRT=m
- CONFIG_XENO_DRIVERS_CAN=y, CONFIG_XENO_DRIVERS_CAN_VIRT=m
- CONFIG_XENO_DRIVERS_CAN=y, CONFIG_XENO_DRIVERS_CAN_VIRT=y

PCI support has not been developed.

[1] http://xenomai.org/pipermail/xenomai/2015-July/034690.html

Changes in v5:
- Add the `drivers/can: add corectl to retrieve configuration' patch to
  the series.
- smokey_modprobe(): check the `name' parameter.
- smokey_modprobe(): return `err' instead of 0 in case of no error.
- smokey_rmmod(): set smokey_modules[midx] to NULL after freeing the
  pointed string.
- Check _CC_COBALT_GET_CAN_CONFIG through cobalt_corectl call.
- Don't check modprobe return code. In case the modules are builtin the
  test would be improperly terminated with an error, since the modprobe
  does not check if a module is builtin.

Changes in v4:
- Add the patch to the series.
- Load/unload the CAN drivers modules before/after running the test.
- Add setup/teardown function.

Changes in v3:
- Add the patch to the series.

Changes in v2:
- Expand the commit message to better describe the added API.
- Drop 'default n' Kconfig
- Enable the driver for Xenomai CI builds
- Drop commented code
- Drop power managemet (pm) code

Dario Binacchi (8):
  drivers/can: add corectl to retrieve configuration
  lib/smokey: add smokey_{modprobe,rmmod} helpers
  testsuite/smokey: add virtual CAN testsuite
  drivers/can: add multi message support to sendmsg
  drivers/can: add CAN_ERR_CRTL_ACTIVE info status
  drivers/can: add len field to can frame structures
  drivers/can: add a minimal support to ethtool API
  drivers/can: add support for Bosch C_CAN controller

 .gitlab-ci.yml                                |    2 +
 configure.ac                                  |    1 +
 include/cobalt/uapi/corectl.h                 |    2 +
 include/rtdm/uapi/can.h                       |    6 +-
 include/smokey/smokey.h                       |    6 +-
 kernel/drivers/can/Kconfig                    |    1 +
 kernel/drivers/can/Makefile                   |    6 +-
 kernel/drivers/can/README                     |    1 +
 kernel/drivers/can/c_can/Kconfig              |   15 +
 kernel/drivers/can/c_can/Makefile             |    8 +
 kernel/drivers/can/c_can/rtcan_c_can.c        | 1298 +++++++++++++++++
 kernel/drivers/can/c_can/rtcan_c_can.h        |  255 ++++
 .../drivers/can/c_can/rtcan_c_can_ethtool.c   |   47 +
 .../drivers/can/c_can/rtcan_c_can_platform.c  |  461 ++++++
 kernel/drivers/can/corectl.c                  |   41 +
 kernel/drivers/can/rtcan_dev.h                |    4 +-
 kernel/drivers/can/rtcan_ethtool.c            |   75 +
 kernel/drivers/can/rtcan_ethtool.h            |   24 +
 kernel/drivers/can/rtcan_module.c             |    6 +
 kernel/drivers/can/rtcan_raw.c                |  239 +--
 kernel/drivers/can/rtcan_raw_dev.c            |   20 +
 kernel/drivers/can/rtcan_socket.h             |    5 +-
 lib/smokey/helpers.c                          |  103 ++
 testsuite/smokey/Makefile.am                  |    2 +
 testsuite/smokey/can-virt/Makefile.am         |    8 +
 testsuite/smokey/can-virt/virt.c              |  370 +++++
 testsuite/smokey/net_common/setup.c           |   68 +-
 27 files changed, 2890 insertions(+), 184 deletions(-)
 create mode 100644 kernel/drivers/can/c_can/Kconfig
 create mode 100644 kernel/drivers/can/c_can/Makefile
 create mode 100644 kernel/drivers/can/c_can/rtcan_c_can.c
 create mode 100644 kernel/drivers/can/c_can/rtcan_c_can.h
 create mode 100644 kernel/drivers/can/c_can/rtcan_c_can_ethtool.c
 create mode 100644 kernel/drivers/can/c_can/rtcan_c_can_platform.c
 create mode 100644 kernel/drivers/can/corectl.c
 create mode 100644 kernel/drivers/can/rtcan_ethtool.c
 create mode 100644 kernel/drivers/can/rtcan_ethtool.h
 create mode 100644 testsuite/smokey/can-virt/Makefile.am
 create mode 100644 testsuite/smokey/can-virt/virt.c

-- 
2.17.1


