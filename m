From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 03 Jul 2010 19:42:51 +0200
Message-ID: <1278178971.10155.72.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL REQUEST] mpc8xx support for 2.5.x
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


The following changes since commit a64f2f09c1cb4d35b4b11159cb5cbf9f55876201:
  Stefan Kisdaroczi (1):
        debian: fix init script start/stop values

are available in the git repository at:

  git://xenomai.org/xenomai-rpm.git for-upstream

Philippe Gerum (5):
      powerpc: introduce HW_MATH_EMU symbol
      switchtest: bail out upon sem_wait() error
      nucleus: export xnshadow_call_mayday() as a service
      powerpc: add calibration values for mpc8xx
      powerpc: upgrade I-pipe support to 2.6.34-powerpc-2.10-03

 include/asm-arm/bits/shadow.h                      |    4 +-
 include/asm-blackfin/bits/shadow.h                 |    4 +-
 include/asm-nios2/bits/shadow.h                    |    4 +-
 include/asm-powerpc/bits/shadow.h                  |    4 +-
 include/asm-powerpc/calibration.h                  |    4 +
 include/asm-powerpc/fptest.h                       |    4 +-
 include/asm-x86/bits/shadow_32.h                   |    4 +-
 include/asm-x86/bits/shadow_64.h                   |    4 +-
 include/nucleus/shadow.h                           |    5 +-
 ksrc/arch/powerpc/Kconfig                          |    4 +
 ...ch => adeos-ipipe-2.6.34-powerpc-2.10-03.patch} |  196 +++++++++++++++++++-
 ksrc/nucleus/sched.c                               |    5 +-
 ksrc/nucleus/shadow.c                              |    9 +-
 src/testsuite/switchtest/switchtest.c              |    8 +-
 14 files changed, 229 insertions(+), 30 deletions(-)
 rename ksrc/arch/powerpc/patches/{adeos-ipipe-2.6.34-powerpc-2.10-02.patch => adeos-ipipe-2.6.34-powerpc-2.10-03.patch} (98%)

-- 
Philippe.



