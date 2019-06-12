From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/5] Syscall restart fix, smokey fixes
Date: Wed, 12 Jun 2019 17:31:13 +0200
Message-Id: <cover.1560353478.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This also replaces the previously sent version of
"testsuite/smokey: gdb: Catch dup and write errors".

Jan

Jan Kiszka (5):
  testsuite/smokey/gdb: Catch dup and write errors
  testsuite/smokey/gdb: Cleanup check helpers
  cobalt/thread: Clear XNSYSRST when migrating to Linux
  cobalt/posix/clock: Remove unneeded local variable
  testsuite/smokey/sigdebug: Fix check_no_error and some callers

 kernel/cobalt/posix/clock.c          |  3 +-
 kernel/cobalt/thread.c               |  5 ++++
 testsuite/smokey/gdb/gdb.c           | 56 +++++++++++++++++++-----------------
 testsuite/smokey/sigdebug/sigdebug.c | 15 ++++++----
 4 files changed, 44 insertions(+), 35 deletions(-)

-- 
2.16.4


