Subject: Re: [PATCH 00/31] Update fec driver for xenomai 3 and linux kernel
 5.4 and add I.MX8 support
References: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
 <a32688bc-fa55-f0d3-f764-81edfd865def@siemens.com>
From: Jean-Baptiste Tredez <jean-baptiste.tredez@alstefgroup.com>
Message-ID: <a4b5893b-3bdb-2fcb-ccde-fa331f90e380@alstefgroup.com>
Date: Wed, 12 May 2021 11:52:13 +0200
In-Reply-To: <a32688bc-fa55-f0d3-f764-81edfd865def@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


Le 12/05/2021 à 08:57, Jan Kiszka a écrit :
> On 11.05.21 18:05, Jean-Baptiste Trédez via Xenomai wrote:
>> Update fec driver for xenomai 3 and linux kernel 5.4 and add I.MX8 support
>>
>> Patch  1 to 27 : rtnet-mcast+vlan branch from Philippe Gerum with updated driver for 4.18.85 kernel
>> Patch 28 to 29 : update driver for 5.4 kernel and add I.MX8 support
>> Patch 30 : bugfix on fec_enet_reset_skb
>> Patch 31 : reduce latency
>>
>>
>> Christophe Carton (1):
>>    utils/net: ping: display min and average round-trip time
>>
>> Florian Bezdeka (1):
>>    cobalt uapi: Introducing new feature flag for time64 availability
>>
> Seems your baseline was off. Please check that you were really sending
> from the right branch.
>
> Jan

The patch "[PATCH 01/31] cobalt uapi: Introducing new feature flag for 
time64 availability" was kept when i rebased rtnet-mcast+vlan branch on 
next. I can resend the whole set without it if needed.

Jean-Baptiste

