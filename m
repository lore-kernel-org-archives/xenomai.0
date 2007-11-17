From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 17 Nov 2007 12:24:14 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_f9sPHVMY97bu2cm"
Message-Id: <200711171224.15108.niklaus.giger@domain.hid>
Subject: [Xenomai-help] Failure running prepare-kernel.sh
	adeos-ipipe-2.6.23-powerpc-DENX-2.0-03.patch
Reply-To: niklaus.giger@domain.hid
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

--Boundary-00=_f9sPHVMY97bu2cm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I get the attached errors when running
$ xenomai-trunk/scripts/prepare-kernel.sh \
--linux=linux-2.6-denx \
--adeos=xenomai-trunk/ksrc/arch/powerpc/patches/\
adeos-ipipe-2.6.23-powerpc-DENX-2.0-03.patch \
--arch=powerpc 

The kernel directory is a git clone of 
git://www.denx.de/git/linux-2.6-denx.git
and was created with the following command
git checkout -b sequoia-v2.6.23.1 v2.6.23.1
xenomai-trunk is at Revision 3185

I get the same errors when running against v2.6.23.

Could you please indicate me against which kernel this patch
was built against?

Any help would be appreciated.

-- 
Niklaus Giger

--Boundary-00=_f9sPHVMY97bu2cm
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="prepare.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="prepare.log"

