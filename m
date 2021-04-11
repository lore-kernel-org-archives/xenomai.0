From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 0/4] Various driver fix-lets
Date: Sun, 11 Apr 2021 09:54:17 +0200
Message-Id: <cover.1618127660.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Mostly for post 5.4 kernels, just the peak_canfd is relevant for older
ones as well.

Jan


CC: Jan Kiszka <jan.kiszka@siemens.com>

Jan Kiszka (4):
  drivers/can/peak_canfd: Fix building out-of-tree
  drivers/net: Account for renaming of
    pci_cleanup_aer_uncorrect_error_status in 5.7
  drivers/net/igb: Replace read_barrier_depends
  drivers/net/r8169: Remove duplicate and usused ether_crc definition

 .../include/asm-generic/xenomai/wrappers.h    |  4 ++++
 kernel/drivers/can/peak_canfd/Makefile        |  4 +++-
 kernel/drivers/net/drivers/e1000e/netdev.c    |  2 +-
 kernel/drivers/net/drivers/igb/igb_main.c     |  6 ++---
 kernel/drivers/net/drivers/r8169.c            | 24 -------------------
 5 files changed, 11 insertions(+), 29 deletions(-)

=2D-
2.26.2


