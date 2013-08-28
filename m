Message-ID: <521E0D42.50605@siemens.com>
Date: Wed, 28 Aug 2013 16:46:26 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL][forge] Enable build against 3.10
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit 112dc09dcae854e16d2b01b3261a79cae95d9506:

  cobalt/kconfig: make Xenomai a menuconfig (2013-08-28 12:07:23 +0200)

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-forge

for you to fetch changes up to b759652f95c61b109f5764ccf8d653815c0fd216:

  analogy: Update procfs usage to latest kernel API (2013-08-28 16:18:23 +0200)

This is primarily the forward port of the vfile and driver updates for
3.10 from my Xenomai 2.6 queue.

Jan

----------------------------------------------------------------
Jan Kiszka (8):
      cobalt/vfile: Remove unused xnvfile_*_p helpers
      cobalt/vfile: Adjust procfs usage to latest kernel API
      cobalt/vfile: Add missing include of slab.h
      cobalt/vfile: Remove obsolete parent field from xnvfile
      cobalt/posix/timer: Fix debug output
      rtcan: Debugging feature depends on procfs
      rtcan: Update procfs usage to latest kernel API
      analogy: Update procfs usage to latest kernel API

 include/analogy/device.h                           |   4 +-
 include/analogy/driver.h                           |   4 +-
 include/analogy/transfer.h                         |   4 +-
 include/cobalt/kernel/vfile.h                      |  18 --
 .../cobalt/include/asm-generic/xenomai/wrappers.h  |  11 +
 kernel/cobalt/posix/timer.c                        |   3 +-
 kernel/cobalt/vfile.c                              |  38 +--
 kernel/drivers/analogy/device.c                    |  50 ++--
 kernel/drivers/analogy/driver.c                    |  32 +--
 kernel/drivers/analogy/rtdm_interface.c            |  42 +++-
 kernel/drivers/analogy/transfer.c                  |  32 +--
 kernel/drivers/can/Kconfig                         |   2 +-
 kernel/drivers/can/mscan/rtcan_mscan_proc.c        | 147 ++++++------
 kernel/drivers/can/rtcan_internal.h                |  62 -----
 kernel/drivers/can/rtcan_module.c                  | 266 ++++++++++-----------
 kernel/drivers/can/sja1000/rtcan_sja1000_proc.c    |  48 ++--
 16 files changed, 310 insertions(+), 453 deletions(-)

