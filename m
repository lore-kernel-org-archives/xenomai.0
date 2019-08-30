From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: RTnet reformatting in next
Message-ID: <d83fefe5-acd5-5ff5-f852-20c9c5d37e7d@siemens.com>
Date: Fri, 30 Aug 2019 21:47:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi all,

just a heads-up that I pushed this to next:

 kernel/drivers/net/addons/cap.c                    |  680 +++--
 kernel/drivers/net/addons/proxy.c                  |  373 ++-
 .../net/drivers/experimental/rt2500/rt2500pci.c    | 1798 ++++++------
 .../net/drivers/experimental/rt2500/rt2500pci.h    | 1762 ++++++------
 .../net/drivers/experimental/rt2500/rt2x00.h       |  677 ++---
 .../net/drivers/experimental/rt2500/rt2x00core.c   |  565 ++--
 kernel/drivers/net/drivers/loopback.c              |   93 +-
 kernel/drivers/net/drivers/pcnet32.c               | 2020 +++++++-------
 kernel/drivers/net/stack/corectl.c                 |    4 +-
 kernel/drivers/net/stack/eth.c                     |  106 +-
 kernel/drivers/net/stack/include/ethernet/eth.h    |   12 +-
 kernel/drivers/net/stack/include/ipv4/af_inet.h    |    3 +-
 kernel/drivers/net/stack/include/ipv4/arp.h        |   19 +-
 kernel/drivers/net/stack/include/ipv4/icmp.h       |   18 +-
 .../drivers/net/stack/include/ipv4/ip_fragment.h   |    6 +-
 kernel/drivers/net/stack/include/ipv4/ip_input.h   |    4 +-
 kernel/drivers/net/stack/include/ipv4/ip_output.h  |   10 +-
 kernel/drivers/net/stack/include/ipv4/ip_sock.h    |    3 +-
 kernel/drivers/net/stack/include/ipv4/protocol.h   |   20 +-
 kernel/drivers/net/stack/include/ipv4/route.h      |   16 +-
 kernel/drivers/net/stack/include/ipv4/tcp.h        |   18 +-
 kernel/drivers/net/stack/include/ipv4/udp.h        |    4 +-
 kernel/drivers/net/stack/include/ipv4_chrdev.h     |  116 +-
 kernel/drivers/net/stack/include/nomac_chrdev.h    |   12 +-
 kernel/drivers/net/stack/include/rtcfg/rtcfg.h     |    4 +-
 .../net/stack/include/rtcfg/rtcfg_client_event.h   |   15 +-
 .../net/stack/include/rtcfg/rtcfg_conn_event.h     |   34 +-
 .../drivers/net/stack/include/rtcfg/rtcfg_event.h  |  113 +-
 .../drivers/net/stack/include/rtcfg/rtcfg_file.h   |   12 +-
 .../drivers/net/stack/include/rtcfg/rtcfg_frame.h  |  112 +-
 .../drivers/net/stack/include/rtcfg/rtcfg_ioctl.h  |    5 +-
 .../drivers/net/stack/include/rtcfg/rtcfg_proc.h   |   18 +-
 kernel/drivers/net/stack/include/rtcfg_chrdev.h    |  263 +-
 kernel/drivers/net/stack/include/rtdev.h           |  228 +-
 kernel/drivers/net/stack/include/rtdev_mgr.h       |   18 +-
 kernel/drivers/net/stack/include/rtmac.h           |   46 +-
 .../drivers/net/stack/include/rtmac/nomac/nomac.h  |   23 +-
 .../net/stack/include/rtmac/nomac/nomac_dev.h      |    4 +-
 .../net/stack/include/rtmac/nomac/nomac_ioctl.h    |    3 +-
 .../net/stack/include/rtmac/nomac/nomac_proto.h    |    1 -
 .../drivers/net/stack/include/rtmac/rtmac_disc.h   |   60 +-
 .../drivers/net/stack/include/rtmac/rtmac_proc.h   |    2 -
 .../drivers/net/stack/include/rtmac/rtmac_proto.h  |   61 +-
 .../drivers/net/stack/include/rtmac/rtmac_vnic.h   |    8 +-
 kernel/drivers/net/stack/include/rtmac/tdma/tdma.h |  171 +-
 .../net/stack/include/rtmac/tdma/tdma_dev.h        |    4 +-
 .../net/stack/include/rtmac/tdma/tdma_ioctl.h      |    3 +-
 .../net/stack/include/rtmac/tdma/tdma_proto.h      |   50 +-
 .../net/stack/include/rtmac/tdma/tdma_worker.h     |    3 +-
 kernel/drivers/net/stack/include/rtnet_chrdev.h    |  113 +-
 kernel/drivers/net/stack/include/rtnet_internal.h  |   27 +-
 kernel/drivers/net/stack/include/rtnet_iovec.h     |   10 +-
 kernel/drivers/net/stack/include/rtnet_port.h      |   33 +-
 kernel/drivers/net/stack/include/rtnet_rtpc.h      |   46 +-
 kernel/drivers/net/stack/include/rtnet_socket.h    |   84 +-
 kernel/drivers/net/stack/include/rtskb.h           |  555 ++--
 kernel/drivers/net/stack/include/rtskb_fifo.h      |  133 +-
 kernel/drivers/net/stack/include/rtwlan.h          |  265 +-
 kernel/drivers/net/stack/include/rtwlan_io.h       |  122 +-
 kernel/drivers/net/stack/include/stack_mgr.h       |   35 +-
 kernel/drivers/net/stack/include/tdma_chrdev.h     |   83 +-
 kernel/drivers/net/stack/iovec.c                   |   13 +-
 kernel/drivers/net/stack/ipv4/af_inet.c            |  375 ++-
 kernel/drivers/net/stack/ipv4/arp.c                |  232 +-
 kernel/drivers/net/stack/ipv4/icmp.c               |  612 ++---
 kernel/drivers/net/stack/ipv4/ip_fragment.c        |  407 ++-
 kernel/drivers/net/stack/ipv4/ip_input.c           |  156 +-
 kernel/drivers/net/stack/ipv4/ip_output.c          |  377 ++-
 kernel/drivers/net/stack/ipv4/ip_sock.c            |  227 +-
 kernel/drivers/net/stack/ipv4/protocol.c           |   61 +-
 kernel/drivers/net/stack/ipv4/route.c              | 1160 ++++----
 kernel/drivers/net/stack/ipv4/tcp/tcp.c            | 2871 ++++++++++----------
 kernel/drivers/net/stack/ipv4/tcp/timerwheel.c     |  229 +-
 kernel/drivers/net/stack/ipv4/tcp/timerwheel.h     |   31 +-
 kernel/drivers/net/stack/ipv4/udp/udp.c            |  984 ++++---
 kernel/drivers/net/stack/packet/af_packet.c        |  732 +++--
 .../drivers/net/stack/rtcfg/rtcfg_client_event.c   | 1964 +++++++------
 kernel/drivers/net/stack/rtcfg/rtcfg_conn_event.c  |  514 ++--
 kernel/drivers/net/stack/rtcfg/rtcfg_event.c       |  969 ++++---
 kernel/drivers/net/stack/rtcfg/rtcfg_file.c        |   51 +-
 kernel/drivers/net/stack/rtcfg/rtcfg_frame.c       |  765 +++---
 kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c       |  684 +++--
 kernel/drivers/net/stack/rtcfg/rtcfg_module.c      |   56 +-
 kernel/drivers/net/stack/rtcfg/rtcfg_proc.c        |  219 +-
 kernel/drivers/net/stack/rtcfg/rtcfg_timer.c       |  118 +-
 kernel/drivers/net/stack/rtdev.c                   |  892 +++---
 kernel/drivers/net/stack/rtdev_mgr.c               |   29 +-
 kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c   |   67 +-
 kernel/drivers/net/stack/rtmac/nomac/nomac_ioctl.c |   92 +-
 .../drivers/net/stack/rtmac/nomac/nomac_module.c   |  135 +-
 kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c |  134 +-
 kernel/drivers/net/stack/rtmac/rtmac_disc.c        |  299 +-
 kernel/drivers/net/stack/rtmac/rtmac_module.c      |   44 +-
 kernel/drivers/net/stack/rtmac/rtmac_proc.c        |  111 +-
 kernel/drivers/net/stack/rtmac/rtmac_proto.c       |   69 +-
 kernel/drivers/net/stack/rtmac/rtmac_syms.c        |    1 -
 kernel/drivers/net/stack/rtmac/rtmac_vnic.c        |  416 ++-
 kernel/drivers/net/stack/rtmac/tdma/tdma_dev.c     |  235 +-
 kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c   | 1102 ++++----
 kernel/drivers/net/stack/rtmac/tdma/tdma_module.c  |  378 ++-
 kernel/drivers/net/stack/rtmac/tdma/tdma_proto.c   |  581 ++--
 kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c  |  320 +--
 kernel/drivers/net/stack/rtnet_chrdev.c            |  262 +-
 kernel/drivers/net/stack/rtnet_module.c            |  227 +-
 kernel/drivers/net/stack/rtnet_rtpc.c              |  322 +--
 kernel/drivers/net/stack/rtskb.c                   |  519 ++--
 kernel/drivers/net/stack/rtwlan.c                  |  255 +-
 kernel/drivers/net/stack/socket.c                  |  292 +-
 kernel/drivers/net/stack/stack_mgr.c               |  210 +-
 109 files changed, 15712 insertions(+), 16193 deletions(-)

It's just a "clang-format -i" on the chosen RTnet files that were too
much off /wrt kernel style. Philippe proposed a complete conversion of 
the drivers/net folder, but I refrained from touching most drivers as 
they were generally coming from mainline already.

Philippe, rebasing your pending changes on top seems to be a quick
effort, I expect no major conflicts.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

