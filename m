Message-ID: <1226138210.49156262a5050@domain.hid>
Date: Sat,  8 Nov 2008 10:56:50 +0100
From: Dhouib Saadia <dhouib@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] adeos patch failed with 2.6.27-rc9 from
	git.xilinx.com
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


Hi,
I have installed successfully the latest version of linux (2.6.27-rc
from git.xilinx.com) on xupv2p platform embedding a ppc405 processor.
Then I want to install xenomai. I downloaded the latest version
(xenomai-2.4.5) and the latest adeos patch
(adeos-ipipe-2.6.26-powerpc-DENX-2.2-07.patch).
I run the prepare_kernel.sh script:
path to linux tree: /home/dhouib/xupv2p/linux-2.6-xlnx
adeos patch: =20
/home/dhouib/xupv2p/xenomai-2.4.5/ksrc/arch/powerpc/patches/adeos-ipipe-2=
.6.26-powerpc-DENX-2.2-07.patch

Then the patch was not applied correctly!
there was the following errors:
patching file include/linux/kernel.h
Hunk #1 FAILED at 14.
Hunk #2 succeeded at 111 with fuzz 1 (offset -2 lines).
1 out of 2 hunks FAILED -- saving rejects to file include/linux/kernel.h.=
rej
patching file include/linux/linkage.h
Hunk #1 succeeded at 95 (offset 6 lines).
patching file include/linux/mm.h
Hunk #1 succeeded at 114 with fuzz 2 (offset 5 lines).
patching file include/linux/preempt.h
Hunk #1 FAILED at 9.
1 out of 1 hunk FAILED -- saving rejects to file include/linux/preempt.h.=
rej
patching file include/linux/sched.h
Hunk #3 succeeded at 296 (offset 2 lines).
Hunk #4 succeeded at 1301 (offset -6 lines).
Hunk #5 FAILED at 1524.
1 out of 5 hunks FAILED -- saving rejects to file include/linux/sched.h.r=
ej
patching file include/linux/spinlock.h
Hunk #1 succeeded at 90 (offset 1 line).
Hunk #2 succeeded at 105 (offset 1 line).
Hunk #3 succeeded at 194 (offset 1 line).
Hunk #4 FAILED at 286.
Hunk #5 FAILED at 300.
Hunk #6 succeeded at 344 (offset 37 lines).
Hunk #7 succeeded at 358 (offset 37 lines).
Hunk #8 FAILED at 399.
Hunk #9 succeeded at 466 (offset 46 lines).
3 out of 9 hunks FAILED -- saving rejects to file
include/linux/spinlock.h.rej
patching file include/linux/spinlock_types.h
patching file init/Kconfig
patching file init/main.c
Hunk #1 succeeded at 552 (offset 4 lines).
Hunk #2 succeeded at 608 (offset 1 line).
Hunk #3 succeeded at 777 (offset 5 lines).
patching file kernel/Makefile
Hunk #1 succeeded at 79 (offset 15 lines).
patching file kernel/exit.c
Hunk #1 succeeded at 1074 (offset 32 lines).
patching file kernel/fork.c
Hunk #1 succeeded at 463 (offset 6 lines).
Hunk #2 succeeded at 856 with fuzz 2.
Hunk #3 succeeded at 1245 (offset -4 lines).
patching file kernel/ipipe/Kconfig
patching file kernel/ipipe/Kconfig.debug
patching file kernel/ipipe/Makefile
patching file kernel/ipipe/core.c
patching file kernel/ipipe/tracer.c
patching file kernel/irq/chip.c
Hunk #1 succeeded at 349 (offset -4 lines).
Hunk #2 succeeded at 428 (offset -4 lines).
Hunk #3 succeeded at 478 (offset -4 lines).
Hunk #4 succeeded at 521 (offset -4 lines).
Hunk #5 succeeded at 614 (offset -4 lines).
Hunk #6 succeeded at 644 (offset -4 lines).
Hunk #7 succeeded at 679 (offset -4 lines).
Hunk #8 succeeded at 703 (offset -4 lines).
patching file kernel/irq/handle.c
patching file kernel/lockdep.c
Hunk #1 succeeded at 2190 (offset 158 lines).
Hunk #2 succeeded at 2233 (offset 165 lines).
patching file kernel/panic.c
patching file kernel/power/disk.c
Hunk #1 succeeded at 207 with fuzz 2 (offset 13 lines).
Hunk #2 succeeded at 241 with fuzz 2 (offset 14 lines).
Hunk #3 FAILED at 317.
Hunk #4 succeeded at 356 with fuzz 2 (offset 22 lines).
1 out of 4 hunks FAILED -- saving rejects to file kernel/power/disk.c.rej
patching file kernel/printk.c
Hunk #1 succeeded at 572 (offset -114 lines).
Hunk #2 succeeded at 632 (offset -114 lines).
Hunk #3 succeeded at 698 (offset -114 lines).
patching file kernel/sched.c
Hunk #1 succeeded at 2221 (offset 133 lines).
Hunk #2 succeeded at 2579 (offset 141 lines).
Hunk #3 succeeded at 2633 (offset 146 lines).
Hunk #4 succeeded at 4364 with fuzz 2 (offset 324 lines).
Hunk #5 FAILED at 4381.
Hunk #6 succeeded at 4434 (offset 265 lines).
Hunk #7 succeeded at 4480 with fuzz 2 (offset 266 lines).
Hunk #8 succeeded at 5180 (offset 302 lines).
Hunk #9 succeeded at 5510 (offset 315 lines).
Hunk #10 succeeded at 9288 (offset 396 lines).
1 out of 10 hunks FAILED -- saving rejects to file kernel/sched.c.rej
patching file kernel/signal.c
Hunk #1 succeeded at 493 (offset -2 lines).
patching file kernel/spinlock.c
patching file kernel/time/tick-common.c
Hunk #2 succeeded at 167 (offset 2 lines).
patching file kernel/time/tick-sched.c
Hunk #1 succeeded at 491 (offset 22 lines).
Hunk #2 succeeded at 598 (offset 22 lines).
patching file kernel/timer.c
Hunk #1 succeeded at 982 (offset -8 lines).
patching file lib/Kconfig.debug
Hunk #1 succeeded at 128 (offset 3 lines).
patching file lib/bust_spinlocks.c
patching file lib/ioremap.c
patching file lib/smp_processor_id.c
Hunk #1 succeeded at 12 with fuzz 2 (offset -1 lines).
patching file lib/spinlock_debug.c
patching file mm/memory.c
Hunk #1 FAILED at 51.
Hunk #2 succeeded at 483 (offset 4 lines).
Hunk #3 succeeded at 517 (offset 4 lines).
Hunk #4 succeeded at 557 (offset 4 lines).
Hunk #5 succeeded at 602 (offset 4 lines).
Hunk #6 succeeded at 643 (offset 4 lines).
Hunk #7 succeeded at 1790 (offset 73 lines).
Hunk #8 succeeded at 3065 (offset 122 lines).
1 out of 8 hunks FAILED -- saving rejects to file mm/memory.c.rej
patching file mm/mlock.c
Hunk #1 succeeded at 171 (offset -2 lines).
patching file mm/vmalloc.c
prepare-kernel.sh: Unable to patch kernel 2.6.27-rc9 with
adeos-ipipe-2.6.26-powerpc-DENX-2.2-07.patch.


Could you help me to apply the patch?
Thanks

Saadia

-------------------------------------------------------------------------=
-------
Universit=E9 de Bretagne sud                               http://www.uni=
v-ubs.fr/

