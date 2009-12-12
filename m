MIME-Version: 1.0
Date: Sat, 12 Dec 2009 11:16:27 +0800
Message-ID: <537fde640912111916n49dbee36x1eae81a21c633ad@domain.hid>
From: yy Hong <yaanhyy@domain.hid>
Content-Type: multipart/alternative; boundary=00504502ae3d4e039a047a7f774d
Subject: [Xenomai-help] xenomai-2.4.9 patch to kernel-2.6.29.4 with arch
	powerpc failed
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

--00504502ae3d4e039a047a7f774d
Content-Type: text/plain; charset=ISO-8859-1

Hi all:
    I download kernel and its patch from www.kernel.org.
then unzip kernel  and patch the kernel.
Then I use xenemai-2.4.9 to patch the kernel following the  README.INSTALL.

   But the patch was not applied correctly!
   I also test other kernel and xenomai version.
   such as kernel-2.6.30.10 & xenomai-2.4.10.But still fialed.
   I think I don't  patch xenomai to kernel in right way, can anyone help me
!
   Thanks a lot!
there was the following errors:
ithor@domain.hid$ scripts/prepare-kernel.sh
--linux=/home/ithor/linux-2.6.29.4
Target architecture [default i686]: powerpc
Adeos patch [default
/home/ithor/xenomai-2.4.9/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.29.4-powerpc-DENX-2.6-02.patch]:

