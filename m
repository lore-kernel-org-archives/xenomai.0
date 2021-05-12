From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/7] Assorted improvements and 5.10-preparations from dovetail
 queue
Date: Wed, 12 May 2021 12:05:50 +0200
Message-Id: <cover.1620813957.git.jan.kiszka@siemens.com>
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

This prepares drivers for kernel 5.10 and removes the obsolete x32 ABI
as well as support for 32-bit x86 kernels.

After this, the dovetail queue should only contain directly
dovetail-related changes, nothing that could affect older kernels with
I-pipe.

Jan


CC: Philippe Gerum <rpm@xenomai.org>

Philippe Gerum (7):
  cobalt/memory: fix __vmalloc() calls
  drivers/net: checksum: convert to memcpy+csum
  drivers/net: cfg: fix config file load up
  drivers/testing: headcheck: remove variable-length array
  testsuite/smokey: trace test startup with verbose=2
  cobalt/x86: remove support for the x32 ABI
  cobalt/x86: remove kernel support for x86_32

 .../x86/include/asm/xenomai/uapi/syscall.h    |  8 +-
 .../x86/ipipe/include/asm/xenomai/machine.h   |  4 -
 .../x86/ipipe/include/asm/xenomai/syscall.h   |  4 +-
 .../include/asm/xenomai/syscall32-table.h     | 16 ----
 .../x86/ipipe/include/asm/xenomai/syscall32.h | 90 +-----------------
 kernel/cobalt/arch/x86/ipipe/thread.c         | 91 +------------------
 .../include/asm-generic/xenomai/wrappers.h    | 21 +++++
 kernel/cobalt/posix/syscall.c                 | 44 +++++----
 kernel/cobalt/posix/syscall32.c               | 26 ------
 kernel/cobalt/posix/syscall32.h               |  6 --
 kernel/cobalt/trace/cobalt-posix.h            |  7 --
 .../net/stack/include/rtnet_checksum.h        | 19 ++++
 kernel/drivers/net/stack/ipv4/icmp.c          | 19 ++--
 kernel/drivers/net/stack/ipv4/tcp/tcp.c       |  7 +-
 kernel/drivers/net/stack/ipv4/udp/udp.c       | 10 +-
 kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c  | 74 +++++++--------
 kernel/drivers/net/stack/rtskb.c              |  5 +-
 kernel/drivers/testing/heapcheck.c            | 18 ++--
 testsuite/smokey/main.c                       |  1 +
 19 files changed, 134 insertions(+), 336 deletions(-)
 create mode 100644 kernel/drivers/net/stack/include/rtnet_checksum.h

-- 
2.26.2


