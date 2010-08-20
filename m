Message-ID: <4C6EA06E.6090105@domain.hid>
Date: Fri, 20 Aug 2010 17:34:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C6E9903.4010003@domain.hid>
In-Reply-To: <4C6E9903.4010003@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [git pull v2] small RTDM fixes and assorted patches
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

Stefan Kisdaroczi (1):
      RTDM device profiles: Document open_rt, socket_rt and close_rt deprecation

 include/rtdm/rtcan.h     |    4 ++--
 include/rtdm/rtserial.h  |    4 ++--
 include/rtdm/rttesting.h |    4 ++--
 ksrc/nucleus/sched.c     |    3 ++-
 ksrc/nucleus/thread.c    |    4 ++++
 ksrc/skins/native/task.c |   15 +++++++++++++--
 ksrc/skins/rtdm/core.c   |    2 ++
 ksrc/skins/rtdm/proc.c   |   45 +++++++++++++++++++++++++++++++++++----------
 src/rtdk/rt_print.c      |    1 +
 9 files changed, 63 insertions(+), 19 deletions(-)

Updated to include Stefan's long-pending RTDM profile updates.

