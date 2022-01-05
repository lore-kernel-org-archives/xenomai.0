From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/7] y2038: cond_wait_prologue64 and related fixes 
Date: Wed,  5 Jan 2022 15:06:43 +0100
Message-Id: <20220105140650.1033850-1-florian.bezdeka@siemens.com>
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

Hi all,

this is the last missing POSIX related y2038 affected syscall in
Xenomai. With this applied we have two Xenomai specific syscalls
missing:

  - sc_cobalt_thread_setschedparam_ex
  - sc_cobalt_thread_getschedparam_ex

While adding tests for the introduced cond_wait_prologue64 I hit a
kernel OOPS due to insuficient validation of user provided pointers.
That has been addressed as well.

This series has been tested against all Xenomai 3.3 supported
architectures / kernels. ipipe based kernels were out of scope (which
should not make any difference).

Best regards,
Florian

Florian Bezdeka (7):
  y2038: cobalt/posix/cond: Adding cond_wait_prologue64
  cobalt: posix/cond: Add missing __user annotation to user provided ptr
  y2038: lib/cobalt: Dispatch cond_wait_prologue
  cobalt: posix/cond: Add missing input validations
  y2038: testsuite/smokey/y2038: Adding tests for cond_wait_prologue64
  y2038: testsuite/smokey/y2038: Add a missing error handling path
  cobalt: Protect __xn_get_user() by access_ok()

 include/cobalt/uapi/syscall.h          |   1 +
 kernel/cobalt/posix/cond.c             |  54 ++++++++++---
 kernel/cobalt/posix/cond.h             |  17 ++++-
 kernel/cobalt/posix/internal.h         |   4 +
 kernel/cobalt/posix/nsem.c             |   3 +-
 kernel/cobalt/posix/syscall32.c        |  15 +++-
 kernel/cobalt/posix/syscall32.h        |   9 ++-
 kernel/cobalt/trace/cobalt-posix.h     |   3 +-
 lib/cobalt/cond.c                      |  21 +++++-
 testsuite/smokey/y2038/syscall-tests.c | 100 ++++++++++++++++++++++++-
 10 files changed, 206 insertions(+), 21 deletions(-)

-- 
2.30.2


