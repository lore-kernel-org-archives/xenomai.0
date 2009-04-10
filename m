Message-ID: <49DF102B.4030107@domain.hid>
Date: Fri, 10 Apr 2009 11:23:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Git pull request.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>


Hi Philippe,

I got some changes ready for head. What we want to include in the stable
branch remains to be discussed, once we agree, I will prepare another
branch for v2.4.x patches.

The following changes since commit bbbaec33689d8e82b604745bb55209a83d79a4bc:
  Philippe Gerum (1):
        Test for self-deletion in a safer way

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-upstream

Gilles Chanteperdrix (4):
      Improve switchtest coverage.
      x86 FPU fixes
      Optimize x86 fpu switches.
      Fix rt_task_trampoline and rt_task_shadow error paths.

 include/asm-arm/fptest.h              |   14 +-
 include/asm-blackfin/fptest.h         |   10 +
 include/asm-powerpc/fptest.h          |   34 +++
 include/asm-x86/bits/pod_32.h         |   41 ++---
 include/asm-x86/bits/pod_64.h         |   39 ++--
 include/asm-x86/fptest.h              |   31 +++
 include/rtdm/rttesting.h              |    8 +-
 ksrc/drivers/testing/switchtest.c     |  385
+++++++++++++++++++++------------
 src/skins/native/task.c               |   43 +++--
 src/testsuite/switchtest/switchtest.c |  239 ++++++++++++++------
 10 files changed, 567 insertions(+), 277 deletions(-)

-- 
                                                 Gilles.

