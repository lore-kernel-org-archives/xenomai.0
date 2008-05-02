From: "kerhoas.vincent" <kerhoas.vincent@domain.hid>
Message-ID: <15468836.10944871209713748048.JavaMail.www@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_976722_3830122.1209713748046"
Date: Fri,  2 May 2008 09:35:48 +0200 (CEST)
Subject: [Xenomai-help] problem patching xenomai with arm
Reply-To: "kerhoas.vincent" <kerhoas.vincent@domain.hid>
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

------=_Part_976722_3830122.1209713748046
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable





Hello

I'm trying to patch a linux kernel 2.6.8 or 2.15 with the  following comman=
d :

sudo scripts/prepare-kernel.sh  --arch=3Darm
\--adeos=3D/usr/src/adeos-ipipe-2.6.24-arm-1.9-01.patch
\--linux=3D/usr/src/linux-2.6.8.1


and  I've got an error for both of them.

So :

Is Xenomai realy working for  ARM ?
The patch is ok with those version of linux (I've got an error with  the
other ARM patches given with xenomai 2.4.3) ?
I'm working with ubuntu  7.10 ; maybe I've got to install other files  ?

another detail : my target is a cirrus logic ep9302 ; I've understood that =
it was possible to put RTAI on it, may I suppose that I can put xenomai too=
 ?

Vincent


___________________________________________________________________________=
_____________________

