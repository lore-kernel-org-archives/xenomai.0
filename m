From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 0/4] Dovetail prep work, cleanup series
Date: Sat,  5 Dec 2020 13:00:10 +0100
Message-Id: <20201205120014.2754097-1-rpm@xenomai.org>
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

This series contains prep work to the addition of a pipeline
abstraction layer towards Xenomai 3.2 supporting Dovetail, cleaning up
obsolete code. Based on the -next branch.

Philippe Gerum (4):
  cobalt/arm: disable unlocked context switching
  cobalt/kernel: drop support for preemptible context switching
  cobalt/syscall: use raw_printk() for serial debug output
  cobalt/clock: drop xnclock_get_host_time()

 include/cobalt/kernel/clock.h       |  2 -
 include/cobalt/kernel/sched.h       | 34 ---------------
 include/cobalt/kernel/thread.h      |  2 +-
 include/cobalt/uapi/kernel/thread.h |  1 -
 kernel/cobalt/arch/arm/Kconfig      | 22 ----------
 kernel/cobalt/clock.c               |  6 ---
 kernel/cobalt/posix/syscall.c       |  2 +-
 kernel/cobalt/sched.c               | 66 ++---------------------------
 kernel/cobalt/thread.c              | 23 +---------
 kernel/cobalt/timer.c               |  2 +-
 10 files changed, 7 insertions(+), 153 deletions(-)

-- 
2.26.2


