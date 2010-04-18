From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:41 +0200
Message-Id: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 00/23] [git pull] procfs overflow fixes and
	seq_file conversions
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

The following changes since commit 113ea4d56e8b215cb56ae7673013163ea5a5987d:
  Gilles Chanteperdrix (1):
        switchtest: increase stack sizes

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git queues/proc

This series fixes some of the potential (but when they happen fatal)
overflows in our procfs outputs. Specifically, it fixes all issues in
RTDM (one of them hit us in the field) and the recently reported
overflow in /proc/xenomai/heap. Moreover, Wolfgang started the lengthy
conversion of the registry by introducing a new seq_file-based interface
and already moving the native skin over.

The future belongs to seq_file, so some of the patches are strictly
spoken not yet required. But we better start this effort before the last
legacy interface user was converted and the old interface is suddenly
dropped from the kernel. This may not be that far away. A patch of mine
to improve error reporting of the old interface was rejected with
"->read_proc is going to be removed, so there is no point."

Jan Kiszka (9):
  hal: Mark file ops of rthal_add_proc_seq const
  RTDM: Plug race between proc_read_dev_info and device deregistration
  RTDM: Properly clean up on proc setup errors
  RTDM: Convert fildes proc to single-seq
  RTDM: Convert device information proc entry to single-seq
  RTDM: Convert open_fildes reading to seq_file
  RTDM: Extend device name space in open_fildes proc output
  RTDM: Convert device listings to seq_file
  nucleus: Convert heap proc entry to seq_file

Wolfgang Mauerer (14):
  nucleus: Convert irq proc entry to seqfile
  nucleus: Convert faults proc entry to seq_file mechanism
  nucleus: Convert apc proc file to the seq_file mechanism
  nucleus: Add infrastructure for supporting the seq_file mechanism in
    registry objects
  native: Convert the alarm registry proc entry to seq_single
  native: Convert buffer registry proc entry to the seq_file mechanism
  native: Convert cond registry proc entry to the seq_file mechanism
  native: convert the proc entry for the semaphore registry to seq_file
  native: Convert intr registry proc files to seq_file
  native: Convert event registry proc file to seq_file
  native: Convert heap registry proc file to seq_file
  native: Convert mutex registry proc entry to seq_file
  native: Convert queue registry proc entry to seq_file
  nucleus: Convert timebases proc entry to seq_file

 include/asm-generic/hal.h  |    8 +-
 include/nucleus/registry.h |   19 +-
 ksrc/arch/generic/hal.c    |  269 +++++++++++++++++++------
 ksrc/nucleus/heap.c        |  121 +++++++++--
 ksrc/nucleus/intr.c        |  149 ++++++++------
 ksrc/nucleus/registry.c    |   14 ++-
 ksrc/nucleus/timebase.c    |   64 +++---
 ksrc/skins/native/alarm.c  |   43 ++--
 ksrc/skins/native/buffer.c |   46 +++--
 ksrc/skins/native/cond.c   |   36 ++--
 ksrc/skins/native/event.c  |   40 ++--
 ksrc/skins/native/heap.c   |   50 +++---
 ksrc/skins/native/intr.c   |   44 ++--
 ksrc/skins/native/mutex.c  |   42 ++--
 ksrc/skins/native/queue.c  |   44 ++--
 ksrc/skins/native/sem.c    |   38 ++--
 ksrc/skins/rtdm/device.c   |   21 +--
 ksrc/skins/rtdm/internal.h |   19 ++
 ksrc/skins/rtdm/proc.c     |  481 +++++++++++++++++++++++++++++---------------
 19 files changed, 1008 insertions(+), 540 deletions(-)