patching file arch/powerpc/Kconfig
patching file arch/powerpc/boot/Makefile
patching file arch/powerpc/include/asm/exception.h
patching file arch/powerpc/include/asm/hw_irq.h
patching file arch/powerpc/include/asm/ipipe.h
patching file arch/powerpc/include/asm/ipipe_base.h
patching file arch/powerpc/include/asm/irqflags.h
patching file arch/powerpc/include/asm/mmu_context.h
patching file arch/powerpc/include/asm/mpic.h
patching file arch/powerpc/include/asm/paca.h
patching file arch/powerpc/include/asm/ptrace.h
patching file arch/powerpc/include/asm/qe_ic.h
patching file arch/powerpc/include/asm/reg.h
Hunk #1 succeeded at 766 (offset -3 lines).
patching file arch/powerpc/include/asm/smp.h
patching file arch/powerpc/include/asm/thread_info.h
Hunk #1 succeeded at 112 (offset -2 lines).
Hunk #2 succeeded at 131 (offset -2 lines).
patching file arch/powerpc/include/asm/time.h
patching file arch/powerpc/kernel/Makefile
patching file arch/powerpc/kernel/asm-offsets.c
patching file arch/powerpc/kernel/cputable.c
patching file arch/powerpc/kernel/entry_32.S
patching file arch/powerpc/kernel/entry_64.S
Hunk #7 succeeded at 548 (offset -4 lines).
Hunk #8 succeeded at 568 (offset -4 lines).
Hunk #9 succeeded at 606 (offset -4 lines).
Hunk #10 succeeded at 619 (offset -4 lines).
Hunk #11 succeeded at 731 (offset -4 lines).
Hunk #12 succeeded at 765 (offset -4 lines).
Hunk #13 succeeded at 830 (offset -4 lines).
Hunk #14 succeeded at 1024 (offset -4 lines).
Hunk #15 succeeded at 1049 (offset -4 lines).
patching file arch/powerpc/kernel/head_32.S
patching file arch/powerpc/kernel/head_40x.S
patching file arch/powerpc/kernel/head_44x.S
patching file arch/powerpc/kernel/head_64.S
Hunk #1 succeeded at 346 (offset -22 lines).
Hunk #2 succeeded at 363 (offset -22 lines).
Hunk #3 succeeded at 446 (offset -22 lines).
Hunk #4 succeeded at 685 (offset -22 lines).
Hunk #5 succeeded at 695 (offset -22 lines).
Hunk #6 succeeded at 735 (offset -22 lines).
Hunk #7 succeeded at 746 (offset -22 lines).
Hunk #8 succeeded at 758 (offset -22 lines).
Hunk #9 succeeded at 779 (offset -22 lines).
Hunk #10 succeeded at 814 (offset -22 lines).
Hunk #11 succeeded at 871 (offset -22 lines).
Hunk #12 succeeded at 1081 (offset -22 lines).
Hunk #13 succeeded at 1636 (offset -48 lines).
Hunk #14 succeeded at 1764 (offset -48 lines).
Hunk #15 succeeded at 1776 (offset -48 lines).
patching file arch/powerpc/kernel/head_8xx.S
patching file arch/powerpc/kernel/head_booke.h
Hunk #1 succeeded at 209 (offset -9 lines).
Hunk #2 succeeded at 379 (offset -9 lines).
Hunk #3 succeeded at 395 (offset -9 lines).
patching file arch/powerpc/kernel/head_fsl_booke.S
patching file arch/powerpc/kernel/idle.c
patching file arch/powerpc/kernel/idle_power4.S
patching file arch/powerpc/kernel/ipipe.c
patching file arch/powerpc/kernel/irq.c
patching file arch/powerpc/kernel/ppc_ksyms.c
patching file arch/powerpc/kernel/process.c
Hunk #3 succeeded at 400 (offset -4 lines).
Hunk #4 FAILED at 419.
Hunk #5 succeeded at 414 with fuzz 2 (offset -18 lines).
Hunk #6 succeeded at 1065 (offset -18 lines).
1 out of 6 hunks FAILED -- saving rejects to file
arch/powerpc/kernel/process.c.rej
patching file arch/powerpc/kernel/prom_init_check.sh
patching file arch/powerpc/kernel/setup_32.c
patching file arch/powerpc/kernel/setup_64.c
patching file arch/powerpc/kernel/smp.c
patching file arch/powerpc/kernel/time.c
Hunk #2 FAILED at 545.
Hunk #3 succeeded at 558 (offset -8 lines).
Hunk #4 succeeded at 601 (offset -8 lines).
1 out of 4 hunks FAILED -- saving rejects to file
arch/powerpc/kernel/time.c.rej
patching file arch/powerpc/kernel/traps.c
patching file arch/powerpc/lib/code-patching.c
patching file arch/powerpc/lib/feature-fixups.c
patching file arch/powerpc/mm/fault.c
patching file arch/powerpc/mm/hash_low_32.S
patching file arch/powerpc/mm/hash_native_64.c
Hunk #1 FAILED at 37.
Hunk #2 succeeded at 133 (offset -4 lines).
Hunk #3 succeeded at 142 (offset -4 lines).
Hunk #4 succeeded at 156 with fuzz 2 (offset -4 lines).
Hunk #5 succeeded at 178 (offset -10 lines).
Hunk #6 succeeded at 190 (offset -10 lines).
Hunk #7 succeeded at 217 (offset -10 lines).
Hunk #8 succeeded at 235 (offset -10 lines).
Hunk #9 succeeded at 243 (offset -10 lines).
Hunk #10 succeeded at 261 (offset -10 lines).
Hunk #11 succeeded at 333 (offset -10 lines).
1 out of 11 hunks FAILED -- saving rejects to file
arch/powerpc/mm/hash_native_64.c.rej
patching file arch/powerpc/mm/hash_utils_64.c
patching file arch/powerpc/mm/mmu_context_nohash.c
patching file arch/powerpc/mm/slb.c
Hunk #3 succeeded at 152 (offset -10 lines).
patching file arch/powerpc/mm/tlb_hash32.c
patching file arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
patching file arch/powerpc/platforms/85xx/tqm85xx.c
patching file arch/powerpc/platforms/cell/spu_base.c
patching file arch/powerpc/platforms/iseries/irq.c
patching file arch/powerpc/platforms/powermac/pic.c
patching file arch/powerpc/platforms/ps3/htab.c
patching file arch/powerpc/platforms/ps3/interrupt.c
patching file arch/powerpc/platforms/pseries/lpar.c
patching file arch/powerpc/sysdev/cpm2_pic.c
patching file arch/powerpc/sysdev/i8259.c
patching file arch/powerpc/sysdev/ipic.c
patching file arch/powerpc/sysdev/mpc8xx_pic.c
patching file arch/powerpc/sysdev/mpic.c
patching file arch/powerpc/sysdev/qe_lib/qe_ic.c
patching file arch/powerpc/sysdev/tsi108_pci.c
patching file arch/powerpc/sysdev/uic.c
patching file drivers/pci/htirq.c
patching file drivers/serial/8250.c
Hunk #1 succeeded at 2988 (offset -151 lines).
patching file include/asm-generic/cmpxchg-local.h
patching file include/asm-generic/percpu.h
patching file include/linux/hardirq.h
patching file include/linux/ipipe.h
patching file include/linux/ipipe_base.h
patching file include/linux/ipipe_compat.h
patching file include/linux/ipipe_percpu.h
patching file include/linux/ipipe_tickdev.h
patching file include/linux/ipipe_trace.h
patching file include/linux/irq.h
patching file include/linux/kernel.h
patching file include/linux/mm.h
patching file include/linux/preempt.h
patching file include/linux/sched.h
Hunk #4 succeeded at 1394 (offset -4 lines).
Hunk #5 succeeded at 1628 (offset -4 lines).
patching file include/linux/spinlock.h
patching file include/linux/spinlock_types.h
patching file init/Kconfig
Hunk #2 succeeded at 1065 (offset -12 lines).
patching file init/main.c
Hunk #1 succeeded at 542 (offset -1 lines).
Hunk #2 succeeded at 599 (offset -4 lines).
Hunk #3 succeeded at 771 (offset -4 lines).
patching file kernel/Makefile
patching file kernel/exit.c
patching file kernel/fork.c
Hunk #1 succeeded at 482 (offset -25 lines).
Hunk #2 succeeded at 882 (offset -25 lines).
Hunk #3 succeeded at 1263 (offset -25 lines).
patching file kernel/ipipe/Kconfig
patching file kernel/ipipe/Kconfig.debug
patching file kernel/ipipe/Makefile
patching file kernel/ipipe/core.c
patching file kernel/ipipe/tracer.c
patching file kernel/irq/chip.c
patching file kernel/irq/handle.c
patching file kernel/lockdep.c
patching file kernel/panic.c
patching file kernel/power/disk.c
patching file kernel/printk.c
Hunk #1 succeeded at 532 (offset -105 lines).
Hunk #2 succeeded at 591 (offset -105 lines).
Hunk #3 succeeded at 659 (offset -105 lines).
patching file kernel/sched.c
patching file kernel/signal.c
patching file kernel/spinlock.c
patching file kernel/time/tick-common.c
patching file kernel/time/tick-sched.c
patching file kernel/timer.c
patching file kernel/trace/Kconfig
patching file lib/Kconfig.debug
patching file lib/bust_spinlocks.c
patching file lib/ioremap.c
patching file lib/smp_processor_id.c
patching file lib/spinlock_debug.c
patching file mm/memory.c
patching file mm/mlock.c
patching file mm/vmalloc.c
prepare-kernel.sh: Unable to patch kernel 2.6.29.4 with
adeos-ipipe-2.6.29.4-powerpc-DENX-2.6-02.patch.