>
>> Gilles Chanteperdrix (17):
>>    net/stack: plan for merging private device flags with
>>      netdev_priv_flags
>>    net/stack: add multicast support
>>    utils/net: rtifconfig: display device name untruncated
>>    net/stack: add support for VLAN filtering
>>    utils/net: add VLAN filter configuration tool
>>    net/udp: allow retrieving irq timestamp with SIOCGSTAMP ioctl
>>    net/udp sendmsg: do not return an error if dest addr is null
>>    net/stack: rtskb: increase buffer size
>>    net/stack: manager: ratelimit printk when dropping buffers
>>    net/ipv4: icmp: forward unused packets to proxy
>>    net/drivers: e1000e: enable multicast
>>    net/drivers: e1000e: enable VLAN filtering
>>    net/drivers: e1000e: add netdevice stats
>>    net/drivers: igb: enable multicast
>>    net/drivers: igb: enable VLAN filtering
>>    demo/net: add rtnet tests
>>    net/stack: increase maximum number of ethernet devices
>>
>> Jean-Baptiste Trédez (3):
>>    net/drivers: fec: update from linux kernel 5.4 and NXP I.MX8
>>    Kconfig : enable fec for ARM64 build
>>    net/drivers: fec: fix dev_kfree_rtskb on wrong buffer
>>
>> Philippe Gerum (8):
>>    net/drivers: fec: rebase over original driver from kernel 4.14.85
>>    net/drivers: fec: enable multicast
>>    demo: restrict net/ to cobalt build
>>    net/ipv4: route: fix counting of allocated net routes
>>    net/ipv4: route: handle default net route
>>    utils/net: rtroute: add/del default route
>>    net/ipv4: sock: handle SO_REUSEADDR for SOCK_DGRAM gracefully
>>    net/stack: igmp: resolve default multicast interface
>>
>> Arnaud Bouvet (1):
>>    net/drivers: fec: remove 1ms latency on frames reception
>>
>>   configure.ac                                  |    1 +
>>   demo/Makefile.am                              |    4 +
>>   demo/net/Makefile.am                          |   78 +
>>   demo/net/mcast-receiver.c                     |  205 +
>>   demo/net/mcast-sender.c                       |  151 +
>>   demo/net/raw-ethernet.c                       |  100 +
>>   demo/net/rtt-mcast-measure.c                  |  210 +
>>   demo/net/rtt-mcast-responder.c                |  109 +
>>   demo/net/rtt-responder.c                      |  193 +
>>   demo/net/rtt-sender.c                         |  341 ++
>>   demo/net/rttcp-client.c                       |  212 +
>>   demo/net/rttcp-server.c                       |  181 +
>>   demo/net/udp-send.c                           |  136 +
>>   include/cobalt/uapi/asm-generic/features.h    |    6 +-
>>   .../arm64/include/asm/xenomai/uapi/features.h |    1 +
>>   .../include/asm/xenomai/uapi/features.h       |    1 +
>>   .../x86/include/asm/xenomai/uapi/features.h   |    1 +
>>   kernel/drivers/net/addons/cap.c               |   46 +-
>>   kernel/drivers/net/doc/README.routing         |   22 +
>>   kernel/drivers/net/doc/README.rtnetproxy      |    6 +-
>>   kernel/drivers/net/drivers/Kconfig            |   11 +-
>>   kernel/drivers/net/drivers/Makefile           |    6 +-
>>   kernel/drivers/net/drivers/e1000e/e1000.h     |    7 +-
>>   kernel/drivers/net/drivers/e1000e/hw.h        |    2 +-
>>   kernel/drivers/net/drivers/e1000e/lib.c       |    7 +-
>>   kernel/drivers/net/drivers/e1000e/netdev.c    |  266 +-
>>   kernel/drivers/net/drivers/fec.c              | 1859 -------
>>   kernel/drivers/net/drivers/freescale/Makefile |    5 +
>>   kernel/drivers/net/drivers/freescale/fec.h    |  642 +++
>>   .../drivers/net/drivers/freescale/fec_main.c  | 4736 +++++++++++++++++
>>   .../drivers/net/drivers/freescale/fec_ptp.c   |  638 +++
>>   kernel/drivers/net/drivers/igb/e1000_mac.c    |    6 +-
>>   kernel/drivers/net/drivers/igb/e1000_mac.h    |    2 +-
>>   kernel/drivers/net/drivers/igb/igb_main.c     |   53 +-
>>   kernel/drivers/net/drivers/rt_fec.h           |  153 -
>>   kernel/drivers/net/stack/Kconfig              |    8 +
>>   kernel/drivers/net/stack/Makefile             |    2 +
>>   kernel/drivers/net/stack/include/ipv4/arp.h   |    3 +
>>   kernel/drivers/net/stack/include/ipv4/igmp.h  |  102 +
>>   .../drivers/net/stack/include/ipv4/protocol.h |    1 +
>>   kernel/drivers/net/stack/include/rtdev.h      |   47 +-
>>   kernel/drivers/net/stack/include/rtif_vlan.h  |  105 +
>>   kernel/drivers/net/stack/include/rtnet_port.h |    6 +-
>>   .../drivers/net/stack/include/rtnet_socket.h  |    6 +
>>   kernel/drivers/net/stack/include/rtskb.h      |    4 +-
>>   kernel/drivers/net/stack/include/rtvlan.h     |   25 +
>>   kernel/drivers/net/stack/ipv4/Kconfig         |    7 +
>>   kernel/drivers/net/stack/ipv4/Makefile        |    1 +
>>   kernel/drivers/net/stack/ipv4/af_inet.c       |    5 +
>>   kernel/drivers/net/stack/ipv4/arp.c           |   26 +
>>   kernel/drivers/net/stack/ipv4/icmp.c          |   14 +
>>   kernel/drivers/net/stack/ipv4/igmp.c          |  624 +++
>>   kernel/drivers/net/stack/ipv4/ip_output.c     |   13 +-
>>   kernel/drivers/net/stack/ipv4/ip_sock.c       |   73 +-
>>   kernel/drivers/net/stack/ipv4/protocol.c      |   17 +
>>   kernel/drivers/net/stack/ipv4/route.c         |   56 +-
>>   kernel/drivers/net/stack/ipv4/tcp/tcp.c       |    2 +-
>>   kernel/drivers/net/stack/ipv4/udp/udp.c       |   53 +-
>>   kernel/drivers/net/stack/rtdev.c              |  214 +
>>   kernel/drivers/net/stack/rtnet_chrdev.c       |    8 +-
>>   kernel/drivers/net/stack/rtnet_module.c       |    5 +
>>   kernel/drivers/net/stack/socket.c             |   17 +-
>>   kernel/drivers/net/stack/stack_mgr.c          |    2 +-
>>   kernel/drivers/net/stack/vlan.c               |  725 +++
>>   utils/net/Makefile.am                         |    1 +
>>   utils/net/rtifconfig.c                        |    2 +-
>>   utils/net/rtping.c                            |   16 +-
>>   utils/net/rtroute.c                           |   39 +-
>>   utils/net/rtvconfig.c                         |  257 +
>>   69 files changed, 10741 insertions(+), 2142 deletions(-)
>>   create mode 100644 demo/net/Makefile.am
>>   create mode 100644 demo/net/mcast-receiver.c
>>   create mode 100644 demo/net/mcast-sender.c
>>   create mode 100644 demo/net/raw-ethernet.c
>>   create mode 100644 demo/net/rtt-mcast-measure.c
>>   create mode 100644 demo/net/rtt-mcast-responder.c
>>   create mode 100644 demo/net/rtt-responder.c
>>   create mode 100644 demo/net/rtt-sender.c
>>   create mode 100644 demo/net/rttcp-client.c
>>   create mode 100644 demo/net/rttcp-server.c
>>   create mode 100644 demo/net/udp-send.c
>>   delete mode 100644 kernel/drivers/net/drivers/fec.c
>>   create mode 100644 kernel/drivers/net/drivers/freescale/Makefile
>>   create mode 100644 kernel/drivers/net/drivers/freescale/fec.h
>>   create mode 100644 kernel/drivers/net/drivers/freescale/fec_main.c
>>   create mode 100644 kernel/drivers/net/drivers/freescale/fec_ptp.c
>>   delete mode 100644 kernel/drivers/net/drivers/rt_fec.h
>>   create mode 100644 kernel/drivers/net/stack/include/ipv4/igmp.h
>>   create mode 100644 kernel/drivers/net/stack/include/rtif_vlan.h
>>   create mode 100644 kernel/drivers/net/stack/include/rtvlan.h
>>   create mode 100644 kernel/drivers/net/stack/ipv4/igmp.c
>>   create mode 100644 kernel/drivers/net/stack/vlan.c
>>   create mode 100644 utils/net/rtvconfig.c
>>

