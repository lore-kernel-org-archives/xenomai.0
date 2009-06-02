Message-ID: <4A258A09.3020506@domain.hid>
Date: Tue, 02 Jun 2009 22:22:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Pull request.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>


Hi, 

here come a few fixes which were on my todo list for some time.

The following changes since commit 6c8f7c5b79b633bc1f50bbaa1d50ea3c309b3dcd:
  Philippe Gerum (1):
        Introduce xnarch_divrem_billion

are available in the git repository at:

  git://xenomai.org/xenomai-gch.git for-head

Gilles Chanteperdrix (9):
      Remove SIGSHADOW debug message
      Use PIC mute routines on the ARM platform
      Fix computation of heap overhead
      Adapt to preemptible context switch proposed by newer I-pipe patches
      Fix user-space tsc on ARM
      Fix git whitespace warnings
      Remove compilation warning
      Fix xnarch_divrem_billion not to use rthal_ullmul.
      Fix the POSIX skin to use the common time conversion.

 aclocal.m4                           | 6652 ++++++++++++++++++++++++++++++++++
 configure                            |   14 +-
 configure.in                         |   12 +-
 include/asm-arm/bits/pod.h           |    2 +
 include/asm-generic/bits/sigshadow.h |    3 -
 include/asm-generic/bits/timeconv.h  |    2 +-
 include/nucleus/heap.h               |   28 +-
 ksrc/arch/arm/Kconfig                |    5 +-
 ksrc/arch/arm/hal.c                  |    5 +-
 ksrc/nucleus/heap.c                  |    2 +-
 ksrc/skins/posix/internal.h          |    9 +-
 src/include/xeno_config.h.in         |    6 +-
 src/skins/posix/clock.c              |   15 +-
 13 files changed, 6709 insertions(+), 46 deletions(-)


-- 
					    Gilles.

