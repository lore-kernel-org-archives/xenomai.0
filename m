From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 0/7] Scheduler related fixes
Date: Fri, 22 Nov 2019 18:19:42 +0100
Message-Id: <20191122171949.18021-1-rpm@xenomai.org>
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

Patch #5 is the most critical fix to 3.1-rc, which is direly needed by
the 3.0.x series too. Unlike previously stated, Xenomai 2.x is immune
to this issue. Although less critical, patches #3 and #7 are important
as well.

These changes have survived long-running switchtest and full smokey
test suite executing in parallel (including the GDB one). Tested on
4.19.84/x86, arm and arm64.

Philippe Gerum (7):
  cobalt/process: skip trap handling for the root thread
  cobalt/thread: update inline documentation
  cobalt/posix: fix missed rescheduling opportunities
  cobalt/process: remove superfluous check for non-relaxed state
  cobalt/thread: fix scheduler breakage on thread suspension
  cobalt/sched: drop useless rmb in lock check
  cobalt/sched: block CPU migration when rescheduling over root

 include/cobalt/kernel/sched.h | 46 ++++++++++++++---------------------
 kernel/cobalt/posix/process.c | 26 +++++++++-----------
 kernel/cobalt/thread.c        | 35 ++++++++++++++------------
 3 files changed, 49 insertions(+), 58 deletions(-)

-- 
2.21.0