--00504502ae3d4e039a047a7f774d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi all:</div>
<div>=A0=A0=A0 I download kernel and its patch from <a href=3D"http://www.k=
ernel.org/">www.kernel.org</a>.<br>then unzip kernel=A0 and patch the kerne=
l.<br>Then I use xenemai-2.4.9 to patch the kernel following the=A0 README.=
INSTALL.</div>

<p>=A0=A0=A0But the patch was not applied correctly!<br>=A0=A0 I also test =
other kernel and xenomai version.<br>=A0=A0 such as kernel-2.6.30.10 &amp; =
xenomai-2.4.10.But still fialed.<br>=A0=A0=A0I think I don&#39;t=A0 patch x=
enomai to kernel in right way, can anyone help me !<br>
=A0=A0 Thanks a lot! <br>there was the following errors:<br><a href=3D"mail=
to:ithor@domain.hid$">ithor@domain.hid$</a> scripts=
/prepare-kernel.sh=A0 --linux=3D/home/ithor/linux-2.6.29.4<br>Target archit=
ecture [default i686]: powerpc<br>
Adeos patch [default /home/ithor/xenomai-2.4.9/ksrc/arch/powerpc/patches/ad=
eos-ipipe-2.6.29.4-powerpc-DENX-2.6-02.patch]: <br>patching file arch/power=
pc/Kconfig<br>patching file arch/powerpc/boot/Makefile<br>patching file arc=
h/powerpc/include/asm/exception.h<br>
patching file arch/powerpc/include/asm/hw_irq.h<br>patching file arch/power=
pc/include/asm/ipipe.h<br>patching file arch/powerpc/include/asm/ipipe_base=
.h<br>patching file arch/powerpc/include/asm/irqflags.h<br>patching file ar=
ch/powerpc/include/asm/mmu_context.h<br>
patching file arch/powerpc/include/asm/mpic.h<br>patching file arch/powerpc=
/include/asm/paca.h<br>patching file arch/powerpc/include/asm/ptrace.h<br>p=
atching file arch/powerpc/include/asm/qe_ic.h<br>patching file arch/powerpc=
/include/asm/reg.h<br>
Hunk #1 succeeded at 766 (offset -3 lines).<br>patching file arch/powerpc/i=
nclude/asm/smp.h<br>patching file arch/powerpc/include/asm/thread_info.h<br=
>Hunk #1 succeeded at 112 (offset -2 lines).<br>Hunk #2 succeeded at 131 (o=
ffset -2 lines).<br>
patching file arch/powerpc/include/asm/time.h<br>patching file arch/powerpc=
/kernel/Makefile<br>patching file arch/powerpc/kernel/asm-offsets.c<br>patc=
hing file arch/powerpc/kernel/cputable.c<br>patching file arch/powerpc/kern=
el/entry_32.S<br>
patching file arch/powerpc/kernel/entry_64.S<br>Hunk #7 succeeded at 548 (o=
ffset -4 lines).<br>Hunk #8 succeeded at 568 (offset -4 lines).<br>Hunk #9 =
succeeded at 606 (offset -4 lines).<br>Hunk #10 succeeded at 619 (offset -4=
 lines).<br>
