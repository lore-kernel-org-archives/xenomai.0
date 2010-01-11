From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Jan 2010 17:59:53 +0100
Message-ID: <1263229193.2455.125.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL REQUEST] 2.5.x maintenance - Preparation to
	2.6.33 and fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>


The following changes since commit c6e02d98c5139dd8088b69e7ad1e36d2603c2c11:
  Gilles Chanteperdrix (1):
        hal: adapt to I-pipe patches for Linux 2.6.32+

are available in the git repository at:

  git://git.xenomai.org/xenomai-rpm.git for-upstream

Philippe Gerum (22):
      powerpc: some cleanup in kernel stack vsid handling
      powerpc: silence compiler noise when FPU support is disabled
      powerpc: improve platform detection with --enable-linux-build
      nucleus: fix interrupt masking in rpi_next
      asm-generic: introduce rthal_irq_descp() supporting 2.6.33 and earlier
      arm: use generic rthal_irq_descp()
      nios2: use generic rthal_irq_descp()
      blackfin: use generic rthal_irq_descp()
      x86: use generic rthal_irq_descp()
      powerpc: use generic rthal_irq_descp()
      x86: always check whether irq descriptors are present
      arm: always check whether irq descriptors are present
      blackfin: always check whether irq descriptors are present
      nios2: always check whether irq descriptors are present
      powerpc: always check whether irq descriptors are present
      wrappers: introduce rthal_irqdesc_lock/unlock()
      powerpc: use rthal_irqdesc_lock/unlock()
      arm: use rthal_irqdesc_lock/unlock()
      x86: use rthal_irqdesc_lock/unlock()
      blackfin: use rthal_irqdesc_lock/unlock()
      nios2: use rthal_irqdesc_lock/unlock()
      nucleus: rework skin reference counting

 configure                      |    9 +++-
 configure.in                   |    9 +++-
 include/asm-arm/wrappers.h     |    1 -
 include/asm-blackfin/hal.h     |    2 -
 include/asm-generic/wrappers.h |   14 ++++++
 include/asm-nios2/hal.h        |    2 -
 include/asm-powerpc/bits/pod.h |   71 +++++++++++++++++--------------
 include/asm-powerpc/wrappers.h |    1 -
 include/asm-x86/wrappers_32.h  |    1 -
 include/asm-x86/wrappers_64.h  |    1 -
 ksrc/arch/arm/hal.c            |   26 +++++++-----
 ksrc/arch/blackfin/hal.c       |   22 ++++++++--
 ksrc/arch/nios2/hal.c          |   22 ++++++++--
 ksrc/arch/powerpc/hal.c        |   29 ++++++-------
 ksrc/arch/x86/hal-common.c     |   22 ++++++----
 ksrc/nucleus/shadow.c          |   90 ++++++++++++++++------------------------
 16 files changed, 176 insertions(+), 146 deletions(-)

-- 
Philippe.



