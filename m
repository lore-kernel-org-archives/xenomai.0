Message-ID: <4C6E9903.4010003@domain.hid>
Date: Fri, 20 Aug 2010 17:02:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [git pull] small RTDM fixes and assorted patches
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

The following changes since commit 7e2735614ebe515d57abeaa3ff6df375a7c4149f:

  sched: avoid infinite reschedule loops (2010-08-03 00:11:21 +0200)

are available in the git repository at:
  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (8):
      rt_print: Properly return printed length
      RTDM: Protect xnshadow_ppd_get via nklock
      RTDM: Plug race between proc_read_dev_info and device deregistration
      RTDM: Properly clean up on xnvfile setup errors
      RTDM: Extend device name space in open_fildes proc output
      Fix symbolic status ouput of root threads
      Create watchdog as non-blockable timer
      native: Improve documentation of rt_task_join and rt_task_delete

 ksrc/nucleus/sched.c     |    3 ++-
 ksrc/nucleus/thread.c    |    4 ++++
 ksrc/skins/native/task.c |   15 +++++++++++++--
 ksrc/skins/rtdm/core.c   |    2 ++
 ksrc/skins/rtdm/proc.c   |   45 +++++++++++++++++++++++++++++++++++----------
 src/rtdk/rt_print.c      |    1 +
 6 files changed, 57 insertions(+), 13 deletions(-)

The bug fixes (patches 1-4 and 7) should all be considered for 2.5 as
well, but some need rebasing. Will look into this once the series is
acceptable.

Jan

