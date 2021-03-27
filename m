From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH v2 0/7] assorted v5.x related fixups
Date: Sat, 27 Mar 2021 11:19:05 +0100
Message-Id: <20210327101912.2291474-1-rpm@xenomai.org>
MIME-Version: 1.0
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

From: Philippe Gerum <rpm@xenomai.org>

More wrappers and other changes required to build for the kernel v5.x
series.

Philippe Gerum (7):
  cobalt/memory: fix __vmalloc() calls
  cobalt/debug: switch to mmap_lock interface
  cobalt/kernel: convert to proc_ops
  cobalt/debug: prefer dump_stack() to show_stack()
  drivers/net: wrap csum_partial_copy_nocheck()
  drivers/net: icmp: remove variable-length array
  drivers/net: cfg: fix config file load up

 kernel/cobalt/debug.c                         |  6 +-
 kernel/cobalt/heap.c                          |  3 +-
 .../include/asm-generic/xenomai/wrappers.h    | 59 +++++++++++++++
 kernel/cobalt/posix/memory.c                  |  7 +-
 kernel/cobalt/vfile.c                         | 26 +++----
 kernel/drivers/analogy/device.c               | 12 +--
 kernel/drivers/can/mscan/rtcan_mscan_proc.c   | 12 +--
 kernel/drivers/can/rtcan_module.c             | 66 ++++++++---------
 .../drivers/can/sja1000/rtcan_sja1000_proc.c  | 12 +--
 kernel/drivers/net/stack/ipv4/icmp.c          | 34 ++++++---
 kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c  | 74 +++++++++----------
 kernel/drivers/net/stack/rtskb.c              |  3 +-
 12 files changed, 189 insertions(+), 125 deletions(-)

-- 
2.29.2


