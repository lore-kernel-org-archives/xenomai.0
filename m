Date: Mon, 25 Feb 2008 21:38:47 +0100
Message-Id: <608371653@domain.hid>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Compiling Problems for Virtex II pro Board
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

HI

I tried to patch my Kernel 2.6.23 with the aedos patch. But I got the erro=
r listet at the end. I was using a Kernel from the Xilinx git tree because=
 there are all the driver included I need. Next I tried to use a the last =
2.6.23 Kernel from DENX, which succeded and they also support the ml300 Bo=
ard but the support for the Xilinx on-chip ethernet is missing. I need tha=
t support. So what can I do=3F The Xenomai patch doesn't only work with the =
DENX Kernels, right=3F But where can I look for the error=3F
Greetings & Thx for all help
Joachim

error:
--------------------------------------------------------------------------=
-----------------------------------------------------------------
meyer@domain.hid> ./prepare-kernel.sh
Linux tree [default /lib/modules/2.6.13-15.18-bigsmp/source]: ~/xenomai/te=
st/linux-2.6-xlnx.git
prepare-kernel.sh: cannot access Linux tree in ~/xenomai/test/linux-2.6-xl=
nx.git
Linux tree [default /usr/src]: /home/meyer/xenomai/test/linux-2.6-xlnx.git=

Target architecture [default i686]: ppc
Adeos patch [default /home/meyer/xenomai/xenomai-2.4.2/ksrc/arch/powerpc/p=
atches/adeos-ipipe-2.6.23-ppc-DENX-1.6-03.patch]:
patching file Makefile
patching file arch/powerpc/kernel/cputable.c
Hunk #1 succeeded at 1298 (offset -89 lines).
Hunk #2 succeeded at 1327 (offset -89 lines).
patching file arch/powerpc/kernel/idle.c
patching file arch/powerpc/kernel/io.c
patching file arch/powerpc/kernel/irq.c
patching file arch/powerpc/kernel/process.c
Hunk #2 succeeded at 333 with fuzz 2 (offset -11 lines).
Hunk #3 succeeded at 973 (offset -11 lines).
patching file arch/ppc/Kconfig
Hunk #1 succeeded at 980 (offset -32 lines).
patching file arch/ppc/boot/Makefile
patching file arch/ppc/kernel/Makefile
patching file arch/ppc/kernel/entry.S
Hunk #5 FAILED at 726.
1 out of 6 hunks FAILED -- saving rejects to file arch/ppc/kernel/entry.S.=
rej
patching file arch/ppc/kernel/head.S
patching file arch/ppc/kernel/head=5F44x.S
Hunk #1 succeeded at 426 (offset -1 lines).
patching file arch/ppc/kernel/head=5F4xx.S
patching file arch/ppc/kernel/head=5F8xx.S
patching file arch/ppc/kernel/head=5Fbooke.h
Hunk #1 succeeded at 187 (offset -4 lines).
Hunk #2 succeeded at 351 (offset -4 lines).
Hunk #3 succeeded at 367 (offset -4 lines).
patching file arch/ppc/kernel/head=5Ffsl=5Fbooke.S
patching file arch/ppc/kernel/ipipe.c
patching file arch/ppc/kernel/mcount=5F32.S
patching file arch/ppc/kernel/setup.c
patching file arch/ppc/kernel/time.c
patching file arch/ppc/kernel/traps.c
patching file arch/ppc/mm/fault.c
patching file arch/ppc/syslib/cpm2=5Fpic.c
patching file arch/ppc/syslib/ipic.c
patching file arch/ppc/syslib/open=5Fpic.c
patching file arch/ppc/syslib/ppc4xx=5Fpic.c
Hunk #3 succeeded at 292 (offset -30 lines).
patching file drivers/pci/htirq.c
patching file include/asm-powerpc/hw=5Firq.h
patching file include/asm-powerpc/time.h
patching file include/asm-ppc/ipipe.h
patching file include/asm-ppc/ipipe=5Fbase.h
patching file include/asm-ppc/mmu=5Fcontext.h
patching file include/linux/clockchips.h
patching file include/linux/hardirq.h
patching file include/linux/ipipe.h
patching file include/linux/ipipe=5Fbase.h
patching file include/linux/ipipe=5Fcompat.h
patching file include/linux/ipipe=5Fpercpu.h
patching file include/linux/ipipe=5Ftickdev.h
patching file include/linux/ipipe=5Ftrace.h
patching file include/linux/irq.h
patching file include/linux/kernel.h
patching file include/linux/linkage.h
patching file include/linux/mm.h
patching file include/linux/preempt.h
patching file include/linux/sched.h
Hunk #3 succeeded at 1192 (offset -5 lines).
Hunk #4 succeeded at 1345 (offset -5 lines).
patching file include/linux/spinlock.h
patching file include/linux/spinlock=5Ftypes.h
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
Hunk #3 succeeded at 1275 (offset -22 lines).
patching file kernel/ipipe/Kconfig
patching file kernel/ipipe/Kconfig.debug
patching file kernel/ipipe/Makefile
patching file kernel/ipipe/core.c
patching file kernel/ipipe/tracer.c
patching file kernel/irq/chip.c
patching file kernel/irq/handle.c
patching file kernel/power/swsusp.c
patching file kernel/printk.c
Hunk #1 succeeded at 504 (offset -92 lines).
Hunk #2 succeeded at 591 (offset -92 lines).
patching file kernel/sched.c
patching file kernel/signal.c
patching file kernel/spinlock.c
patching file kernel/time/clockevents.c
patching file lib/Kconfig.debug
patching file lib/bust=5Fspinlocks.c
patching file lib/ioremap.c
patching file lib/smp=5Fprocessor=5Fid.c
patching file lib/spinlock=5Fdebug.c
patching file mm/memory.c
patching file mm/mlock.c
patching file mm/vmalloc.c
prepare-kernel.sh: Unable to patch kernel 2.6.23xlnx with adeos-ipipe-2.6.=
23-ppc-DENX-1.6-03.patch.
meyer@domain.hid>  =20
--------------------------------------------------------------------------=
-----------------------------------------------------------------
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 30 Tage
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/=3Fmc=3D022220