Hunk  #2 FAILED at 196.
Hunk #3 FAILED at 262.
Hunk #4 FAILED at 292.
Hunk #5  FAILED at 323.
4 out of 5 hunks FAILED -- saving rejects to  file
arch/arm/mach-integrator/core.c.rej
patching file  arch/arm/mach-integrator/integrator_cp.c
Hunk #2 FAILED at 20.
Hunk #3  succeeded at 172 (offset -52 lines).
Hunk #4 FAILED at 543.
2 out of 4  hunks FAILED -- saving rejects to  file
arch/arm/mach-integrator/integrator_cp.c.rej
patching file  arch/arm/mach-ixp4xx/common.c
Hunk #1 succeeded at 39 with fuzz 2 (offset -6  lines).
Hunk #2 succeeded at 305 with fuzz 2 (offset -24 lines).
Hunk #3  succeeded at 317 with fuzz 2 (offset -39 lines).
Hunk #4 FAILED at  501.
Hunk #5 FAILED at 530.
2 out of 5 hunks FAILED -- saving rejects to  file
arch/arm/mach-ixp4xx/common.c.rej
patching file  arch/arm/mach-pxa/irq.c
Hunk #1 succeeded at 172 (offset -76  lines).
patching file arch/arm/mach-pxa/leds-idp.c
Hunk #1 succeeded at 14  with fuzz 2 (offset 1 line).
patching file  arch/arm/mach-pxa/leds-lubbock.c
Hunk #1 succeeded at 13 with fuzz 2 (offset  1 line).
patching file arch/arm/mach-pxa/leds-mainstone.c
Hunk #1  succeeded at 12 with fuzz 2 (offset 1 line).
can't find file to patch at  input line 3028
Perhaps you used the wrong -p or --strip option?
The text  leading up to this was:
--------------------------
|diff --git  a/arch/arm/mach-pxa/leds-trizeps4.c
b/arch/arm/mach-pxa/leds-trizeps4.c
|index  2271d20..614f391 100644
|--- a/arch/arm/mach-pxa/leds-trizeps4.c
|+++  b/arch/arm/mach-pxa/leds-trizeps4.c
--------------------------
No file to  patch.=C2=A0 Skipping patch.
1 out of 1 hunk ignored
patching file  arch/arm/mach-pxa/time.c
Hunk #1 FAILED at 25.
Hunk #2 FAILED at  119.
Hunk #3 FAILED at 156.
Hunk #4 FAILED at 199.
Hunk #5 FAILED at  236.
Hunk #6 FAILED at 292.
Hunk #7 FAILED at 332.
Hunk #8 FAILED at  344.
8 out of 8 hunks FAILED -- saving rejects to  file
arch/arm/mach-pxa/time.c.rej
can't find file to patch at input line  3255
Perhaps you used the wrong -p or --strip option?
The text leading up  to this was:
--------------------------
|diff --git  a/arch/arm/mach-s3c2440/irq.c b/arch/arm/mach-s3c2440/irq.c
|index  a87608b..3fa7ceb 100644
|--- a/arch/arm/mach-s3c2440/irq.c
|+++  b/arch/arm/mach-s3c2440/irq.c
--------------------------
No file to  patch.=C2=A0 Skipping patch.
3 out of 3 hunks ignored
patching file  arch/arm/mach-sa1100/irq.c
Hunk #1 succeeded at 14 with fuzz 2 (offset -1  lines).
patching file arch/arm/mach-sa1100/leds-assabet.c
Hunk #1  succeeded at 11 with fuzz 2 (offset 1 line).
patching file  arch/arm/mach-sa1100/leds-badge4.c
Hunk #1 succeeded at 12 with fuzz 2  (offset 1 line).
patching file arch/arm/mach-sa1100/leds-cerf.c
Hunk #1  succeeded at 5 with fuzz 2 (offset 1 line).
patching file  arch/arm/mach-sa1100/leds-hackkit.c
Hunk #1 succeeded at 11 with fuzz 2  (offset 1 line).
patching file arch/arm/mach-sa1100/leds-lart.c
Hunk #1  succeeded at 11 with fuzz 2 (offset 1 line).
patching file  arch/arm/mach-sa1100/leds-simpad.c
Hunk #1 succeeded at 5 with fuzz 2 (offset  1 line).
patching file arch/arm/mach-sa1100/time.c
Hunk #1 succeeded at 13  with fuzz 1 (offset -1 lines).
Hunk #2 succeeded at 40 with fuzz 2 (offset 18  lines).
Hunk #3 succeeded at 111 (offset 18 lines).
Hunk #4 FAILED at  157.
Hunk #5 FAILED at 200.
Hunk #6 FAILED at 293.
3 out of 6 hunks  FAILED -- saving rejects to file
arch/arm/mach-sa1100/time.c.rej
patching  file arch/arm/mm/alignment.c
Hunk #1 succeeded at 457 with fuzz 2 (offset  -169 lines).
can't find file to patch at input line 3643
Perhaps you used  the wrong -p or --strip option?
The text leading up to this  was:
--------------------------
|diff --git a/arch/arm/mm/copypage-v4mc.c  b/arch/arm/mm/copypage-v4mc.c
|index ded0e96..bb79f37 100644
|---  a/arch/arm/mm/copypage-v4mc.c
|+++  b/arch/arm/mm/copypage-v4mc.c
--------------------------
No file to  patch.=C2=A0 Skipping patch.
2 out of 2 hunks ignored
can't find file to patch  at input line 3665
Perhaps you used the wrong -p or --strip option?
The  text leading up to this was:
--------------------------
|diff --git  a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.=
c
|index  2e455f8..accf6ed 100644
|--- a/arch/arm/mm/copypage-xscale.c
|+++  b/arch/arm/mm/copypage-xscale.c
--------------------------
No file to  patch.=C2=A0 Skipping patch.
2 out of 2 hunks ignored
patching file  arch/arm/mm/fault.c
Hunk #1 succeeded at 221 with fuzz 2 (offset -1  lines).
Hunk #2 succeeded at 329 (offset 4 lines).
Hunk #3 FAILED at  367.
Hunk #4 succeeded at 384 (offset 7 lines).
Hunk #5 succeeded at 460  with fuzz 1 (offset 5 lines).
Hunk #6 succeeded at 476 (offset 2 lines).
1  out of 6 hunks FAILED -- saving rejects to file arch/arm/mm/fault.c.rej
can't  find file to patch at input line 3785
Perhaps you used the wrong -p or  --strip option?
The text leading up to this  was:
--------------------------
|diff --git a/arch/arm/mm/pgd.c  b/arch/arm/mm/pgd.c
|index 50b9aed..1a90ca7 100644
|---  a/arch/arm/mm/pgd.c
|+++  b/arch/arm/mm/pgd.c
--------------------------
No file to patch.=C2=A0 Skipping  patch.
5 out of 5 hunks ignored
can't find file to patch at input line  3868
Perhaps you used the wrong -p or --strip option?
The text leading up  to this was:
--------------------------
|diff --git  a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
|index  8fbc884..adcd837 100644
|--- a/arch/arm/plat-s3c24xx/irq.c
|+++  b/arch/arm/plat-s3c24xx/irq.c
--------------------------
No file to  patch.=C2=A0 Skipping patch.
4 out of 4 hunks ignored
can't find file to patch  at input line 4023
Perhaps you used the wrong -p or --strip option?
The  text leading up to this was:
--------------------------
|diff --git  a/arch/arm/plat-s3c24xx/s3c244x-irq.c
b/arch/arm/plat-s3c24xx/s3c244x-irq.c
|index  2dbb260..e4ae071 100644
|--- a/arch/arm/plat-s3c24xx/s3c244x-irq.c
|+++  b/arch/arm/plat-s3c24xx/s3c244x-irq.c
--------------------------
No file  to patch.=C2=A0 Skipping patch.
2 out of 2 hunks ignored
can't find file to  patch at input line 4058
Perhaps you used the wrong -p or --strip  option?
The text leading up to this  was:
--------------------------
|diff --git a/arch/arm/plat-s3c24xx/time.c  b/arch/arm/plat-s3c24xx/time.c
|index 2ec1daa..4f6a358 100644
|---  a/arch/arm/plat-s3c24xx/time.c
|+++  b/arch/arm/plat-s3c24xx/time.c
--------------------------
No file to  patch.=C2=A0 Skipping patch.
13 out of 13 hunks ignored
can't find file to  patch at input line 4386
Perhaps you used the wrong -p or --strip  option?
The text leading up to this  was:
--------------------------
|diff --git a/drivers/pci/htirq.c  b/drivers/pci/htirq.c
|index 279c940..daabf90 100644
|---  a/drivers/pci/htirq.c
|+++  b/drivers/pci/htirq.c
--------------------------
No file to patch.=C2=A0  Skipping patch.
1 out of 1 hunk ignored
can't find file to patch at input  line 4399
Perhaps you used the wrong -p or --strip option?
The text  leading up to this was:
--------------------------
|diff --git  a/include/asm-arm/arch-at91/hardware.h
b/include/asm-arm/arch-at91/hardware.h
|index  8f1cdd3..2c1be7b 100644
|--- a/include/asm-arm/arch-at91/hardware.h
|+++  b/include/asm-arm/arch-at91/hardware.h
--------------------------
No file  to patch.=C2=A0 Skipping patch.
1 out of 1 hunk ignored
can't find file to  patch at input line 4429
Perhaps you used the wrong -p or --strip  option?
The text leading up to this  was:
--------------------------
|diff --git  a/include/asm-arm/arch-at91/irqs.h
b/include/asm-arm/arch-at91/irqs.h
|index  70b1216..8ecf341 100644
|--- a/include/asm-arm/arch-at91/irqs.h
|+++  b/include/asm-arm/arch-at91/irqs.h
--------------------------
No file to  patch.=C2=A0 Skipping patch.
1 out of 1 hunk ignored
can't find file to patch  at input line 4469
Perhaps you used the wrong -p or --strip option?
The  text leading up to this was:
--------------------------
|diff --git  a/include/asm-arm/arch-at91/timex.h
b/include/asm-arm/arch-at91/timex.h
|index  a310698..cb674fe 100644
|--- a/include/asm-arm/arch-at91/timex.h
|+++  b/include/asm-arm/arch-at91/timex.h
--------------------------
No file to  patch.=C2=A0 Skipping patch.
2 out of 2 hunks ignored
can't find file to patch  at input line 4496
Perhaps you used the wrong -p or --strip option?
The  text leading up to this was:
--------------------------
|diff --git  a/include/asm-arm/arch-imx/imx-regs.h
b/include/asm-arm/arch-imx/imx-regs.h
|index  fb9de27..724694c 100644
|--- a/include/asm-arm/arch-imx/imx-regs.h
|+++  b/include/asm-arm/arch-imx/imx-regs.h
--------------------------
No file  to patch.=C2=A0 Skipping patch.
2 out of 2 hunks ignored
can't find file to  patch at input line 4526
Perhaps you used the wrong -p or --strip  option?
The text leading up to this  was:
--------------------------
|diff --git  a/include/asm-arm/arch-imx/irqs.h
b/include/asm-arm/arch-imx/irqs.h
|index  f195542..799ae66 100644
|--- a/include/asm-arm/arch-imx/irqs.h
|+++  b/include/asm-arm/arch-imx/irqs.h
--------------------------
No file to  patch.=C2=A0 Skipping patch.
1 out of 1 hunk ignored
can't find file to patch  at input line 4548
Perhaps you used the wrong -p or --strip option?
The  text leading up to this was:
--------------------------
|diff --git  a/include/asm-arm/arch-integrator/entry-macro.S
b/include/asm-arm/arch-integrator/entry-macro.S
|index  491af1a..495262b 100644
|---  a/include/asm-arm/arch-integrator/entry-macro.S
|+++  b/include/asm-arm/arch-integrator/entry-macro.S
--------------------------
No  file to patch.=C2=A0 Skipping patch.
1 out of 1 hunk ignored
patching file  include/asm-arm/arch-integrator/irqs.h
patching file  include/asm-arm/arch-integrator/platform.h
Hunk #1 FAILED at 26.
Hunk #2  FAILED at 436.
Hunk #3 succeeded at 445 with fuzz 2 (offset -4 lines).
2  out of 3 hunks FAILED -- saving rejects to  file
include/asm-arm/arch-integrator/platform.h.rej
patching file  include/asm-arm/arch-integrator/timex.h
patching file  include/asm-arm/arch-ixp4xx/irqs.h
Hunk #1 succeeded at 52 (offset -18  lines).
patching file include/asm-arm/arch-pxa/irqs.h
Hunk #1 succeeded at  110 with fuzz 2 (offset 28 lines).
patching file  include/asm-arm/arch-s3c2410/irqs.h
Hunk #1 succeeded at 3 with fuzz  1.
Hunk #2 succeeded at 114 with fuzz 2 (offset -48 lines).
patching file  include/asm-arm/arch-sa1100/irqs.h
Hunk #1 succeeded at 145 (offset 1  line).
patching file include/asm-arm/atomic.h
Hunk #1 FAILED at  129.
Hunk #2 FAILED at 142.
Hunk #3 FAILED at 155.
Hunk #4 FAILED at  168.
4 out of 4 hunks FAILED -- saving rejects to  file
include/asm-arm/atomic.h.rej
patching file  include/asm-arm/bitops.h
Hunk #1 FAILED at 41.
Hunk #2 FAILED at  53.
Hunk #3 FAILED at 65.
Hunk #4 FAILED at 79.
Hunk #5 FAILED at  96.
Hunk #6 FAILED at 113.
6 out of 6 hunks FAILED -- saving rejects to  file
include/asm-arm/bitops.h.rej
patching file  include/asm-arm/ipipe.h
patching file include/asm-arm/ipipe_base.h
can't  find file to patch at input line 5165
Perhaps you used the wrong -p or  --strip option?
The text leading up to this  was:
--------------------------
|diff --git a/include/asm-arm/irqflags.h  b/include/asm-arm/irqflags.h
|index 6d09974..0aa4056 100644
|---  a/include/asm-arm/irqflags.h
|+++  b/include/asm-arm/irqflags.h
--------------------------
No file to patch.=C2=A0  Skipping patch.
7 out of 7 hunks ignored
patching file  include/asm-arm/mmu_context.h
Hunk #1 FAILED at 95.
1 out of 1 hunk FAILED  -- saving rejects to file
include/asm-arm/mmu_context.h.rej
patching file  include/asm-arm/system.h
Hunk #1 FAILED at 264.
Hunk #2 FAILED at  326.
2 out of 2 hunks FAILED -- saving rejects to  file
include/asm-arm/system.h.rej
patching file  include/asm-arm/thread_info.h
Hunk #1 FAILED at 146.
Hunk #2 FAILED at  156.
2 out of 2 hunks FAILED -- saving rejects to  file
include/asm-arm/thread_info.h.rej
can't find file to patch at input  line 5470
Perhaps you used the wrong -p or --strip option?
The text  leading up to this was:
--------------------------
|diff --git  a/include/linux/hardirq.h b/include/linux/hardirq.h
|index 8d30229..74b355d  100644
|--- a/include/linux/hardirq.h
|+++  b/include/linux/hardirq.h
--------------------------
No file to patch.=C2=A0  Skipping patch.
1 out of 1 hunk ignored
patching file  include/linux/ipipe.h
patching file include/linux/ipipe_base.h
patching  file include/linux/ipipe_compat.h
patching file  include/linux/ipipe_percpu.h
patching file  include/linux/ipipe_tickdev.h
patching file  include/linux/ipipe_trace.h
patching file include/linux/irq.h
Hunk #1  FAILED at 150.
Hunk #2 FAILED at 375.
2 out of 2 hunks FAILED -- saving  rejects to file include/linux/irq.h.rej
patching file  include/linux/kernel.h
Hunk #1 FAILED at 14.
Hunk #2 FAILED at 107.
2  out of 2 hunks FAILED -- saving rejects to file  include/linux/kernel.h.=
rej
patching file include/linux/linkage.h
Hunk #1  succeeded at 40 (offset -30 lines).
patching file include/linux/mm.h
Hunk  #1 FAILED at 104.
1 out of 1 hunk FAILED -- saving rejects to file  include/linux/mm.h.rej
patching file include/linux/preempt.h
Hunk #1  FAILED at 9.
1 out of 1 hunk FAILED -- saving rejects to file  include/linux/preempt.h.r=
ej
patching file include/linux/sched.h
Hunk #1  FAILED at 58.
Hunk #2 FAILED at 178.
Hunk #3 FAILED at 1174.
Hunk #4  FAILED at 1394.
4 out of 4 hunks FAILED -- saving rejects to file  include/linux/sched.h.re=
j
patching file include/linux/spinlock.h
Hunk #1  FAILED at 89.
Hunk #2 FAILED at 104.
Hunk #3 FAILED at 187.
Hunk #4  FAILED at 279.
Hunk #5 FAILED at 293.
Hunk #6 FAILED at 301.
Hunk #7  FAILED at 315.
Hunk #8 FAILED at 356.
Hunk #9 succeeded at 569 with fuzz 2  (offset 121 lines).
8 out of 9 hunks FAILED -- saving rejects to  file
include/linux/spinlock.h.rej
can't find file to patch at input line  6858
Perhaps you used the wrong -p or --strip option?
The text leading up  to this was:
--------------------------
|diff --git  a/include/linux/spinlock_types.h b/include/linux/spinlock_type=
s.h
|index  f6a3a95..4ca73f5 100644
|--- a/include/linux/spinlock_types.h
|+++  b/include/linux/spinlock_types.h
--------------------------
No file to  patch.=C2=A0 Skipping patch.
2 out of 2 hunks ignored
patching file  init/Kconfig
Hunk #1 FAILED at 64.
1 out of 1 hunk FAILED -- saving  rejects to file init/Kconfig.rej
patching file init/main.c
Hunk #1 FAILED  at 519.
Hunk #2 FAILED at 572.
Hunk #3 FAILED at 738.
3 out of 3 hunks  FAILED -- saving rejects to file init/main.c.rej
patching file  kernel/Makefile
Hunk #1 FAILED at 53.
1 out of 1 hunk FAILED -- saving  rejects to file kernel/Makefile.rej
patching file kernel/exit.c
Hunk #1  FAILED at 994.
1 out of 1 hunk FAILED -- saving rejects to file  kernel/exit.c.rej
patching file kernel/fork.c
Hunk #1 FAILED at  403.
Hunk #2 succeeded at 843 (offset -96 lines).
Hunk #3 FAILED at  1217.
2 out of 3 hunks FAILED -- saving rejects to file  kernel/fork.c.rej
patching file kernel/ipipe/Kconfig
patching file  kernel/ipipe/Kconfig.debug
patching file kernel/ipipe/Makefile
patching  file kernel/ipipe/core.c
patching file kernel/ipipe/tracer.c
can't find  file to patch at input line 10109
Perhaps you used the wrong -p or --strip  option?
The text leading up to this  was:
--------------------------
|diff --git a/kernel/irq/chip.c  b/kernel/irq/chip.c
|index 44019ce..933c8b3 100644
|---  a/kernel/irq/chip.c
|+++  b/kernel/irq/chip.c
--------------------------
No file to patch.=C2=A0 Skipping  patch.
8 out of 8 hunks ignored
patching file kernel/power/disk.c
Hunk  #1 FAILED at 154.
Hunk #2 FAILED at 181.
2 out of 2 hunks FAILED -- saving  rejects to file kernel/power/disk.c.rej
patching file  kernel/power/swsusp.c
Hunk #1 FAILED at 275.
Hunk #2 FAILED at 302.
2  out of 2 hunks FAILED -- saving rejects to file  kernel/power/swsusp.c.r=
ej
patching file kernel/printk.c
Hunk #1 succeeded  at 600 with fuzz 2 (offset 10 lines).
Hunk #2 FAILED at 660.
Hunk #3  succeeded at 778 with fuzz 2 (offset 78 lines).
1 out of 3 hunks FAILED --  saving rejects to file kernel/printk.c.rej
patching file  kernel/sched.c
Hunk #1 succeeded at 741 with fuzz 1 (offset -777  lines).
Hunk #2 FAILED at 1143.
Hunk #3 FAILED at 1192.
Hunk #4  succeeded at 1409 with fuzz 2 (offset -2101 lines).
Hunk #5 FAILED at  1426.
Hunk #6 FAILED at 1538.
Hunk #7 FAILED at 1580.
Hunk #8 FAILED at  1609.
Hunk #9 FAILED at 2262.
Hunk #10 FAILED at 5318.
8 out of 10  hunks FAILED -- saving rejects to file kernel/sched.c.rej
patching file  kernel/signal.c
Hunk #1 succeeded at 556 with fuzz 1 (offset 102  lines).
can't find file to patch at input line 10667
Perhaps you used the  wrong -p or --strip option?
The text leading up to this  was:
--------------------------
|diff --git a/kernel/spinlock.c  b/kernel/spinlock.c
|index cd72424..3e74c9b 100644
|---  a/kernel/spinlock.c
|+++  b/kernel/spinlock.c
--------------------------
No file to patch.=C2=A0 Skipping  patch.
2 out of 2 hunks ignored
can't find file to patch at input line  10689
Perhaps you used the wrong -p or --strip option?
The text leading up  to this was:
--------------------------
|diff --git a/lib/Kconfig.debug  b/lib/Kconfig.debug
|index a601093..6372a6f 100644
|---  a/lib/Kconfig.debug
|+++  b/lib/Kconfig.debug
--------------------------
No file to patch.=C2=A0 Skipping  patch.
1 out of 1 hunk ignored
patching file lib/bust_spinlocks.c
Hunk  #1 FAILED at 12.
1 out of 1 hunk FAILED -- saving rejects to file  lib/bust_spinlocks.c.rej
can't find file to patch at input line  10726
Perhaps you used the wrong -p or --strip option?
The text leading up  to this was:
--------------------------
|diff --git a/lib/ioremap.c  b/lib/ioremap.c
|index 14c6078..a275469 100644
|---  a/lib/ioremap.c
|+++ b/lib/ioremap.c
--------------------------
No file  to patch.=C2=A0 Skipping patch.
1 out of 1 hunk ignored
can't find file to  patch at input line 10741
Perhaps you used the wrong -p or --strip  option?
The text leading up to this  was:
--------------------------
|diff --git a/lib/smp_processor_id.c  b/lib/smp_processor_id.c
|index eddc9b3..66302ec 100644
|---  a/lib/smp_processor_id.c
|+++  b/lib/smp_processor_id.c
--------------------------
No file to patch.=C2=A0  Skipping patch.
1 out of 1 hunk ignored
can't find file to patch at input  line 10760
Perhaps you used the wrong -p or --strip option?
The text  leading up to this was:
--------------------------
|diff --git  a/lib/spinlock_debug.c b/lib/spinlock_debug.c
|index 9c4b025..08f096b  100644
|--- a/lib/spinlock_debug.c
|+++  b/lib/spinlock_debug.c
--------------------------
No file to patch.=C2=A0  Skipping patch.
6 out of 6 hunks ignored
patching file mm/memory.c
Hunk  #1 FAILED at 50.
Hunk #2 succeeded at 609 with fuzz 2 (offset 193  lines).
Hunk #3 FAILED at 645.
Hunk #4 FAILED at 685.
Hunk #5 FAILED at  730.
Hunk #6 FAILED at 772.
Hunk #7 FAILED at 1760.
Hunk #8 FAILED at  2992.
7 out of 8 hunks FAILED -- saving rejects to file  mm/memory.c.rej
patching file mm/mlock.c
Hunk #1 FAILED at 173.
1 out  of 1 hunk FAILED -- saving rejects to file mm/mlock.c.rej
patching file  mm/vmalloc.c
Hunk #1 FAILED at 161.
1 out of 1 hunk FAILED -- saving  rejects to file mm/vmalloc.c.rej
prepare-kernel.sh: Unable to patch kernel  2.6.8.1 with
adeos-ipipe-2.6.24-arm-1.9-01.patch.
kerhoas@domain.hid$






 Cr=C3=A9ez votre adresse =C3=A9lectronique pr=C3=A9nom.nom@domain.hid
 1 Go d'espace de stockage, anti-spam et anti-virus int=C3=A9gr=C3=A9s.

