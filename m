Message-ID: <521E3326.2010806@siemens.com>
Date: Wed, 28 Aug 2013 19:28:06 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] Enable build against 3.10
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit 60957fb42f76275c2851c5720b65ce60fbd3e75d:

  posix: Skip auto-shadowing if current thread is already shadowed (2013-07-29 00:05:05 +0200)

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

for you to fetch changes up to d63fd4e8be4d57a9a90481f6cfe5374be91fce8d:

  analogy: Update procfs usage to latest kernel API (2013-08-21 17:00:53 +0200)

----------------------------------------------------------------
Jan Kiszka (6):
      nucleus: Remove unused xnvfile_*_p helpers
      nucleus: Adjust procfs usage to latest kernel API
      nucleus: Remove obsolete parent field from xnvfile
      rtcan: Debugging feature depends on procfs
      rtcan: Update procfs usage to latest kernel API
      analogy: Update procfs usage to latest kernel API

 include/analogy/device.h                      |   4 +-
 include/analogy/driver.h                      |   4 +-
 include/analogy/transfer.h                    |   4 +-
 include/asm-generic/wrappers.h                |  39 ++++
 include/nucleus/vfile.h                       |  18 --
 ksrc/drivers/analogy/device.c                 |  51 ++---
 ksrc/drivers/analogy/driver.c                 |  32 +---
 ksrc/drivers/analogy/rtdm_interface.c         |  42 ++--
 ksrc/drivers/analogy/transfer.c               |  32 +---
 ksrc/drivers/can/Kconfig                      |   2 +-
 ksrc/drivers/can/mscan/rtcan_mscan_proc.c     | 147 +++++++-------
 ksrc/drivers/can/rtcan_internal.h             |  62 ------
 ksrc/drivers/can/rtcan_module.c               | 266 +++++++++++++-------------
 ksrc/drivers/can/sja1000/rtcan_sja1000_proc.c |  48 ++---
 ksrc/nucleus/vfile.c                          |  34 +---
 15 files changed, 332 insertions(+), 453 deletions(-)