Hunk #11 succeeded at 731 (offset -4 lines).<br>Hunk #12 succeeded at 765 (=
offset -4 lines).<br>Hunk #13 succeeded at 830 (offset -4 lines).<br>Hunk #=
14 succeeded at 1024 (offset -4 lines).<br>Hunk #15 succeeded at 1049 (offs=
et -4 lines).<br>
patching file arch/powerpc/kernel/head_32.S<br>patching file arch/powerpc/k=
ernel/head_40x.S<br>patching file arch/powerpc/kernel/head_44x.S<br>patchin=
g file arch/powerpc/kernel/head_64.S<br>Hunk #1 succeeded at 346 (offset -2=
2 lines).<br>
Hunk #2 succeeded at 363 (offset -22 lines).<br>Hunk #3 succeeded at 446 (o=
ffset -22 lines).<br>Hunk #4 succeeded at 685 (offset -22 lines).<br>Hunk #=
5 succeeded at 695 (offset -22 lines).<br>Hunk #6 succeeded at 735 (offset =
-22 lines).<br>
Hunk #7 succeeded at 746 (offset -22 lines).<br>Hunk #8 succeeded at 758 (o=
ffset -22 lines).<br>Hunk #9 succeeded at 779 (offset -22 lines).<br>Hunk #=
10 succeeded at 814 (offset -22 lines).<br>Hunk #11 succeeded at 871 (offse=
t -22 lines).<br>
Hunk #12 succeeded at 1081 (offset -22 lines).<br>Hunk #13 succeeded at 163=
6 (offset -48 lines).<br>Hunk #14 succeeded at 1764 (offset -48 lines).<br>=
Hunk #15 succeeded at 1776 (offset -48 lines).<br>patching file arch/powerp=
c/kernel/head_8xx.S<br>
patching file arch/powerpc/kernel/head_booke.h<br>Hunk #1 succeeded at 209 =
(offset -9 lines).<br>Hunk #2 succeeded at 379 (offset -9 lines).<br>Hunk #=
3 succeeded at 395 (offset -9 lines).<br>patching file arch/powerpc/kernel/=
head_fsl_booke.S<br>
patching file arch/powerpc/kernel/idle.c<br>patching file arch/powerpc/kern=
el/idle_power4.S<br>patching file arch/powerpc/kernel/ipipe.c<br>patching f=
ile arch/powerpc/kernel/irq.c<br>patching file arch/powerpc/kernel/ppc_ksym=
s.c<br>
patching file arch/powerpc/kernel/process.c<br>Hunk #3 succeeded at 400 (of=
fset -4 lines).<br>Hunk #4 FAILED at 419.<br>Hunk #5 succeeded at 414 with =
fuzz 2 (offset -18 lines).<br>Hunk #6 succeeded at 1065 (offset -18 lines).=
<br>
1 out of 6 hunks FAILED -- saving rejects to file arch/powerpc/kernel/proce=
ss.c.rej<br>patching file arch/powerpc/kernel/prom_init_check.sh<br>patchin=
g file arch/powerpc/kernel/setup_32.c<br>patching file arch/powerpc/kernel/=
setup_64.c<br>
patching file arch/powerpc/kernel/smp.c<br>patching file arch/powerpc/kerne=
l/time.c<br>Hunk #2 FAILED at 545.<br>Hunk #3 succeeded at 558 (offset -8 l=
ines).<br>Hunk #4 succeeded at 601 (offset -8 lines).<br>1 out of 4 hunks F=
AILED -- saving rejects to file arch/powerpc/kernel/time.c.rej<br>
patching file arch/powerpc/kernel/traps.c<br>patching file arch/powerpc/lib=
/code-patching.c<br>patching file arch/powerpc/lib/feature-fixups.c<br>patc=
hing file arch/powerpc/mm/fault.c<br>patching file arch/powerpc/mm/hash_low=
_32.S<br>
patching file arch/powerpc/mm/hash_native_64.c<br>Hunk #1 FAILED at 37.<br>=
Hunk #2 succeeded at 133 (offset -4 lines).<br>Hunk #3 succeeded at 142 (of=
fset -4 lines).<br>Hunk #4 succeeded at 156 with fuzz 2 (offset -4 lines).<=
br>
Hunk #5 succeeded at 178 (offset -10 lines).<br>Hunk #6 succeeded at 190 (o=
ffset -10 lines).<br>Hunk #7 succeeded at 217 (offset -10 lines).<br>Hunk #=
8 succeeded at 235 (offset -10 lines).<br>Hunk #9 succeeded at 243 (offset =
-10 lines).<br>
Hunk #10 succeeded at 261 (offset -10 lines).<br>Hunk #11 succeeded at 333 =
(offset -10 lines).<br>1 out of 11 hunks FAILED -- saving rejects to file a=
rch/powerpc/mm/hash_native_64.c.rej<br>patching file arch/powerpc/mm/hash_u=
tils_64.c<br>
patching file arch/powerpc/mm/mmu_context_nohash.c<br>patching file arch/po=
werpc/mm/slb.c<br>Hunk #3 succeeded at 152 (offset -10 lines).<br>patching =
file arch/powerpc/mm/tlb_hash32.c<br>patching file arch/powerpc/platforms/8=
2xx/pq2ads-pci-pic.c<br>
patching file arch/powerpc/platforms/85xx/tqm85xx.c<br>patching file arch/p=
owerpc/platforms/cell/spu_base.c<br>patching file arch/powerpc/platforms/is=
eries/irq.c<br>patching file arch/powerpc/platforms/powermac/pic.c<br>patch=
ing file arch/powerpc/platforms/ps3/htab.c<br>
patching file arch/powerpc/platforms/ps3/interrupt.c<br>patching file arch/=
powerpc/platforms/pseries/lpar.c<br>patching file arch/powerpc/sysdev/cpm2_=
pic.c<br>patching file arch/powerpc/sysdev/i8259.c<br>patching file arch/po=
werpc/sysdev/ipic.c<br>
patching file arch/powerpc/sysdev/mpc8xx_pic.c<br>patching file arch/powerp=
c/sysdev/mpic.c<br>patching file arch/powerpc/sysdev/qe_lib/qe_ic.c<br>patc=
hing file arch/powerpc/sysdev/tsi108_pci.c<br>patching file arch/powerpc/sy=
sdev/uic.c<br>
patching file drivers/pci/htirq.c<br>patching file drivers/serial/8250.c<br=
>Hunk #1 succeeded at 2988 (offset -151 lines).<br>patching file include/as=
m-generic/cmpxchg-local.h<br>patching file include/asm-generic/percpu.h<br>
patching file include/linux/hardirq.h<br>patching file include/linux/ipipe.=
h<br>patching file include/linux/ipipe_base.h<br>patching file include/linu=
x/ipipe_compat.h<br>patching file include/linux/ipipe_percpu.h<br>patching =
file include/linux/ipipe_tickdev.h<br>
patching file include/linux/ipipe_trace.h<br>patching file include/linux/ir=
q.h<br>patching file include/linux/kernel.h<br>patching file include/linux/=
mm.h<br>patching file include/linux/preempt.h<br>patching file include/linu=
x/sched.h<br>
Hunk #4 succeeded at 1394 (offset -4 lines).<br>Hunk #5 succeeded at 1628 (=
offset -4 lines).<br>patching file include/linux/spinlock.h<br>patching fil=
e include/linux/spinlock_types.h<br>patching file init/Kconfig<br>Hunk #2 s=
ucceeded at 1065 (offset -12 lines).<br>
patching file init/main.c<br>Hunk #1 succeeded at 542 (offset -1 lines).<br=
>Hunk #2 succeeded at 599 (offset -4 lines).<br>Hunk #3 succeeded at 771 (o=
ffset -4 lines).<br>patching file kernel/Makefile<br>patching file kernel/e=
xit.c<br>
patching file kernel/fork.c<br>Hunk #1 succeeded at 482 (offset -25 lines).=
<br>Hunk #2 succeeded at 882 (offset -25 lines).<br>Hunk #3 succeeded at 12=
63 (offset -25 lines).<br>patching file kernel/ipipe/Kconfig<br>patching fi=
le kernel/ipipe/Kconfig.debug<br>
patching file kernel/ipipe/Makefile<br>patching file kernel/ipipe/core.c<br=
>patching file kernel/ipipe/tracer.c<br>patching file kernel/irq/chip.c<br>=
patching file kernel/irq/handle.c<br>patching file kernel/lockdep.c<br>
patching file kernel/panic.c<br>patching file kernel/power/disk.c<br>patchi=
ng file kernel/printk.c<br>Hunk #1 succeeded at 532 (offset -105 lines).<br=
>Hunk #2 succeeded at 591 (offset -105 lines).<br>Hunk #3 succeeded at 659 =
(offset -105 lines).<br>
patching file kernel/sched.c<br>patching file kernel/signal.c<br>patching f=
ile kernel/spinlock.c<br>patching file kernel/time/tick-common.c<br>patchin=
g file kernel/time/tick-sched.c<br>patching file kernel/timer.c<br>patching=
 file kernel/trace/Kconfig<br>
patching file lib/Kconfig.debug<br>patching file lib/bust_spinlocks.c<br>pa=
tching file lib/ioremap.c<br>patching file lib/smp_processor_id.c<br>patchi=
ng file lib/spinlock_debug.c<br>patching file mm/memory.c<br>patching file =
mm/mlock.c<br>
patching file mm/vmalloc.c<br>prepare-kernel.sh: Unable to patch kernel 2.6=
.29.4 with adeos-ipipe-2.6.29.4-powerpc-DENX-2.6-02.patch.</p>

--00504502ae3d4e039a047a7f774d--

