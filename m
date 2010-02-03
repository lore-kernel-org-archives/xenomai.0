Message-ID: <4B69BC43.9020604@domain.hid>
Date: Wed, 03 Feb 2010 19:11:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [announce] Xenomai v2.5.1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>

Hi,

here comes Xenomai v2.5.1, codenamed "Speed Of Light", available from 
Xenomai download area:
http://download.gna.org/xenomai/stable/xenomai-2.5.1.tar.bz2

In short, we got:
* a few fixes (you should find more details in the mailing list
archives):
- RPI under extreme conditions;
- skins reference counting;
- stack size issues and main thread stack faulting;
- rtdk behaviour with fork and exit;
- arm arith routines with old binutils version;
- arm mm switching;
- include order issues on uclibc/arm;
- compilation with static libraries.

* I-pipe patch fixes and new versions, asm wrappers upgrades to cope 
with new patches:
- x86 stall flag/interrupt flags issue with faults in primary mode;
- arm i-cache disabling in idle routine on arm926ejs;
- prepare support for upcoming 2.6.33 kernel.

* drivers update:
- rtcan, including new support for powerpc platforms;
- analogy, including a new s526 driver contributed by Simon Boulay.

shortlog follows:
Alessio Margan (1):
      analogy: rename s526 driver (analogy_s526)

Alexis Berlemont (9):
      analogy: fix the tests of the subdevice flags in the basic checks
      analogy: do not check the range if no range descriptor is found
      analogy: fix an ugly access in NI MIO driver
      analogy: add a4l_sizeof_sudb function
      analogy: add the function a4l_config_subd
      analogy: [NI mite] initialize channels' status
      analogy: [NI mite] add debug traces
      analogy: [NI mite] initialize the mite structures after their allocations
      analogy: fix a bug in the initialization of the user root descriptor

Gilles Chanteperdrix (32):
      nucleus: Fix RPI issue.
      hal: adapt to I-pipe patches for Linux 2.6.32+
      skins: factor user-space tacks sizes handling code
      asm-generic: distribute stacksize.h
      arm: fix rthal_irq_end
      blackfin: fix rthal_irq_host_request and rthal_irq_host_release
      nios: fix the two rthal_irq_host_request
      configure: do not enable vfp for at91sam9* family
      rtdk: various fixes.
      arm: fix arith inline assembly for old versions of binutils
      arm: full assembly version of nodiv_llimd
      arith: add testcases to the arith unit test
      nucleus: allow xnlock debugging even on UP kernels
      skins: fault the main thread stack when shadowing it.
      latency: account for and signal involuntary mode switches.
      arm: fix mm switching
      arm: upgrade I-pipe support to 2.6.30-arm-1.5.10
      build: require autoconf 2.52
      skins: fix compilation warnings
      skins: avoid extern weak declarations
      skins: move features check to asm/bits/bind.h
      build: list asm/bits headers on multiple lines

Jan Kiszka (1):
      Rename SIGXCPU to SIGDEBUG and deliver reason via siginfo

Philippe Gerum (25):
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
      powerpc: upgrade I-pipe support to 2.6.32.3-powerpc-2.8-00
      x86: upgrade I-pipe support to 2.6.32.7-x86-2.5-01
      asm-generic: use irq_to_desc() when available

Simon Boulay (8):
      analogy: add s526 driver
      analogy: some cosmetic change in s526 driver
      analogy: fix misuses of the instruction field data_size
      analogy: [s526] Remove dead code from attach function.
      analogy: [s526] Remove dead code from gpct_insn_config function.
      analogy: [s526] Cleanups; mainly generic comments from skel.c
      analogy: [s526] Remove useless HAVE_DIO option
      analogy: [s526] Cleanups; remove unused defines and variables

Wolfgang Grandegger (5):
      rtcan: mscan: use tabs for indention and white space cleanup
      rtcan: mscan: use proper io accessor functions for register access
      rtcan: mscan: new OF platform driver for MPC521x and MPC5200
      rtcan: mscan: fix build problems with 2.4.25 and 2.6.30.
      rtcan_rtt: Various fixes and improvement

Regards.

-- 
					    Gilles.

