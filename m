From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/9] y2038: clock_{g,s}ettime64, clock_nanosleep64 
Date: Tue,  1 Jun 2021 11:43:25 +0200
Message-Id: <20210601094334.774394-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: jan.kiszka@siemens.com, chensong@tj.kylinos.cn, Florian Bezdeka <florian.bezdeka@siemens.com>

Hi!

This is the next set of changes needed for solving the y2038 problem.
Most patches were provided by Song. I reviewed them and fixed some error
handling problems as well as test failures on some architectures. Some
of the tests were rebased on top of the current next branch.

With this series applied the wip/dovetail and florian/y2038 [1] branches 
are merge-able without conflicts.

Best regards,
Florian

[1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/tree/florian/y2038

Florian Bezdeka (1):
  y2038: libcobalt: Centralize sc_cobalt_clock_gettime syscall

chensong (8):
  y2038: cobalt/posix/clock: Adding clock_gettime64
  y2038: cobalt/posix/clock: Adding clock_settime64
  y2038: lib/cobalt/clock: dispatch clock_gettime
  y2038: lib/cobalt/clock: dispatch clock_settime
  y2038: testsuite/smokey/y2038: testcase for settime64 and gettime64
  y2038: cobalt/posix/clock: Adding clock_nanosleep64
  y2038: lib/cobalt/clock: dispatch clock_nanosleep
  y2038: testsuite/smokey/y2038: Adding testcase for nanosleep64

 include/cobalt/kernel/time.h           |  11 ++
 include/cobalt/uapi/syscall.h          |   3 +
 kernel/cobalt/posix/clock.c            |  70 +++++++++++-
 kernel/cobalt/posix/clock.h            |  22 ++++
 kernel/cobalt/posix/syscall32.c        |  23 ++++
 kernel/cobalt/posix/syscall32.h        |  14 +++
 kernel/cobalt/time.c                   |  11 ++
 lib/cobalt/clock.c                     |  22 +++-
 testsuite/smokey/y2038/syscall-tests.c | 151 +++++++++++++++++++++++++
 9 files changed, 324 insertions(+), 3 deletions(-)

-- 
2.31.1


