From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 08 Mar 2010 10:44:20 +0100
Message-ID: <1268041460.27899.27.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL REQUEST] 2.6.33/powerpc support
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

The following changes since commit 2cc55b9a5b99977f8902c48ef8a6dacb6f7a5018:
  Philippe Gerum (1):
        nucleus/intr: fix error code from xnintr_detach()

are available in the git repository at:

  git://xenomai.org/xenomai-rpm.git for-upstream

Philippe Gerum (6):
      powerpc: define calibration data for tqm8555
      timeconv: init time conversion helper with hrclock frequency
      powerpc: move to SYSINFO v2
      powerpc: upgrade I-pipe support to 2.6.33-powerpc-2.9-00
      testsuite: silence harmless warnings
      rtdk: silence harmless warnings

 include/asm-generic/syscall.h                      |    2 +-
 include/asm-generic/system.h                       |    5 +
 include/asm-powerpc/bits/init.h                    |    2 +-
 include/asm-powerpc/bits/timer.h                   |    2 +-
 include/asm-powerpc/calibration.h                  |    2 +
 include/asm-powerpc/hal.h                          |   11 -
 ksrc/arch/powerpc/hal.c                            |   14 +-
 ksrc/arch/powerpc/patches/README                   |   62 +-
 ...tch => adeos-ipipe-2.6.33-powerpc-2.9-00.patch} | 5493 ++++++++++++--------
 ksrc/nucleus/shadow.c                              |    2 +-
 src/rtdk/rt_print.c                                |    2 +
 src/skins/common/timeconv.c                        |   14 +-
 src/testsuite/latency/latency.c                    |    2 +-
 src/testsuite/switchtest/switchtest.c              |    2 +
 14 files changed, 3404 insertions(+), 2211 deletions(-)
 rename ksrc/arch/powerpc/patches/{adeos-ipipe-2.6.29.4-powerpc-DENX-2.6-02.patch => adeos-ipipe-2.6.33-powerpc-2.9-00.patch} (72%)

-- 
Philippe.