patching file Makefile
patching file arch/powerpc/Kconfig
patching file arch/powerpc/boot/Makefile
patching file arch/powerpc/kernel/Makefile
patching file arch/powerpc/kernel/asm-offsets.c
patching file arch/powerpc/kernel/cputable.c
Hunk #1 succeeded at 1298 (offset -89 lines).
Hunk #2 succeeded at 1327 (offset -89 lines).
patching file arch/powerpc/kernel/entry_32.S
patching file arch/powerpc/kernel/entry_64.S
Hunk #7 succeeded at 503 (offset -4 lines).
Hunk #8 succeeded at 523 (offset -4 lines).
Hunk #9 succeeded at 561 (offset -4 lines).
Hunk #10 succeeded at 572 (offset -4 lines).
Hunk #11 succeeded at 581 (offset -4 lines).
Hunk #12 succeeded at 666 (offset -4 lines).
Hunk #13 succeeded at 700 (offset -4 lines).
Hunk #14 succeeded at 770 (offset -4 lines).
patching file arch/powerpc/kernel/head_32.S
can't find file to patch at input line 606
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
|index a8e0457..4225382 100644
|--- a/arch/powerpc/kernel/head_40x.S
|+++ b/arch/powerpc/kernel/head_40x.S
--------------------------
No file to patch.  Skipping patch.
3 out of 3 hunks ignored
patching file arch/powerpc/kernel/head_44x.S
patching file arch/powerpc/kernel/head_64.S
Hunk #2 succeeded at 331 (offset -22 lines).
Hunk #3 succeeded at 376 (offset -22 lines).
Hunk #4 succeeded at 408 (offset -22 lines).
Hunk #5 succeeded at 460 (offset -22 lines).
Hunk #6 succeeded at 480 (offset -22 lines).
Hunk #7 succeeded at 497 (offset -22 lines).
Hunk #8 succeeded at 510 (offset -22 lines).
Hunk #9 succeeded at 687 (offset -22 lines).
Hunk #10 succeeded at 704 (offset -22 lines).
Hunk #11 succeeded at 962 (offset -22 lines).
Hunk #12 succeeded at 1040 (offset -22 lines).
Hunk #13 succeeded at 1185 (offset -22 lines).
Hunk #14 succeeded at 1250 (offset -22 lines).
Hunk #15 succeeded at 1260 (offset -22 lines).
Hunk #16 succeeded at 1298 (offset -22 lines).
Hunk #17 succeeded at 1309 (offset -22 lines).
Hunk #18 succeeded at 1321 (offset -22 lines).
Hunk #19 succeeded at 1338 (offset -22 lines).
Hunk #20 succeeded at 1491 (offset -22 lines).
Hunk #21 succeeded at 2031 (offset -47 lines).
Hunk #22 succeeded at 2158 (offset -47 lines).
Hunk #23 succeeded at 2169 (offset -47 lines).
patching file arch/powerpc/kernel/head_8xx.S
patching file arch/powerpc/kernel/head_booke.h
patching file arch/powerpc/kernel/head_fsl_booke.S
patching file arch/powerpc/kernel/idle.c
patching file arch/powerpc/kernel/idle_power4.S
patching file arch/powerpc/kernel/io.c
patching file arch/powerpc/kernel/ipipe.c
patching file arch/powerpc/kernel/irq.c
patching file arch/powerpc/kernel/mcount_32.S
patching file arch/powerpc/kernel/mcount_64.S
patching file arch/powerpc/kernel/ppc_ksyms.c
patching file arch/powerpc/kernel/process.c
Hunk #2 FAILED at 335.
Hunk #3 succeeded at 333 with fuzz 2 (offset -11 lines).
Hunk #4 succeeded at 973 (offset -11 lines).
1 out of 4 hunks FAILED -- saving rejects to file arch/powerpc/kernel/process.c.rej
patching file arch/powerpc/kernel/setup_32.c
patching file arch/powerpc/kernel/setup_64.c
patching file arch/powerpc/kernel/smp.c
patching file arch/powerpc/kernel/time.c
Hunk #2 FAILED at 644.
Hunk #3 succeeded at 649 (offset -8 lines).
Hunk #4 succeeded at 677 (offset -8 lines).
Hunk #5 succeeded at 704 (offset -8 lines).
Hunk #6 succeeded at 720 (offset -8 lines).
1 out of 6 hunks FAILED -- saving rejects to file arch/powerpc/kernel/time.c.rej
patching file arch/powerpc/kernel/traps.c
Hunk #2 succeeded at 508 (offset -2 lines).
Hunk #3 succeeded at 529 (offset -2 lines).
Hunk #4 succeeded at 538 (offset -2 lines).
Hunk #5 succeeded at 560 (offset -2 lines).
Hunk #6 succeeded at 778 (offset -2 lines).
Hunk #7 succeeded at 853 (offset -2 lines).
Hunk #8 succeeded at 893 (offset -2 lines).
Hunk #9 succeeded at 910 (offset -2 lines).
Hunk #10 succeeded at 944 (offset -2 lines).
Hunk #11 succeeded at 996 (offset -2 lines).
Hunk #12 succeeded at 1029 (offset -2 lines).
Hunk #13 succeeded at 1069 (offset -2 lines).
Hunk #14 succeeded at 1085 (offset -2 lines).
Hunk #15 succeeded at 1127 (offset -2 lines).
patching file arch/powerpc/mm/fault.c
patching file arch/powerpc/mm/hash_native_64.c
Hunk #1 FAILED at 37.
Hunk #2 succeeded at 129 (offset -4 lines).
Hunk #3 succeeded at 138 (offset -4 lines).
Hunk #4 succeeded at 152 with fuzz 2 (offset -4 lines).
Hunk #5 succeeded at 174 (offset -10 lines).
Hunk #6 succeeded at 186 (offset -10 lines).
Hunk #7 succeeded at 213 (offset -10 lines).
Hunk #8 succeeded at 230 (offset -10 lines).
Hunk #9 succeeded at 238 (offset -10 lines).
Hunk #10 succeeded at 256 (offset -10 lines).
Hunk #11 succeeded at 335 (offset -10 lines).
1 out of 11 hunks FAILED -- saving rejects to file arch/powerpc/mm/hash_native_64.c.rej
patching file arch/powerpc/mm/hash_utils_64.c
patching file arch/powerpc/mm/slb.c
Hunk #2 succeeded at 167 (offset -10 lines).
patching file arch/powerpc/platforms/cell/spu_base.c
patching file arch/powerpc/platforms/iseries/irq.c
patching file arch/powerpc/platforms/powermac/pic.c
patching file arch/powerpc/platforms/ps3/htab.c
patching file arch/powerpc/platforms/ps3/interrupt.c
patching file arch/powerpc/platforms/pseries/lpar.c
patching file arch/powerpc/sysdev/i8259.c
patching file arch/powerpc/sysdev/ipic.c
patching file arch/powerpc/sysdev/mpic.c
Hunk #2 succeeded at 623 (offset -26 lines).
Hunk #3 succeeded at 635 (offset -26 lines).
Hunk #4 succeeded at 658 (offset -26 lines).
Hunk #5 succeeded at 691 (offset -26 lines).
Hunk #6 succeeded at 703 (offset -26 lines).
Hunk #7 succeeded at 741 (offset -26 lines).
Hunk #8 succeeded at 764 (offset -26 lines).
Hunk #9 succeeded at 833 (offset -26 lines).
Hunk #10 succeeded at 858 (offset -26 lines).
Hunk #11 succeeded at 867 (offset -26 lines).
Hunk #12 succeeded at 1493 (offset -38 lines).
Hunk #13 succeeded at 1509 (offset -38 lines).
Hunk #14 succeeded at 1523 (offset -38 lines).
patching file arch/powerpc/sysdev/tsi108_pci.c
patching file arch/powerpc/sysdev/uic.c
patching file drivers/pci/htirq.c
patching file drivers/serial/mpc52xx_uart.c
patching file include/asm-powerpc/hw_irq.h
patching file include/asm-powerpc/ipipe.h
patching file include/asm-powerpc/ipipe_base.h
patching file include/asm-powerpc/mmu_context.h
patching file include/asm-powerpc/paca.h
patching file include/asm-powerpc/ptrace.h
patching file include/asm-powerpc/reg.h
Hunk #1 succeeded at 734 (offset -14 lines).
patching file include/asm-powerpc/time.h
patching file include/asm-ppc/mmu_context.h
patching file include/linux/clockchips.h
patching file include/linux/hardirq.h
patching file include/linux/ipipe.h
patching file include/linux/ipipe_base.h
patching file include/linux/ipipe_compat.h
patching file include/linux/ipipe_percpu.h
patching file include/linux/ipipe_tickdev.h
patching file include/linux/ipipe_trace.h
patching file include/linux/irq.h
patching file include/linux/kernel.h
patching file include/linux/linkage.h
patching file include/linux/mm.h
patching file include/linux/preempt.h
patching file include/linux/sched.h
Hunk #3 succeeded at 1192 (offset -4 lines).
Hunk #4 succeeded at 1345 (offset -4 lines).
patching file include/linux/spinlock.h
patching file include/linux/spinlock_types.h
patching file init/Kconfig
patching file init/main.c
Hunk #1 succeeded at 524 (offset -1 lines).
Hunk #2 succeeded at 577 (offset -4 lines).
Hunk #3 succeeded at 742 (offset -4 lines).
patching file kernel/Makefile
patching file kernel/exit.c
patching file kernel/fork.c
Hunk #1 succeeded at 392 (offset -20 lines).
Hunk #2 succeeded at 926 (offset -20 lines).
Hunk #3 succeeded at 1275 (offset -20 lines).
patching file kernel/ipipe/Kconfig
patching file kernel/ipipe/Kconfig.debug
patching file kernel/ipipe/Makefile
patching file kernel/ipipe/core.c
patching file kernel/ipipe/tracer.c
patching file kernel/irq/chip.c
patching file kernel/power/swsusp.c
patching file kernel/printk.c
Hunk #1 succeeded at 504 (offset -92 lines).
Hunk #2 succeeded at 591 (offset -92 lines).
patching file kernel/sched.c
patching file kernel/signal.c
patching file kernel/spinlock.c
patching file kernel/time/clockevents.c
patching file lib/Kconfig.debug
patching file lib/bust_spinlocks.c
patching file lib/ioremap.c
patching file lib/smp_processor_id.c
patching file lib/spinlock_debug.c
patching file mm/memory.c
patching file mm/mlock.c
patching file mm/vmalloc.c

--Boundary-00=_f9sPHVMY97bu2cm--