------=_Part_976722_3830122.1209713748046
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p style=3D"margin:0;padding:0;" align=3D"left"><br /></p><br /><br /><br /=
>Hello<br /><br />I'm trying to patch a linux kernel 2.6.8 or 2.15 with the=
  following command :<br /><br />sudo scripts/prepare-kernel.sh  --arch=3Da=
rm<br />\--adeos=3D/usr/src/adeos-ipipe-2.6.24-arm-1.9-01.patch<br />\--lin=
ux=3D/usr/src/linux-2.6.8.1<br /><br /><br />and  I've got an error for bot=
h of them.<br /><br />So :<br /><br />Is Xenomai realy working for  ARM ?<b=
r />The patch is ok with those version of linux (I've got an error with  th=
e<br />other ARM patches given with xenomai 2.4.3) ?<br />I'm working with =
ubuntu  7.10 ; maybe I've got to install other files  ?<br /><br />another =
detail : my target is a cirrus logic ep9302 ; I've understood that it was p=
ossible to put RTAI on it, may I suppose that I can put xenomai too ?<br />=
<br />Vincent<br /><br /><br />____________________________________________=
____________________________________________________<br /><br />Hunk  #2 FA=
ILED at 196.<br />Hunk #3 FAILED at 262.<br />Hunk #4 FAILED at 292.<br />H=
unk #5  FAILED at 323.<br />4 out of 5 hunks FAILED -- saving rejects to  f=
ile<br />arch/arm/mach-integrator/core.c.rej<br />patching file  arch/arm/m=
ach-integrator/integrator_cp.c<br />Hunk #2 FAILED at 20.<br />Hunk #3  suc=
ceeded at 172 (offset -52 lines).<br />Hunk #4 FAILED at 543.<br />2 out of=
 4  hunks FAILED -- saving rejects to  file<br />arch/arm/mach-integrator/i=
