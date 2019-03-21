From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 00/16] multicast, VLAN support for RTnet
Date: Thu, 21 Mar 2019 18:13:14 +0100
Message-Id: <20190321171330.2073-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Some time ago, Gilles Chanteperdrix added multicast and VLAN support
to the original RTnet code base (0.9.13). iXblue, the company who owns
such work, has released this code, with permission to contribute it to
the Xenomai project. Many thanks to Stéphane Belot at iXblue for
making it possible.

Apart from marginal changes to cope with a few API differences between
the original RTnet implementation and Xenomai's, the content of this
series is almost entirely Gilles's work.

=====================================================================
NOTE: this code applies on top of the reformating patch sent earlier.
=====================================================================

Gilles Chanteperdrix (16):
  net/stack: plan for merging private device flags with
    netdev_priv_flags
  net/stack: add multicast support
  utils/net: rtifconfig: display device name untruncated
  net/stack: add support for VLAN filtering
  utils/net: add VLAN filter configuration tool
  net/udp: allow retrieving irq timestamp with SIOCGSTAMP ioctl
  net/udp sendmsg: do not return an error if dest addr is null
  net/stack: rtskb: increase buffer size
  net/stack: manager: ratelimit printk when dropping buffers
  net/ipv4: icmp: forward unused packets to proxy
  net/drivers: e1000e: enable multicast
  net/drivers: e1000e: enable VLAN filtering
  net/drivers: e1000e: add netdevice stats
  net/drivers: igb: enable multicast
  net/drivers: igb: enable VLAN filtering
  demo/net: add rtnet tests

 configure.ac                                  |   1 +
 demo/Makefile.am                              |   2 +-
 demo/net/Makefile.am                          |  78 ++
 demo/net/mcast-receiver.c                     | 204 +++++
 demo/net/mcast-sender.c                       | 151 ++++
 demo/net/raw-ethernet.c                       | 100 +++
 demo/net/rtt-mcast-measure.c                  | 210 +++++
 demo/net/rtt-mcast-responder.c                | 109 +++
 demo/net/rtt-responder.c                      | 193 +++++
 demo/net/rtt-sender.c                         | 341 ++++++++
 demo/net/rttcp-client.c                       | 212 +++++
 demo/net/rttcp-server.c                       | 181 +++++
 demo/net/udp-send.c                           | 136 ++++
 kernel/drivers/net/addons/cap.c               |  47 +-
 kernel/drivers/net/drivers/e1000e/e1000.h     |   6 +-
 kernel/drivers/net/drivers/e1000e/hw.h        |   2 +-
 kernel/drivers/net/drivers/e1000e/lib.c       |   7 +-
 kernel/drivers/net/drivers/e1000e/netdev.c    | 270 ++++++-
 kernel/drivers/net/drivers/igb/e1000_mac.c    |   6 +-
 kernel/drivers/net/drivers/igb/e1000_mac.h    |   2 +-
 kernel/drivers/net/drivers/igb/igb_main.c     |  53 +-
 kernel/drivers/net/stack/Kconfig              |   7 +
 kernel/drivers/net/stack/Makefile             |   2 +
 kernel/drivers/net/stack/include/ipv4/arp.h   |   3 +
 kernel/drivers/net/stack/include/ipv4/igmp.h  | 102 +++
 .../drivers/net/stack/include/ipv4/protocol.h |   1 +
 kernel/drivers/net/stack/include/rtdev.h      |  45 +-
 kernel/drivers/net/stack/include/rtif_vlan.h  | 105 +++
 kernel/drivers/net/stack/include/rtnet_port.h |   6 +-
 .../drivers/net/stack/include/rtnet_socket.h  |   6 +
 kernel/drivers/net/stack/include/rtskb.h      |   4 +-
 kernel/drivers/net/stack/include/rtvlan.h     |  25 +
 kernel/drivers/net/stack/ipv4/Kconfig         |   7 +
 kernel/drivers/net/stack/ipv4/Makefile        |   1 +
 kernel/drivers/net/stack/ipv4/af_inet.c       |   5 +
 kernel/drivers/net/stack/ipv4/arp.c           |  26 +
 kernel/drivers/net/stack/ipv4/icmp.c          |  18 +-
 kernel/drivers/net/stack/ipv4/igmp.c          | 616 +++++++++++++++
 kernel/drivers/net/stack/ipv4/ip_output.c     |  13 +-
 kernel/drivers/net/stack/ipv4/ip_sock.c       |  51 +-
 kernel/drivers/net/stack/ipv4/protocol.c      |  17 +
 kernel/drivers/net/stack/ipv4/tcp/tcp.c       |   2 +-
 kernel/drivers/net/stack/ipv4/udp/udp.c       |  55 +-
 kernel/drivers/net/stack/rtdev.c              | 214 ++++++
 kernel/drivers/net/stack/rtnet_chrdev.c       |   7 +-
 kernel/drivers/net/stack/rtnet_module.c       |   5 +
 kernel/drivers/net/stack/socket.c             |  16 +-
 kernel/drivers/net/stack/stack_mgr.c          |   2 +-
 kernel/drivers/net/stack/vlan.c               | 725 ++++++++++++++++++
 utils/net/Makefile.am                         |   1 +
 utils/net/rtifconfig.c                        |   2 +-
 utils/net/rtvconfig.c                         | 257 +++++++
 52 files changed, 4551 insertions(+), 106 deletions(-)
 create mode 100644 demo/net/Makefile.am
 create mode 100644 demo/net/mcast-receiver.c
 create mode 100644 demo/net/mcast-sender.c
 create mode 100644 demo/net/raw-ethernet.c
 create mode 100644 demo/net/rtt-mcast-measure.c
 create mode 100644 demo/net/rtt-mcast-responder.c
 create mode 100644 demo/net/rtt-responder.c
 create mode 100644 demo/net/rtt-sender.c
 create mode 100644 demo/net/rttcp-client.c
 create mode 100644 demo/net/rttcp-server.c
 create mode 100644 demo/net/udp-send.c
 create mode 100644 kernel/drivers/net/stack/include/ipv4/igmp.h
 create mode 100644 kernel/drivers/net/stack/include/rtif_vlan.h
 create mode 100644 kernel/drivers/net/stack/include/rtvlan.h
 create mode 100644 kernel/drivers/net/stack/ipv4/igmp.c
 create mode 100644 kernel/drivers/net/stack/vlan.c
 create mode 100644 utils/net/rtvconfig.c

-- 
2.20.1


