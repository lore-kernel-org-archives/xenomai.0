Message-ID: <52D91E6B.7090408@siemens.com>
Date: Fri, 17 Jan 2014 13:13:31 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] forge: various small fixes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit 1250012103de3d14d0a68448b65fd0994c21bd5e:

  cobalt/posix/sem: fix error path on failed creation (2014-01-10 16:28:08 +0100)

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-forge

for you to fetch changes up to 520fc6ac080f2b4a47e39eaa7838270fb2768748:

  Silence unused_result warning from write() (2014-01-17 13:06:44 +0100)

Some patches are pretty old by now. I think I didn't miss any pending
review comment, otherwise please complain if I did.

Jan

----------------------------------------------------------------
Gernot Hillier (1):
      Silence unused_result warning from write()

Jan Kiszka (8):
      clocktest: Update to new clocks and clock encoding scheme
      xeno-test: Use new -E switch of clocktest
      cobalt: Add missing prefix to sc_cobalt_check_init
      cobalt/kernel: clean up timers on __xnthread_init errors
      switchtest: Bail out early from rtswitch_ktask on termination
      cobalt/kernel: Provide uninterruptible xnthread_join for RTDM use cases
      switchtest: Avoid clashes RTSWITCH_* vs. RTTST_SWTEST_* constants
      Provide "native" alias in xeno-config

 include/cobalt/kernel/rtdm/driver.h |  2 +-
 include/cobalt/kernel/thread.h      |  2 +-
 include/cobalt/uapi/syscall.h       |  2 +-
 kernel/cobalt/posix/syscall.c       |  2 +-
 kernel/cobalt/posix/thread.c        |  2 +-
 kernel/cobalt/rtdm/drvlib.c         |  2 +-
 kernel/cobalt/thread.c              | 22 +++++++++++++++++-----
 kernel/drivers/testing/switchtest.c |  9 +++------
 lib/cobalt/init.c                   |  3 ++-
 lib/cobalt/mutex.c                  |  2 +-
 scripts/xeno-config-cobalt.in       |  3 +++
 scripts/xeno-config-mercury.in      |  3 +++
 testsuite/clocktest/clocktest.c     | 17 +++++++++++++++--
 testsuite/latency/latency.c         |  2 +-
 testsuite/xeno-test/xeno-test.in    |  2 +-
 15 files changed, 52 insertions(+), 23 deletions(-)