ntegrator_cp.c.rej<br />patching file  arch/arm/mach-ixp4xx/common.c<br />H=
unk #1 succeeded at 39 with fuzz 2 (offset -6  lines).<br />Hunk #2 succeed=
ed at 305 with fuzz 2 (offset -24 lines).<br />Hunk #3  succeeded at 317 wi=
th fuzz 2 (offset -39 lines).<br />Hunk #4 FAILED at  501.<br />Hunk #5 FAI=
LED at 530.<br />2 out of 5 hunks FAILED -- saving rejects to  file<br />ar=
ch/arm/mach-ixp4xx/common.c.rej<br />patching file  arch/arm/mach-pxa/irq.c=
<br />Hunk #1 succeeded at 172 (offset -76  lines).<br />patching file arch=
/arm/mach-pxa/leds-idp.c<br />Hunk #1 succeeded at 14  with fuzz 2 (offset =
1 line).<br />patching file  arch/arm/mach-pxa/leds-lubbock.c<br />Hunk #1 =
succeeded at 13 with fuzz 2 (offset  1 line).<br />patching file arch/arm/m=
ach-pxa/leds-mainstone.c<br />Hunk #1  succeeded at 12 with fuzz 2 (offset =
1 line).<br />can't find file to patch at  input line 3028<br />Perhaps you=
 used the wrong -p or --strip option?<br />The text  leading up to this was=
