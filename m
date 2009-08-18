Message-ID: <4A8A50B4.90409@domain.hid>
Date: Tue, 18 Aug 2009 08:56:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Pull request for head.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

The following changes since commit 1c6417e62b1c9412bb278c340c1512f8ba4660d0:
  Matteo Facchinetti (1):
        rtcan: fix MPC5xxx_GPIO definition for 2.6.2[0-4] kernels

are available in the git repository at:

  git+ssh://git@domain.hid for-head

Gilles Chanteperdrix (12):
      native: increase user-space native skin default stack size.
      build: Do not compile with __thread by default on ARM
      arm: fix syscalls with gcc 4.3.2
      testsuite: fix division routines unit test feature macro test (for nodiv_llimd).
      maint: fix the extract-doc script to work with git
      posix: Fix user-space migration after pthread_mutex_trylock succeeds
      bind: avoid multiple initialisation of pthread_keys.
      trivial: Remove empty line
      testsuite: Fix mutex-torture-posix compilation, implement check_current_mode
      posix: do not declare pthread_mutexattr_setprotocol if already declared by the glibc
      arm: only enable I-pipe preemptible switch if UNLOCKED_SWITCH is enabled
      posix: fix shm leak

 configure.in                        |    5 +-
 include/asm-arm/syscall.h           |   30 +++++++++----
 include/asm-generic/bits/bind.h     |   10 ++++-
 include/posix/pthread.h             |    2 +
 ksrc/arch/arm/Kconfig               |    3 +-
 ksrc/skins/posix/cond.c             |    1 -
 ksrc/skins/posix/syscall.c          |    2 +
 scripts/maint/extract-doc           |   28 ++++++------
 src/skins/native/task.c             |    2 +
 src/skins/posix/mutex.c             |    8 ++--
 src/skins/posix/thread.c            |    4 +-
 src/testsuite/unit/Makefile.am      |    4 +-
 src/testsuite/unit/Makefile.in      |    4 +-
 src/testsuite/unit/arith-noinline.c |    2 +-
 src/testsuite/unit/arith.c          |   14 +++---
 src/testsuite/unit/mutex-torture.c  |   77 ++++++++++++++--------------------
 16 files changed, 105 insertions(+), 91 deletions(-)

-- 
					    Gilles.

