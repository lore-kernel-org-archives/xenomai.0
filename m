Message-ID: <52794480.6000609@xenomai.org>
Date: Tue, 05 Nov 2013 20:18:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Pull request: x86 and ARM dynamic XNFPU bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

The following changes since commit b959cde1c38f3e5f14f2cf917028e3fdf97cb1ef:

  cobalt/intr: Fix deadlock of xnintr_attach (2013-11-04 09:39:26 +0100)

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-forge

for you to fetch changes up to f3596abe75852e4c35ad9c2ac13b8890659a4118:

  cobalt/arm: lazy XNFPU bit (2013-11-05 20:07:33 +0100)

----------------------------------------------------------------
Gilles Chanteperdrix (15):
      copperplate: avoid compiler error
      cobalt/arm: use ipipe_switch_mm_head instead of switch_mm
      cobalt: allow architectures to track thread_info
      cobalt/x86: add missing fpu save for the migration case
      cobalt: avoid calling prefault in case of syscall failure
      testsuite: fix xeno-test for newer autoconf versions
      cobalt/fpu: remove xnarch_init_fpu, it is no longer used
      cobalt/fpu: pass xnthread structures to arch/*/thread.c
      cobalt/fpu: replace the is_root member with XNROOT tests
      cobalt/fpu: prepare for dynamic XNFPU
      cobalt/fpu: change xnarch_handle_fpu_fault interface
      cobalt/fpu: change fpu handling interface
      cobalt/x86: suppress *fpu_used wrappers
      cobalt/x86: lazy FPU switching
      cobalt/arm: lazy XNFPU bit

 include/cobalt/kernel/thread.h                       |    6 +-
 kernel/cobalt/arch/arm/Kconfig                       |    3 +
 kernel/cobalt/arch/arm/include/asm/xenomai/thread.h  |   75 +++---
 kernel/cobalt/arch/arm/mayday.c                      |    2 +-
 kernel/cobalt/arch/arm/thread.c                      |  298 +++++++--------------
 .../arch/blackfin/include/asm/xenomai/thread.h       |   23 +-
 kernel/cobalt/arch/blackfin/mayday.c                 |    2 +-
 kernel/cobalt/arch/blackfin/thread.c                 |    3 +-
 .../cobalt/arch/nios2/include/asm/xenomai/thread.h   |   23 +-
 kernel/cobalt/arch/nios2/mayday.c                    |    2 +-
 kernel/cobalt/arch/nios2/thread.c                    |    3 +-
 kernel/cobalt/arch/powerpc/Kconfig                   |    4 +
 .../cobalt/arch/powerpc/include/asm/xenomai/thread.h |   26 +-
 kernel/cobalt/arch/powerpc/mayday.c                  |    2 +-
 kernel/cobalt/arch/powerpc/thread.c                  |   41 +--
 kernel/cobalt/arch/sh/include/asm/xenomai/thread.h   |   22 +-
 kernel/cobalt/arch/sh/mayday.c                       |    2 +-
 kernel/cobalt/arch/sh/thread.c                       |   50 ++--
 kernel/cobalt/arch/x86/include/asm/xenomai/thread.h  |   32 ++-
 .../cobalt/arch/x86/include/asm/xenomai/wrappers.h   |   38 ---
 kernel/cobalt/arch/x86/mayday.c                      |    2 +-
 kernel/cobalt/arch/x86/thread.c                      |  149 +++++++----
 kernel/cobalt/include/asm-generic/xenomai/thread.h   |    8 +-
 kernel/cobalt/sched.c                                |    8 +-
 kernel/cobalt/shadow.c                               |   24 +-
 kernel/cobalt/thread.c                               |   30 +--
 lib/cobalt/cond.c                                    |    9 +-
 lib/cobalt/mutex.c                                   |    2 +
 lib/copperplate/init.c                               |    2 +-
 testsuite/xeno-test/xeno-test.in                     |   12 +-
 30 files changed, 419 insertions(+), 484 deletions(-)

-- 
                                                                Gilles.