:<br />--------------------------<br />|diff --git  a/arch/arm/mach-pxa/led=
s-trizeps4.c<br />b/arch/arm/mach-pxa/leds-trizeps4.c<br />|index  2271d20.=
.614f391 100644<br />|--- a/arch/arm/mach-pxa/leds-trizeps4.c<br />|+++  b/=
arch/arm/mach-pxa/leds-trizeps4.c<br />--------------------------<br />No f=
ile to  patch.&nbsp; Skipping patch.<br />1 out of 1 hunk ignored<br />patc=
hing file  arch/arm/mach-pxa/time.c<br />Hunk #1 FAILED at 25.<br />Hunk #2=
 FAILED at  119.<br />Hunk #3 FAILED at 156.<br />Hunk #4 FAILED at 199.<br=
 />Hunk #5 FAILED at  236.<br />Hunk #6 FAILED at 292.<br />Hunk #7 FAILED =
at 332.<br />Hunk #8 FAILED at  344.<br />8 out of 8 hunks FAILED -- saving=
 rejects to  file<br />arch/arm/mach-pxa/time.c.rej<br />can't find file to=
 patch at input line  3255<br />Perhaps you used the wrong -p or --strip op=
tion?<br />The text leading up  to this was:<br />-------------------------=
-<br />|diff --git  a/arch/arm/mach-s3c2440/irq.c b/arch/arm/mach-s3c2440/i=
rq.c<br />|index  a87608b..3fa7ceb 100644<br />|--- a/arch/arm/mach-s3c2440=
/irq.c<br />|+++  b/arch/arm/mach-s3c2440/irq.c<br />----------------------=
----<br />No file to  patch.&nbsp; Skipping patch.<br />3 out of 3 hunks ig=
nored<br />patching file  arch/arm/mach-sa1100/irq.c<br />Hunk #1 succeeded=
 at 14 with fuzz 2 (offset -1  lines).<br />patching file arch/arm/mach-sa1=
100/leds-assabet.c<br />Hunk #1  succeeded at 11 with fuzz 2 (offset 1 line=
).<br />patching file  arch/arm/mach-sa1100/leds-badge4.c<br />Hunk #1 succ=
eeded at 12 with fuzz 2  (offset 1 line).<br />patching file arch/arm/mach-=
sa1100/leds-cerf.c<br />Hunk #1  succeeded at 5 with fuzz 2 (offset 1 line)=
.<br />patching file  arch/arm/mach-sa1100/leds-hackkit.c<br />Hunk #1 succ=
eeded at 11 with fuzz 2  (offset 1 line).<br />patching file arch/arm/mach-=
sa1100/leds-lart.c<br />Hunk #1  succeeded at 11 with fuzz 2 (offset 1 line=
).<br />patching file  arch/arm/mach-sa1100/leds-simpad.c<br />Hunk #1 succ=
eeded at 5 with fuzz 2 (offset  1 line).<br />patching file arch/arm/mach-s=
a1100/time.c<br />Hunk #1 succeeded at 13  with fuzz 1 (offset -1 lines).<b=
r />Hunk #2 succeeded at 40 with fuzz 2 (offset 18  lines).<br />Hunk #3 su=
cceeded at 111 (offset 18 lines).<br />Hunk #4 FAILED at  157.<br />Hunk #5=
 FAILED at 200.<br />Hunk #6 FAILED at 293.<br />3 out of 6 hunks  FAILED -=
- saving rejects to file<br />arch/arm/mach-sa1100/time.c.rej<br />patching=
  file arch/arm/mm/alignment.c<br />Hunk #1 succeeded at 457 with fuzz 2 (o=
ffset  -169 lines).<br />can't find file to patch at input line 3643<br />P=
erhaps you used  the wrong -p or --strip option?<br />The text leading up t=
o this  was:<br />--------------------------<br />|diff --git a/arch/arm/mm=
/copypage-v4mc.c  b/arch/arm/mm/copypage-v4mc.c<br />|index ded0e96..bb79f3=
7 100644<br />|---  a/arch/arm/mm/copypage-v4mc.c<br />|+++  b/arch/arm/mm/=
copypage-v4mc.c<br />--------------------------<br />No file to  patch.&nbs=
p; Skipping patch.<br />2 out of 2 hunks ignored<br />can't find file to pa=
tch  at input line 3665<br />Perhaps you used the wrong -p or --strip optio=
n?<br />The  text leading up to this was:<br />--------------------------<b=
r />|diff --git  a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xsc=
ale.c<br />|index  2e455f8..accf6ed 100644<br />|--- a/arch/arm/mm/copypage=
-xscale.c<br />|+++  b/arch/arm/mm/copypage-xscale.c<br />-----------------=
---------<br />No file to  patch.&nbsp; Skipping patch.<br />2 out of 2 hun=
ks ignored<br />patching file  arch/arm/mm/fault.c<br />Hunk #1 succeeded a=
t 221 with fuzz 2 (offset -1  lines).<br />Hunk #2 succeeded at 329 (offset=
 4 lines).<br />Hunk #3 FAILED at  367.<br />Hunk #4 succeeded at 384 (offs=
