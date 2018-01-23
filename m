From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <cf55b724-6e0a-d445-374e-3c4f4421d7b6@xenomai.org>
Date: Tue, 23 Jan 2018 18:21:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RFC] RTnet fixes and other updates
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


For review by interested parties, proposed for inclusion in 3.0.6.

Thanks,

===

The following changes since commit 3a2fbc62b2dce64e959a49db9bcc049e6acc4e21:

  cobalt/rtdm: factor out iovec[] copy routines (2018-01-23 18:12:19 +0100)

are available in the git repository at:

  git://xenomai.org/xenomai-3.git wip/rtnet-fixes

for you to review changes up to df4f825d1d8ab1b7129af59d43b3f219f4ae5101:

  net/socket: forward private ioctl requests to NIC driver (2018-01-23 18:12:28 +0100)

----------------------------------------------------------------
Philippe Gerum (26):
      net/cap: fix panic in rtcap_signal_handler()
      net: wire up corectl interface
      net/tcp: fix invalid reference in getsockopt()
      net/socket: add get_arg/put_arg helpers
      net/iovec: add copy iterators for iovec[]
      net/packet: ioctl: remove direct references to user memory
      net/tcp: ioctl: remove direct references to user memory
      net/udp: ioctl: remove direct references to user memory
      net/packet: recvmsg: remove direct references to user memory
      net/packet: recvmsg: write back namelen only if name required
      net/packet: sendmsg: remove direct references to user memory
      net/udp: recvmsg: remove direct references to user memory
      net/udp: recvmsg: write back namelen only if name required
      net/udp: sendmsg: remove direct references to user memory
      net/tcp: recvmsg: remove direct references to user memory
      net/tcp: sendmsg: remove direct references to user memory
      net: convert to rtdm_get_iov_flatlen()
      net/iovec: drop useless kernel<-> iovec[] copy helpers
      net/udp: ioctl: fix temp arg buffer type
      net/packet: ioctl: remove direct references to user memory (2)
      net/udp: recvmsg, ioctl: remove direct references to user memory (2)
      net/packet: ioctl: remove direct references to user memory (3)
      net/socket: ioctl: remove direct references to user memory (2)
      net/socket: enforce secondary mode for SIOCETHTOOL
      net/socket: align rtdev do_ioctl handler on the regular ndo_do_ioctl
      net/socket: forward private ioctl requests to NIC driver

 kernel/drivers/net/addons/cap.c                 |  12 +++++---
 kernel/drivers/net/drivers/igb/igb_main.c       |   7 ++---
 kernel/drivers/net/stack/Makefile               |   3 +-
 kernel/drivers/net/stack/corectl.c              |   9 ++++--
 kernel/drivers/net/stack/include/rtdev.h        |   2 +-
 kernel/drivers/net/stack/include/rtnet_iovec.h  |  26 +++++-----------
 kernel/drivers/net/stack/include/rtnet_socket.h |  10 ++++--
 kernel/drivers/net/stack/iovec.c                | 107 +++++++++++++++++++++++++++++++++++++++------------------------
 kernel/drivers/net/stack/ipv4/tcp/tcp.c         | 168 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
 kernel/drivers/net/stack/ipv4/udp/udp.c         | 379 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------------------
 kernel/drivers/net/stack/packet/af_packet.c     | 334 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------
 kernel/drivers/net/stack/rtnet_module.c         |   6 ++++
 kernel/drivers/net/stack/socket.c               | 230 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------
 13 files changed, 823 insertions(+), 470 deletions(-)
-- 
Philippe.

