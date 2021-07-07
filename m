From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/3] Add callback-like mechanism before/after ptrace stops
Date: Wed,  7 Jul 2021 22:16:14 +0200
Message-Id: <cover.1625688977.git.jan.kiszka@siemens.com>
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

This allows debugged real-time processes to execute crucial operations
right before and after being stopped by a debugger. Such operations can
include pausing physical devices and resuming them in an ordered manner
so that no harm is caused to the outer world while debugging takes place
and the real-time process can resume normally after the debugging
session. It may also involve informing cooperating processes about the
ongoing debug session.

The model chosen for this is dedicating a real-time thread to this task.
This has the advantage of isolating the thread a bit from the debugged
contexts and also avoids having to introduce any kind of asynchronous
signaling mechanism. The helper thread will register itself with the
core and then run a loop, waiting for the next stop or resume event. At
the point the helper receives such an event, all other real-time threads
in the process have been stopped or not yet resumed so that the helper
cannot interact with them nor should wait for resources they may have
locked. The helper thread may also migrate to secondary mode before
releasing control, usually only after/before all time-sensitive
operations are executed.

These patches have a very long (likely too long) internal history at
Siemens, thus have shown to be useful at least for one of our use cases.

Jan

Jan Kiszka (3):
  cobalt/kernel: Introduce XNDBGCTRL to block SIGINT/SIGSTOP
  cobalt: Add ptrace debugging helper interface
  testsuite/smokey/gdb: Add test cases for ptrace-based debugging helper

 include/cobalt/Makefile.am          |  1 +
 include/cobalt/ptrace.h             | 37 +++++++++++
 include/cobalt/uapi/Makefile.am     |  1 +
 include/cobalt/uapi/kernel/thread.h |  1 +
 include/cobalt/uapi/ptrace.h        | 24 +++++++
 include/cobalt/uapi/syscall.h       |  2 +
 kernel/cobalt/posix/process.c       | 34 +++++++++-
 kernel/cobalt/posix/process.h       |  5 ++
 kernel/cobalt/posix/syscall.c       | 98 ++++++++++++++++++++++++++++-
 lib/cobalt/Makefile.am              |  1 +
 lib/cobalt/ptrace.c                 | 91 +++++++++++++++++++++++++++
 testsuite/smokey/gdb/gdb.c          | 84 ++++++++++++++++++++++++-
 12 files changed, 374 insertions(+), 5 deletions(-)
 create mode 100644 include/cobalt/ptrace.h
 create mode 100644 include/cobalt/uapi/ptrace.h
 create mode 100644 lib/cobalt/ptrace.c

-- 
2.26.2