et 7 lines).<br />Hunk #5 succeeded at 460  with fuzz 1 (offset 5 lines).<b=
r />Hunk #6 succeeded at 476 (offset 2 lines).<br />1  out of 6 hunks FAILE=
D -- saving rejects to file arch/arm/mm/fault.c.rej<br />can't  find file t=
o patch at input line 3785<br />Perhaps you used the wrong -p or  --strip o=
ption?<br />The text leading up to this  was:<br />------------------------=
--<br />|diff --git a/arch/arm/mm/pgd.c  b/arch/arm/mm/pgd.c<br />|index 50=
b9aed..1a90ca7 100644<br />|---  a/arch/arm/mm/pgd.c<br />|+++  b/arch/arm/=
mm/pgd.c<br />--------------------------<br />No file to patch.&nbsp; Skipp=
ing  patch.<br />5 out of 5 hunks ignored<br />can't find file to patch at =
input line  3868<br />Perhaps you used the wrong -p or --strip option?<br /=
>The text leading up  to this was:<br />--------------------------<br />|di=
ff --git  a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c<br />=
|index  8fbc884..adcd837 100644<br />|--- a/arch/arm/plat-s3c24xx/irq.c<br =
/>|+++  b/arch/arm/plat-s3c24xx/irq.c<br />--------------------------<br />=
No file to  patch.&nbsp; Skipping patch.<br />4 out of 4 hunks ignored<br /=
>can't find file to patch  at input line 4023<br />Perhaps you used the wro=
ng -p or --strip option?<br />The  text leading up to this was:<br />------=
--------------------<br />|diff --git  a/arch/arm/plat-s3c24xx/s3c244x-irq.=
c<br />b/arch/arm/plat-s3c24xx/s3c244x-irq.c<br />|index  2dbb260..e4ae071 =
100644<br />|--- a/arch/arm/plat-s3c24xx/s3c244x-irq.c<br />|+++  b/arch/ar=
m/plat-s3c24xx/s3c244x-irq.c<br />--------------------------<br />No file  =
to patch.&nbsp; Skipping patch.<br />2 out of 2 hunks ignored<br />can't fi=
nd file to  patch at input line 4058<br />Perhaps you used the wrong -p or =
--strip  option?<br />The text leading up to this  was:<br />--------------=
------------<br />|diff --git a/arch/arm/plat-s3c24xx/time.c  b/arch/arm/pl=
at-s3c24xx/time.c<br />|index 2ec1daa..4f6a358 100644<br />|---  a/arch/arm=
/plat-s3c24xx/time.c<br />|+++  b/arch/arm/plat-s3c24xx/time.c<br />-------=
-------------------<br />No file to  patch.&nbsp; Skipping patch.<br />13 o=
ut of 13 hunks ignored<br />can't find file to  patch at input line 4386<br=
 />Perhaps you used the wrong -p or --strip  option?<br />The text leading =
up to this  was:<br />--------------------------<br />|diff --git a/drivers=
/pci/htirq.c  b/drivers/pci/htirq.c<br />|index 279c940..daabf90 100644<br =
/>|---  a/drivers/pci/htirq.c<br />|+++  b/drivers/pci/htirq.c<br />-------=
-------------------<br />No file to patch.&nbsp;  Skipping patch.<br />1 ou=
t of 1 hunk ignored<br />can't find file to patch at input  line 4399<br />=
Perhaps you used the wrong -p or --strip option?<br />The text  leading up =
to this was:<br />--------------------------<br />|diff --git  a/include/as=
m-arm/arch-at91/hardware.h<br />b/include/asm-arm/arch-at91/hardware.h<br /=
>|index  8f1cdd3..2c1be7b 100644<br />|--- a/include/asm-arm/arch-at91/hard=
ware.h<br />|+++  b/include/asm-arm/arch-at91/hardware.h<br />-------------=
-------------<br />No file  to patch.&nbsp; Skipping patch.<br />1 out of 1=
 hunk ignored<br />can't find file to  patch at input line 4429<br />Perhap=
s you used the wrong -p or --strip  option?<br />The text leading up to thi=
s  was:<br />--------------------------<br />|diff --git  a/include/asm-arm=
/arch-at91/irqs.h<br />b/include/asm-arm/arch-at91/irqs.h<br />|index  70b1=
216..8ecf341 100644<br />|--- a/include/asm-arm/arch-at91/irqs.h<br />|+++ =
 b/include/asm-arm/arch-at91/irqs.h<br />--------------------------<br />No=
 file to  patch.&nbsp; Skipping patch.<br />1 out of 1 hunk ignored<br />ca=
n't find file to patch  at input line 4469<br />Perhaps you used the wrong =
-p or --strip option?<br />The  text leading up to this was:<br />---------=
-----------------<br />|diff --git  a/include/asm-arm/arch-at91/timex.h<br =
/>b/include/asm-arm/arch-at91/timex.h<br />|index  a310698..cb674fe 100644<=
br />|--- a/include/asm-arm/arch-at91/timex.h<br />|+++  b/include/asm-arm/=
arch-at91/timex.h<br />--------------------------<br />No file to  patch.&n=
bsp; Skipping patch.<br />2 out of 2 hunks ignored<br />can't find file to =
patch  at input line 4496<br />Perhaps you used the wrong -p or --strip opt=
ion?<br />The  text leading up to this was:<br />--------------------------=
<br />|diff --git  a/include/asm-arm/arch-imx/imx-regs.h<br />b/include/asm=
-arm/arch-imx/imx-regs.h<br />|index  fb9de27..724694c 100644<br />|--- a/i=
nclude/asm-arm/arch-imx/imx-regs.h<br />|+++  b/include/asm-arm/arch-imx/im=
x-regs.h<br />--------------------------<br />No file  to patch.&nbsp; Skip=
ping patch.<br />2 out of 2 hunks ignored<br />can't find file to  patch at=
 input line 4526<br />Perhaps you used the wrong -p or --strip  option?<br =
/>The text leading up to this  was:<br />--------------------------<br />|d=
iff --git  a/include/asm-arm/arch-imx/irqs.h<br />b/include/asm-arm/arch-im=
x/irqs.h<br />|index  f195542..799ae66 100644<br />|--- a/include/asm-arm/a=
rch-imx/irqs.h<br />|+++  b/include/asm-arm/arch-imx/irqs.h<br />----------=
----------------<br />No file to  patch.&nbsp; Skipping patch.<br />1 out o=
f 1 hunk ignored<br />can't find file to patch  at input line 4548<br />Per=
haps you used the wrong -p or --strip option?<br />The  text leading up to =
this was:<br />--------------------------<br />|diff --git  a/include/asm-a=
rm/arch-integrator/entry-macro.S<br />b/include/asm-arm/arch-integrator/ent=
ry-macro.S<br />|index  491af1a..495262b 100644<br />|---  a/include/asm-ar=
m/arch-integrator/entry-macro.S<br />|+++  b/include/asm-arm/arch-integrato=
r/entry-macro.S<br />--------------------------<br />No  file to patch.&nbs=
p; Skipping patch.<br />1 out of 1 hunk ignored<br />patching file  include=
/asm-arm/arch-integrator/irqs.h<br />patching file  include/asm-arm/arch-in=
tegrator/platform.h<br />Hunk #1 FAILED at 26.<br />Hunk #2  FAILED at 436.=
<br />Hunk #3 succeeded at 445 with fuzz 2 (offset -4 lines).<br />2  out o=
f 3 hunks FAILED -- saving rejects to  file<br />include/asm-arm/arch-integ=
rator/platform.h.rej<br />patching file  include/asm-arm/arch-integrator/ti=
mex.h<br />patching file  include/asm-arm/arch-ixp4xx/irqs.h<br />Hunk #1 s=
ucceeded at 52 (offset -18  lines).<br />patching file include/asm-arm/arch=
-pxa/irqs.h<br />Hunk #1 succeeded at  110 with fuzz 2 (offset 28 lines).<b=
r />patching file  include/asm-arm/arch-s3c2410/irqs.h<br />Hunk #1 succeed=
ed at 3 with fuzz  1.<br />Hunk #2 succeeded at 114 with fuzz 2 (offset -48=
 lines).<br />patching file  include/asm-arm/arch-sa1100/irqs.h<br />Hunk #=
