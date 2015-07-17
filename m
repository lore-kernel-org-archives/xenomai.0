Message-ID: <55A8FBC9.3080207@siemens.com>
Date: Fri, 17 Jul 2015 14:57:45 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] Fixes for forge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

The following changes since commit 81958c620029485f3533b72f42b31ffb05eae234:

  cobalt/thread, copperplate: fetch per-thread user window from the global heap (2015-07-16 21:24:33 +0200)

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-forge

for you to fetch changes up to 9e297aa3edcf73454524106346420061d10d1208:

  cobalt/kernel: Generate cobalt_syscalls and cobalt_sysmodes (2015-07-16 23:48:50 +0200)

I've left out the mayday topic for now as it has known issues on
non-x86 / depends on I-pipe changes there.

----------------------------------------------------------------
Jan Kiszka (6):
      cobalt/kernel: Fix mode of mayday syscall
      cobalt/posix/sem: Do not register named semaphores with process resources
      cobalt/kernel: Mark backtrace syscall as lostage
      cobalt/kernel: Fix locking for xnthread info manipulations
      cobalt/kernel: Set commas in syscall tables inside the macros
      cobalt/kernel: Generate cobalt_syscalls and cobalt_sysmodes

 .../arch/x86/include/asm/xenomai/syscall32.h       |  12 +-
 kernel/cobalt/posix/Makefile                       |  12 ++
 kernel/cobalt/posix/gen-syscall-entries.sh         |  32 +++
 kernel/cobalt/posix/sem.c                          |  19 +-
 kernel/cobalt/posix/syscall.c                      | 218 ++-------------------
 kernel/cobalt/synch.c                              |   2 +
 kernel/cobalt/thread.c                             |   3 +
 scripts/prepare-kernel.sh                          |   4 +-
 8 files changed, 85 insertions(+), 217 deletions(-)
 create mode 100755 kernel/cobalt/posix/gen-syscall-entries.sh