1 succeeded at 145 (offset 1  line).<br />patching file include/asm-arm/ato=
mic.h<br />Hunk #1 FAILED at  129.<br />Hunk #2 FAILED at 142.<br />Hunk #3=
 FAILED at 155.<br />Hunk #4 FAILED at  168.<br />4 out of 4 hunks FAILED -=
- saving rejects to  file<br />include/asm-arm/atomic.h.rej<br />patching f=
ile  include/asm-arm/bitops.h<br />Hunk #1 FAILED at 41.<br />Hunk #2 FAILE=
D at  53.<br />Hunk #3 FAILED at 65.<br />Hunk #4 FAILED at 79.<br />Hunk #=
5 FAILED at  96.<br />Hunk #6 FAILED at 113.<br />6 out of 6 hunks FAILED -=
- saving rejects to  file<br />include/asm-arm/bitops.h.rej<br />patching f=
ile  include/asm-arm/ipipe.h<br />patching file include/asm-arm/ipipe_base.=
h<br />can't  find file to patch at input line 5165<br />Perhaps you used t=
he wrong -p or  --strip option?<br />The text leading up to this  was:<br /=
>--------------------------<br />|diff --git a/include/asm-arm/irqflags.h  =
b/include/asm-arm/irqflags.h<br />|index 6d09974..0aa4056 100644<br />|--- =
 a/include/asm-arm/irqflags.h<br />|+++  b/include/asm-arm/irqflags.h<br />=
--------------------------<br />No file to patch.&nbsp;  Skipping patch.<br=
 />7 out of 7 hunks ignored<br />patching file  include/asm-arm/mmu_context=
.h<br />Hunk #1 FAILED at 95.<br />1 out of 1 hunk FAILED  -- saving reject=
s to file<br />include/asm-arm/mmu_context.h.rej<br />patching file  includ=
e/asm-arm/system.h<br />Hunk #1 FAILED at 264.<br />Hunk #2 FAILED at  326.=
<br />2 out of 2 hunks FAILED -- saving rejects to  file<br />include/asm-a=
rm/system.h.rej<br />patching file  include/asm-arm/thread_info.h<br />Hunk=
 #1 FAILED at 146.<br />Hunk #2 FAILED at  156.<br />2 out of 2 hunks FAILE=
D -- saving rejects to  file<br />include/asm-arm/thread_info.h.rej<br />ca=
n't find file to patch at input  line 5470<br />Perhaps you used the wrong =
-p or --strip option?<br />The text  leading up to this was:<br />---------=
-----------------<br />|diff --git  a/include/linux/hardirq.h b/include/lin=
ux/hardirq.h<br />|index 8d30229..74b355d  100644<br />|--- a/include/linux=
/hardirq.h<br />|+++  b/include/linux/hardirq.h<br />----------------------=
----<br />No file to patch.&nbsp;  Skipping patch.<br />1 out of 1 hunk ign=
ored<br />patching file  include/linux/ipipe.h<br />patching file include/l=
inux/ipipe_base.h<br />patching  file include/linux/ipipe_compat.h<br />pat=
ching file  include/linux/ipipe_percpu.h<br />patching file  include/linux/=
ipipe_tickdev.h<br />patching file  include/linux/ipipe_trace.h<br />patchi=
ng file include/linux/irq.h<br />Hunk #1  FAILED at 150.<br />Hunk #2 FAILE=
D at 375.<br />2 out of 2 hunks FAILED -- saving  rejects to file include/l=
inux/irq.h.rej<br />patching file  include/linux/kernel.h<br />Hunk #1 FAIL=
ED at 14.<br />Hunk #2 FAILED at 107.<br />2  out of 2 hunks FAILED -- savi=
ng rejects to file  include/linux/kernel.h.rej<br />patching file include/l=
inux/linkage.h<br />Hunk #1  succeeded at 40 (offset -30 lines).<br />patch=
ing file include/linux/mm.h<br />Hunk  #1 FAILED at 104.<br />1 out of 1 hu=
nk FAILED -- saving rejects to file  include/linux/mm.h.rej<br />patching f=
ile include/linux/preempt.h<br />Hunk #1  FAILED at 9.<br />1 out of 1 hunk=
 FAILED -- saving rejects to file  include/linux/preempt.h.rej<br />patchin=
g file include/linux/sched.h<br />Hunk #1  FAILED at 58.<br />Hunk #2 FAILE=
D at 178.<br />Hunk #3 FAILED at 1174.<br />Hunk #4  FAILED at 1394.<br />4=
 out of 4 hunks FAILED -- saving rejects to file  include/linux/sched.h.rej=
<br />patching file include/linux/spinlock.h<br />Hunk #1  FAILED at 89.<br=
 />Hunk #2 FAILED at 104.<br />Hunk #3 FAILED at 187.<br />Hunk #4  FAILED =
at 279.<br />Hunk #5 FAILED at 293.<br />Hunk #6 FAILED at 301.<br />Hunk #=
7  FAILED at 315.<br />Hunk #8 FAILED at 356.<br />Hunk #9 succeeded at 569=
 with fuzz 2  (offset 121 lines).<br />8 out of 9 hunks FAILED -- saving re=
jects to  file<br />include/linux/spinlock.h.rej<br />can't find file to pa=
tch at input line  6858<br />Perhaps you used the wrong -p or --strip optio=
n?<br />The text leading up  to this was:<br />--------------------------<b=
r />|diff --git  a/include/linux/spinlock_types.h b/include/linux/spinlock_=
types.h<br />|index  f6a3a95..4ca73f5 100644<br />|--- a/include/linux/spin=
lock_types.h<br />|+++  b/include/linux/spinlock_types.h<br />-------------=
-------------<br />No file to  patch.&nbsp; Skipping patch.<br />2 out of 2=
 hunks ignored<br />patching file  init/Kconfig<br />Hunk #1 FAILED at 64.<=
br />1 out of 1 hunk FAILED -- saving  rejects to file init/Kconfig.rej<br =
/>patching file init/main.c<br />Hunk #1 FAILED  at 519.<br />Hunk #2 FAILE=
D at 572.<br />Hunk #3 FAILED at 738.<br />3 out of 3 hunks  FAILED -- savi=
ng rejects to file init/main.c.rej<br />patching file  kernel/Makefile<br /=
>Hunk #1 FAILED at 53.<br />1 out of 1 hunk FAILED -- saving  rejects to fi=
le kernel/Makefile.rej<br />patching file kernel/exit.c<br />Hunk #1  FAILE=
D at 994.<br />1 out of 1 hunk FAILED -- saving rejects to file  kernel/exi=
t.c.rej<br />patching file kernel/fork.c<br />Hunk #1 FAILED at  403.<br />=
Hunk #2 succeeded at 843 (offset -96 lines).<br />Hunk #3 FAILED at  1217.<=
br />2 out of 3 hunks FAILED -- saving rejects to file  kernel/fork.c.rej<b=
r />patching file kernel/ipipe/Kconfig<br />patching file  kernel/ipipe/Kco=
nfig.debug<br />patching file kernel/ipipe/Makefile<br />patching  file ker=
nel/ipipe/core.c<br />patching file kernel/ipipe/tracer.c<br />can't find  =
file to patch at input line 10109<br />Perhaps you used the wrong -p or --s=
trip  option?<br />The text leading up to this  was:<br />-----------------=
---------<br />|diff --git a/kernel/irq/chip.c  b/kernel/irq/chip.c<br />|i=
ndex 44019ce..933c8b3 100644<br />|---  a/kernel/irq/chip.c<br />|+++  b/ke=
rnel/irq/chip.c<br />--------------------------<br />No file to patch.&nbsp=
; Skipping  patch.<br />8 out of 8 hunks ignored<br />patching file kernel/=
power/disk.c<br />Hunk  #1 FAILED at 154.<br />Hunk #2 FAILED at 181.<br />=
2 out of 2 hunks FAILED -- saving  rejects to file kernel/power/disk.c.rej<=
br />patching file  kernel/power/swsusp.c<br />Hunk #1 FAILED at 275.<br />=
Hunk #2 FAILED at 302.<br />2  out of 2 hunks FAILED -- saving rejects to f=
ile  kernel/power/swsusp.c.rej<br />patching file kernel/printk.c<br />Hunk=
 #1 succeeded  at 600 with fuzz 2 (offset 10 lines).<br />Hunk #2 FAILED at=
 660.<br />Hunk #3  succeeded at 778 with fuzz 2 (offset 78 lines).<br />1 =
out of 3 hunks FAILED --  saving rejects to file kernel/printk.c.rej<br />p=
atching file  kernel/sched.c<br />Hunk #1 succeeded at 741 with fuzz 1 (off=
set -777  lines).<br />Hunk #2 FAILED at 1143.<br />Hunk #3 FAILED at 1192.=
<br />Hunk #4  succeeded at 1409 with fuzz 2 (offset -2101 lines).<br />Hun=
k #5 FAILED at  1426.<br />Hunk #6 FAILED at 1538.<br />Hunk #7 FAILED at 1=
580.<br />Hunk #8 FAILED at  1609.<br />Hunk #9 FAILED at 2262.<br />Hunk #=
10 FAILED at 5318.<br />8 out of 10  hunks FAILED -- saving rejects to file=
 kernel/sched.c.rej<br />patching file  kernel/signal.c<br />Hunk #1 succee=
ded at 556 with fuzz 1 (offset 102  lines).<br />can't find file to patch a=
t input line 10667<br />Perhaps you used the  wrong -p or --strip option?<b=
r />The text leading up to this  was:<br />--------------------------<br />=
|diff --git a/kernel/spinlock.c  b/kernel/spinlock.c<br />|index cd72424..3=
e74c9b 100644<br />|---  a/kernel/spinlock.c<br />|+++  b/kernel/spinlock.c=
<br />--------------------------<br />No file to patch.&nbsp; Skipping  pat=
ch.<br />2 out of 2 hunks ignored<br />can't find file to patch at input li=
ne  10689<br />Perhaps you used the wrong -p or --strip option?<br />The te=
xt leading up  to this was:<br />--------------------------<br />|diff --gi=
t a/lib/Kconfig.debug  b/lib/Kconfig.debug<br />|index a601093..6372a6f 100=
644<br />|---  a/lib/Kconfig.debug<br />|+++  b/lib/Kconfig.debug<br />----=
----------------------<br />No file to patch.&nbsp; Skipping  patch.<br />1=
 out of 1 hunk ignored<br />patching file lib/bust_spinlocks.c<br />Hunk  #=
1 FAILED at 12.<br />1 out of 1 hunk FAILED -- saving rejects to file  lib/=
bust_spinlocks.c.rej<br />can't find file to patch at input line  10726<br =
/>Perhaps you used the wrong -p or --strip option?<br />The text leading up=
  to this was:<br />--------------------------<br />|diff --git a/lib/iorem=
ap.c  b/lib/ioremap.c<br />|index 14c6078..a275469 100644<br />|---  a/lib/=
ioremap.c<br />|+++ b/lib/ioremap.c<br />--------------------------<br />No=
 file  to patch.&nbsp; Skipping patch.<br />1 out of 1 hunk ignored<br />ca=
n't find file to  patch at input line 10741<br />Perhaps you used the wrong=
 -p or --strip  option?<br />The text leading up to this  was:<br />-------=
-------------------<br />|diff --git a/lib/smp_processor_id.c  b/lib/smp_pr=
ocessor_id.c<br />|index eddc9b3..66302ec 100644<br />|---  a/lib/smp_proce=
ssor_id.c<br />|+++  b/lib/smp_processor_id.c<br />------------------------=
--<br />No file to patch.&nbsp;  Skipping patch.<br />1 out of 1 hunk ignor=
ed<br />can't find file to patch at input  line 10760<br />Perhaps you used=
 the wrong -p or --strip option?<br />The text  leading up to this was:<br =
/>--------------------------<br />|diff --git  a/lib/spinlock_debug.c b/lib=
/spinlock_debug.c<br />|index 9c4b025..08f096b  100644<br />|--- a/lib/spin=
lock_debug.c<br />|+++  b/lib/spinlock_debug.c<br />-----------------------=
---<br />No file to patch.&nbsp;  Skipping patch.<br />6 out of 6 hunks ign=
ored<br />patching file mm/memory.c<br />Hunk  #1 FAILED at 50.<br />Hunk #=
2 succeeded at 609 with fuzz 2 (offset 193  lines).<br />Hunk #3 FAILED at =
645.<br />Hunk #4 FAILED at 685.<br />Hunk #5 FAILED at  730.<br />Hunk #6 =
FAILED at 772.<br />Hunk #7 FAILED at 1760.<br />Hunk #8 FAILED at  2992.<b=
r />7 out of 8 hunks FAILED -- saving rejects to file  mm/memory.c.rej<br /=
>patching file mm/mlock.c<br />Hunk #1 FAILED at 173.<br />1 out  of 1 hunk=
 FAILED -- saving rejects to file mm/mlock.c.rej<br />patching file  mm/vma=
lloc.c<br />Hunk #1 FAILED at 161.<br />1 out of 1 hunk FAILED -- saving  r=
ejects to file mm/vmalloc.c.rej<br />prepare-kernel.sh: Unable to patch ker=
nel  2.6.8.1 with<br />adeos-ipipe-2.6.24-arm-1.9-01.patch.<br /><a href=3D=
"mailto:kerhoas@domain.hid$">kerhoas@domain.hid=
sktop:/usr/src/xenomai-2.4.3$</a><br /><br /><br /><br /><br /> <BR><BR><i>=
Cr=C3=A9ez votre adresse =C3=A9lectronique <a target=3D_blank href=3Dhttp:/=
/www.laposte.net>pr=C3=A9nom.nom@domain.hid</a> <BR> 1 Go d'espace de stoc=
kage, anti-spam et anti-virus int=C3=A9gr=C3=A9s.</i><BR>
------=_Part_976722_3830122.1209713748046--



