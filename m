Message-ID: <1342097120.22964.YahooMailNeo@web120604.mail.ne1.yahoo.com>
Date: Thu, 12 Jul 2012 05:45:20 -0700 (PDT)
From: Jignesh Patel <jigneshj.patel@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai 2.6.0 installation Error
Reply-To: Jignesh Patel <jigneshj.patel@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "rgupta108@gmail.com" <rgupta108@gmail.com>, "patelilesh32@gmail.com" <patelilesh32@gmail.com>

=0AHi,=0A=0AI am trying to=A0=A0installed Xenomai 2.6.0 into my desktop wit=
h my existing Linux Ubuntu(10.04 LTS) kernel 2.6.32-generic,for development=
 of real time data network.=0A=0ABelow Error occurs during installing of Xe=
nomai 2.6.0:=0A=0Aroot@new-desktop:~/xenomai-2.6.0# ./scripts/prepare-kerne=
l.sh --linux=3D/home/new/ilesh/kernel_2_6_32/linux-2.6.32 --verbose=0ATarge=
t architecture [default i686]:=0Aprepare-kernel.sh: no default Adeos patch =
found.=0AAdeos patch [default /dev/null]:=A0=A0/root/xenomai-2.6.0/ksrc/arc=
h/x86/patches/adeos-ipipe-2.6.37.6-x86-2.9-02.patch=0Apatching file arch/x8=
6/Kconfig=0AHunk #1 succeeded at 18 (offset 3 lines).=0AHunk #2 succeeded a=
t 133 (offset -21 lines).=0AHunk #4 succeeded at 533 (offset 19 lines).=0AH=
unk #5 succeeded at 753 (offset -3 lines).=0Apatching file arch/x86/include=
/asm/apic.h=0AHunk #1 succeeded at 404 with fuzz 2 (offset -9 lines).=0Apat=
ching file arch/x86/include/asm/apicdef.h=0AHunk #1 succeeded at 143 (offse=
t -7 lines).=0AHunk #2 succeeded at 419 (offset -7 lines).=0Apatching file =
arch/x86/include/asm/entry_arch.h=0AHunk #1 FAILED at 16.=0A1 out of 1 hunk=
 FAILED -- saving rejects to file arch/x86/include/asm/entry_arch.h.rej=0Ap=
atching file arch/x86/include/asm/hw_irq.h=0AHunk #2 succeeded at 110 with =
fuzz 2 (offset -21 lines).=0AHunk #3 succeeded at 123 (offset -21 lines).=
=0Apatching file arch/x86/include/asm/i387.h=0AHunk #1 succeeded at 289 (of=
fset 3 lines).=0Apatching file arch/x86/include/asm/i8259.h=0AHunk #1 FAILE=
D at 24.=0A1 out of 1 hunk FAILED -- saving rejects to file arch/x86/includ=
e/asm/i8259.h.rej=0Apatching file arch/x86/include/asm/ipi.h=0Apatching fil=
e arch/x86/include/asm/ipipe.h=0Apatching file arch/x86/include/asm/ipipe_3=
2.h=0Apatching file arch/x86/include/asm/ipipe_64.h=0Apatching file arch/x8=
6/include/asm/ipipe_base.h=0Apatching file arch/x86/include/asm/irq_vectors=
.h=0AHunk #1 succeeded at 91 (offset -5 lines).=0AHunk #2 succeeded at 122 =
with fuzz 2 (offset -5 lines).=0Apatching file arch/x86/include/asm/irqflag=
s.h=0AHunk #3 FAILED at 75.=0AHunk #4 succeeded at 123 with fuzz 2.=0AHunk =
#6 succeeded at 170 (offset 2 lines).=0AHunk #7 succeeded at 234 with fuzz =
1 (offset 8 lines).=0AHunk #8 succeeded at 326 (offset 8 lines).=0AHunk #9 =
succeeded at 338 (offset 8 lines).=0A1 out of 9 hunks FAILED -- saving reje=
cts to file arch/x86/include/asm/irqflags.h.rej=0Apatching file arch/x86/in=
clude/asm/mmu_context.h=0AHunk #1 succeeded at 30 with fuzz 2.=0AHunk #2 su=
cceeded at 73 (offset -1 lines).=0Apatching file arch/x86/include/asm/nmi.h=
=0AHunk #1 succeeded at 29 (offset -1 lines).=0Apatching file arch/x86/incl=
ude/asm/processor.h=0AHunk #1 succeeded at 435 (offset -5 lines).=0Apatchin=
g file arch/x86/include/asm/system.h=0AHunk #1 FAILED at 127.=0AHunk #2 suc=
ceeded at 145 (offset 1 line).=0AHunk #3 succeeded at 310 (offset -2 lines)=
.=0A1 out of 3 hunks FAILED -- saving rejects to file arch/x86/include/asm/=
system.h.rej=0Apatching file arch/x86/include/asm/traps.h=0AHunk #1 succeed=
ed at 82 with fuzz 1.=0Apatching file arch/x86/include/asm/tsc.h=0Apatching=
 file arch/x86/kernel/Makefile=0AHunk #1 succeeded at 62 (offset -1 lines).=
=0Apatching file arch/x86/kernel/apic/apic.c=0AHunk #1 succeeded at 446 (of=
fset -29 lines).=0AHunk #2 succeeded at 466 (offset -29 lines).=0AHunk #3 s=
ucceeded at 982 (offset -29 lines).=0AHunk #4 succeeded at 992 (offset -29 =
lines).=0AHunk #5 succeeded at 1166 (offset -29 lines).=0AHunk #6 FAILED at=
 1243.=0AHunk #7 succeeded at 1741 (offset -55 lines).=0AHunk #8 succeeded =
at 2022 (offset -43 lines).=0AHunk #9 succeeded at 2043 (offset -43 lines).=
=0AHunk #10 succeeded at 2109 (offset -43 lines).=0A1 out of 10 hunks FAILE=
D -- saving rejects to file arch/x86/kernel/apic/apic.c.rej=0Apatching file=
 arch/x86/kernel/apic/apic_flat_64.c=0Apatching file arch/x86/kernel/apic/i=
o_apic.c=0AHunk #1 FAILED at 74.=0AHunk #2 succeeded at 417 (offset 108 lin=
es).=0AHunk #3 succeeded at 442 (offset 108 lines).=0AHunk #4 FAILED at 607=
.=0AHunk #5 FAILED at 632.=0AHunk #6 FAILED at 1313.=0AHunk #7 FAILED at 22=
44.=0AHunk #8 FAILED at 2498.=0AHunk #9 FAILED at 2528.=0AHunk #10 FAILED a=
t 2691.=0AHunk #11 FAILED at 2736.=0AHunk #12 FAILED at 2753.=0AHunk #13 FA=
ILED at 2800.=0AHunk #14 FAILED at 2830.=0AHunk #15 FAILED at 3018.=0AHunk =
#16 FAILED at 3079.=0AHunk #17 FAILED at 3467.=0AHunk #18 FAILED at 3482.=
=0AHunk #19 FAILED at 3786.=0AHunk #20 succeeded at 4137 (offset 155 lines)=
.=0A17 out of 20 hunks FAILED -- saving rejects to file arch/x86/kernel/api=
c/io_apic.c.rej=0Apatching file arch/x86/kernel/apic/ipi.c=0Apatching file =
arch/x86/kernel/apic/nmi.c=0AHunk #1 succeeded at 59 (offset -2 lines).=0AH=
unk #2 succeeded at 391 (offset -2 lines).=0Apatching file arch/x86/kernel/=
apic/x2apic_cluster.c=0Apatching file arch/x86/kernel/apic/x2apic_phys.c=0A=
patching file arch/x86/kernel/cpu/mtrr/cyrix.c=0AHunk #7 succeeded at 270 w=
ith fuzz 1.=0Apatching file arch/x86/kernel/cpu/mtrr/generic.c=0AHunk #1 su=
cceeded at 635 (offset -82 lines).=0AHunk #2 succeeded at 645 (offset -82 l=
ines).=0AHunk #3 succeeded at 669 (offset -82 lines).=0AHunk #4 succeeded a=
t 695 (offset -82 lines).=0Apatching file arch/x86/kernel/dumpstack.c=0AHun=
k #1 succeeded at 327 (offset -22 lines).=0Apatching file arch/x86/kernel/d=
umpstack_32.c=0AHunk #1 succeeded at 108 (offset 7 lines).=0Apatching file =
arch/x86/kernel/dumpstack_64.c=0AHunk #1 succeeded at 254 with fuzz 2 (offs=
et -39 lines).=0Apatching file arch/x86/kernel/entry_32.S=0AHunk #2 succeed=
ed at 80 (offset -1 lines).=0AHunk #3 succeeded at 371 with fuzz 2 (offset =
22 lines).=0AHunk #4 succeeded at 399 (offset 22 lines).=0AHunk #5 succeede=
d at 432 (offset 22 lines).=0AHunk #6 succeeded at 494 (offset 24 lines).=
=0AHunk #7 succeeded at 503 (offset 24 lines).=0AHunk #8 succeeded at 576 w=
ith fuzz 1 (offset 22 lines).=0AHunk #9 succeeded at 616 (offset 23 lines).=
=0AHunk #10 succeeded at 684 (offset 25 lines).=0AHunk #11 succeeded at 700=
 (offset 25 lines).=0AHunk #12 succeeded at 858 (offset -20 lines).=0AHunk =
#13 FAILED at 934.=0AHunk #14 FAILED at 952.=0AHunk #15 FAILED at 963.=0AHu=
nk #16 FAILED at 976.=0AHunk #17 FAILED at 999.=0AHunk #18 FAILED at 1007.=
=0AHunk #19 FAILED at 1015.=0AHunk #20 FAILED at 1023.=0AHunk #21 FAILED at=
 1059.=0AHunk #22 FAILED at 1068.=0AHunk #23 FAILED at 1077.=0AHunk #24 FAI=
LED at 1307.=0AHunk #25 succeeded at 1362 (offset -2 lines).=0AHunk #26 suc=
ceeded at 1410 with fuzz 1 (offset 2 lines).=0AHunk #27 succeeded at 1511 w=
ith fuzz 1 (offset 12 lines).=0AHunk #28 FAILED at 1521.=0A13 out of 28 hun=
ks FAILED -- saving rejects to file arch/x86/kernel/entry_32.S.rej=0Apatchi=
ng file arch/x86/kernel/entry_64.S=0AHunk #3 succeeded at 344 (offset 5 lin=
es).=0AHunk #4 FAILED at 412.=0AHunk #5 succeeded at 489 (offset 6 lines).=
=0AHunk #6 succeeded at 529 (offset 6 lines).=0AHunk #7 succeeded at 541 (o=
ffset 6 lines).=0AHunk #8 succeeded at 554 with fuzz 1 (offset 8 lines).=0A=
Hunk #9 succeeded at 836 with fuzz 1 (offset 14 lines).=0AHunk #10 succeede=
d at 867 (offset 10 lines).=0AHunk #11 succeeded at 893 with fuzz 1 (offset=
 9 lines).=0AHunk #12 succeeded at 913 (offset 9 lines).=0AHunk #13 succeed=
ed at 1008 (offset 11 lines).=0AHunk #14 FAILED at 1034.=0AHunk #15 FAILED =
at 1072.=0AHunk #16 succeeded at 1123 (offset 20 lines).=0AHunk #17 succeed=
ed at 1134 (offset 20 lines).=0AHunk #18 FAILED at 1163.=0AHunk #19 FAILED =
at 1198.=0AHunk #20 succeeded at 1231 (offset 20 lines).=0AHunk #21 succeed=
ed at 1263 (offset 20 lines).=0AHunk #22 FAILED at 1380.=0AHunk #23 succeed=
ed at 1546 (offset 62 lines).=0AHunk #24 succeeded at 1578 with fuzz 1 (off=
set 62 lines).=0AHunk #25 succeeded at 1655 with fuzz 2 (offset 62 lines).=
=0A6 out of 25 hunks FAILED -- saving rejects to file arch/x86/kernel/entry=
_64.S.rej=0Apatching file arch/x86/kernel/i8253.c=0AHunk #2 FAILED at 131.=
=0A1 out of 2 hunks FAILED -- saving rejects to file arch/x86/kernel/i8253.=
c.rej=0Apatching file arch/x86/kernel/i8259.c=0AHunk #1 FAILED at 32.=0AHun=
k #2 FAILED at 60.=0AHunk #3 FAILED at 76.=0AHunk #4 succeeded at 172 (offs=
et -2 lines).=0A3 out of 4 hunks FAILED -- saving rejects to file arch/x86/=
kernel/i8259.c.rej=0Apatching file arch/x86/kernel/ipipe.c=0Apatching file =
arch/x86/kernel/irq.c=0Apatching file arch/x86/kernel/irqinit.c=0AHunk #1 s=
ucceeded at 159 (offset -8 lines).=0AHunk #2 succeeded at 180 (offset -8 li=
nes).=0AHunk #3 succeeded at 218 with fuzz 1 (offset -8 lines).=0Apatching =
file arch/x86/kernel/process.c=0AHunk #1 FAILED at 42.=0AHunk #2 succeeded =
at 69 (offset -2 lines).=0AHunk #3 succeeded at 333 (offset -88 lines).=0AH=
unk #4 succeeded at 542 with fuzz 1 (offset -72 lines).=0AHunk #5 succeeded=
 at 556 (offset -72 lines).=0A1 out of 5 hunks FAILED -- saving rejects to =
file arch/x86/kernel/process.c.rej=0Apatching file arch/x86/kernel/process_=
32.c=0AHunk #1 succeeded at 305 (offset 49 lines).=0AHunk #2 succeeded at 3=
47 (offset 49 lines).=0Apatching file arch/x86/kernel/process_64.c=0AHunk #=
1 succeeded at 60 with fuzz 2 (offset 2 lines).=0AHunk #2 succeeded at 294 =
(offset 15 lines).=0AHunk #3 succeeded at 361 with fuzz 2 (offset 15 lines)=
.=0AHunk #4 succeeded at 385 (offset 1 line).=0Apatching file arch/x86/kern=
el/ptrace.c=0AHunk #1 FAILED at 19.=0AHunk #2 FAILED at 1397.=0A2 out of 2 =
hunks FAILED -- saving rejects to file arch/x86/kernel/ptrace.c.rej=0Apatch=
ing file arch/x86/kernel/smp.c=0AHunk #1 succeeded at 184 (offset -4 lines)=
.=0Apatching file arch/x86/kernel/smpboot.c=0AHunk #1 succeeded at 266 (off=
set -26 lines).=0AHunk #2 succeeded at 837 (offset -60 lines).=0AHunk #3 su=
cceeded at 889 (offset -47 lines).=0Apatching file arch/x86/kernel/time.c=
=0AHunk #2 FAILED at 72.=0A1 out of 2 hunks FAILED -- saving rejects to fil=
e arch/x86/kernel/time.c.rej=0Apatching file arch/x86/kernel/traps.c=0AHunk=
 #1 succeeded at 805 (offset 72 lines).=0AHunk #2 succeeded at 828 (offset =
72 lines).=0AHunk #3 succeeded at 845 (offset 72 lines).=0Apatching file ar=
ch/x86/kernel/tsc.c=0AHunk #1 succeeded at 405 (offset -4 lines).=0AHunk #2=
 succeeded at 450 (offset -4 lines).=0AHunk #3 succeeded at 699 (offset -42=
 lines).=0AHunk #4 succeeded at 745 (offset -42 lines).=0Apatching file arc=
h/x86/kernel/vm86_32.c=0AHunk #2 succeeded at 326 (offset 1 line).=0Apatchi=
ng file arch/x86/kernel/vsyscall_64.c=0AHunk #2 succeeded at 90 with fuzz 1=
 (offset -1 lines).=0Apatching file arch/x86/lib/mmx_32.c=0Apatching file a=
rch/x86/lib/thunk_64.S=0Apatching file arch/x86/mm/fault.c=0AHunk #1 FAILED=
 at 352.=0AHunk #2 succeeded at 373 (offset 3 lines).=0AHunk #3 succeeded a=
t 420 (offset 3 lines).=0AHunk #4 succeeded at 963 (offset -15 lines).=0AHu=
nk #5 succeeded at 1145 (offset -27 lines).=0A1 out of 5 hunks FAILED -- sa=
ving rejects to file arch/x86/mm/fault.c.rej=0Apatching file arch/x86/mm/tl=
b.c=0AHunk #1 succeeded at 57 (offset -4 lines).=0AHunk #2 succeeded at 196=
 (offset -4 lines).=0Acan't find file to patch at input line 4551=0APerhaps=
 you used the wrong -p or --strip option?=0AThe text leading up to this was=
:=0A--------------------------=0A|diff --git a/arch/x86/platform/uv/tlb_uv.=
c b/arch/x86/platform/uv/tlb_uv.c=0A|index df58e9c..2999465 100644=0A|--- a=
/arch/x86/platform/uv/tlb_uv.c=0A|+++ b/arch/x86/platform/uv/tlb_uv.c=0A---=
-----------------------=0ANo file to patch.=A0=A0Skipping patch.=0A1 out of=
 1 hunk ignored=0Apatching file drivers/pci/htirq.c=0AHunk #1 succeeded at =
21 (offset 1 line).=0Apatching file fs/exec.c=0AHunk #1 succeeded at 699 (o=
ffset -72 lines).=0AHunk #2 FAILED at 723.=0A1 out of 2 hunks FAILED -- sav=
ing rejects to file fs/exec.c.rej=0Apatching file fs/proc/array.c=0AHunk #1=
 FAILED at 142.=0A1 out of 1 hunk FAILED -- saving rejects to file fs/proc/=
array.c.rej=0Apatching file include/asm-generic/atomic.h=0AHunk #1 FAILED a=
t 58.=0AHunk #2 FAILED at 79.=0AHunk #3 FAILED at 145.=0A3 out of 3 hunks F=
AILED -- saving rejects to file include/asm-generic/atomic.h.rej=0Apatching=
 file include/asm-generic/bitops/atomic.h=0AHunk #1 FAILED at 21.=0A1 out o=
f 1 hunk FAILED -- saving rejects to file include/asm-generic/bitops/atomic=
.h.rej=0Apatching file include/asm-generic/cmpxchg-local.h=0AHunk #1 succee=
ded at 20 (offset -1 lines).=0AHunk #2 succeeded at 41 (offset -1 lines).=
=0AHunk #3 succeeded at 54 (offset -1 lines).=0Apatching file include/asm-g=
eneric/percpu.h=0AHunk #1 FAILED at 67.=0AHunk #2 FAILED at 96.=0A2 out of =
2 hunks FAILED -- saving rejects to file include/asm-generic/percpu.h.rej=
=0Apatching file include/linux/hardirq.h=0AHunk #1 succeeded at 185 (offset=
 -32 lines).=0AHunk #2 succeeded at 202 (offset -32 lines).=0Apatching file=
 include/linux/ipipe.h=0Apatching file include/linux/ipipe_base.h=0Apatchin=
g file include/linux/ipipe_lock.h=0Apatching file include/linux/ipipe_percp=
u.h=0Apatching file include/linux/ipipe_tickdev.h=0Apatching file include/l=
inux/ipipe_trace.h=0Apatching file include/linux/irq.h=0AHunk #1 FAILED at =
194.=0A1 out of 1 hunk FAILED -- saving rejects to file include/linux/irq.h=
.rej=0Acan't find file to patch at input line 6193=0APerhaps you used the w=
rong -p or --strip option?=0AThe text leading up to this was:=0A-----------=
---------------=0A|diff --git a/include/linux/irqdesc.h b/include/linux/irq=
desc.h=0A|index 979c68c..ee39a3e 100644=0A|--- a/include/linux/irqdesc.h=0A=
|+++ b/include/linux/irqdesc.h=0A--------------------------=0ANo file to pa=
tch.=A0=A0Skipping patch.=0A3 out of 3 hunks ignored=0Apatching file includ=
e/linux/kernel.h=0AHunk #1 succeeded at 14 with fuzz 2 (offset -2 lines).=
=0AHunk #2 succeeded at 120 (offset 5 lines).=0Apatching file include/linux=
/preempt.h=0Acan't find file to patch at input line 6283=0APerhaps you used=
 the wrong -p or --strip option?=0AThe text leading up to this was:=0A-----=
---------------------=0A|diff --git a/include/linux/rwlock.h b/include/linu=
x/rwlock.h=0A|index bc2994e..5e2da8d 100644=0A|--- a/include/linux/rwlock.h=
=0A|+++ b/include/linux/rwlock.h=0A--------------------------=0ANo file to =
patch.=A0=A0Skipping patch.=0A2 out of 2 hunks ignored=0Acan't find file to=
 patch at input line 6309=0APerhaps you used the wrong -p or --strip option=
?=0AThe text leading up to this was:=0A--------------------------=0A|diff -=
-git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h=0A|i=
ndex 9c9f049..62c8941 100644=0A|--- a/include/linux/rwlock_api_smp.h=0A|+++=
 b/include/linux/rwlock_api_smp.h=0A--------------------------=0ANo file to=
 patch.=A0=A0Skipping patch.=0A1 out of 1 hunk ignored=0Apatching file incl=
ude/linux/sched.h=0AHunk #2 FAILED at 192.=0AHunk #3 succeeded at 311 with =
fuzz 1 (offset -3 lines).=0AHunk #4 FAILED at 370.=0AHunk #5 succeeded at 4=
93 (offset 44 lines).=0AHunk #6 succeeded at 1514 (offset 34 lines).=0AHunk=
 #7 succeeded at 1785 (offset 29 lines).=0A2 out of 7 hunks FAILED -- savin=
g rejects to file include/linux/sched.h.rej=0Apatching file include/linux/s=
pinlock.h=0AHunk #1 FAILED at 89.=0AHunk #2 FAILED at 102.=0AHunk #3 FAILED=
 at 168.=0AHunk #4 FAILED at 190.=0AHunk #5 FAILED at 212.=0AHunk #6 FAILED=
 at 223.=0AHunk #7 FAILED at 293.=0AHunk #8 FAILED at 315.=0AHunk #9 FAILED=
 at 327.=0A9 out of 9 hunks FAILED -- saving rejects to file include/linux/=
spinlock.h.rej=0Apatching file include/linux/spinlock_api_smp.h=0AHunk #1 s=
ucceeded at 229 with fuzz 2 (offset 130 lines).=0AHunk #2 FAILED at 245.=0A=
1 out of 2 hunks FAILED -- saving rejects to file include/linux/spinlock_ap=
i_smp.h.rej=0Apatching file include/linux/spinlock_up.h=0AHunk #1 FAILED at=
 49.=0AHunk #2 FAILED at 58.=0A2 out of 2 hunks FAILED -- saving rejects to=
 file include/linux/spinlock_up.h.rej=0Apatching file init/Kconfig=0AHunk #=
1 succeeded at 78 (offset -15 lines).=0Apatching file init/main.c=0AHunk #1=
 succeeded at 535 with fuzz 2 (offset -17 lines).=0AHunk #2 succeeded at 57=
0 (offset -15 lines).=0AHunk #3 succeeded at 599 (offset -16 lines).=0AHunk=
 #4 succeeded at 785 (offset -15 lines).=0Apatching file kernel/Makefile=0A=
Hunk #1 succeeded at 83 with fuzz 2 (offset -5 lines).=0Apatching file kern=
el/exit.c=0AHunk #1 succeeded at 963 (offset -26 lines).=0Apatching file ke=
rnel/fork.c=0AHunk #1 succeeded at 511 (offset -32 lines).=0AHunk #3 succee=
ded at 1305 (offset 9 lines).=0AHunk #4 FAILED at 1716.=0A1 out of 4 hunks =
FAILED -- saving rejects to file kernel/fork.c.rej=0Apatching file kernel/i=
pipe/Kconfig=0Apatching file kernel/ipipe/Kconfig.debug=0Apatching file ker=
nel/ipipe/Makefile=0Apatching file kernel/ipipe/core.c=0Apatching file kern=
el/ipipe/tracer.c=0Apatching file kernel/irq/chip.c=0AHunk #2 FAILED at 506=
.=0AHunk #3 FAILED at 585.=0AHunk #4 FAILED at 633.=0AHunk #5 FAILED at 688=
.=0AHunk #6 succeeded at 626 with fuzz 1 (offset -75 lines).=0AHunk #7 succ=
eeded at 786 with fuzz 2 (offset -75 lines).=0A4 out of 7 hunks FAILED -- s=
aving rejects to file kernel/irq/chip.c.rej=0Apatching file kernel/irq/hand=
le.c=0AHunk #1 FAILED at 150.=0AHunk #2 FAILED at 164.=0A2 out of 2 hunks F=
AILED -- saving rejects to file kernel/irq/handle.c.rej=0Apatching file ker=
nel/lockdep.c=0AHunk #1 succeeded at 2318 (offset -16 lines).=0AHunk #2 suc=
ceeded at 2361 (offset -16 lines).=0AHunk #3 succeeded at 2393 (offset -16 =
lines).=0AHunk #4 succeeded at 2427 (offset -16 lines).=0Apatching file ker=
nel/panic.c=0AHunk #1 succeeded at 22 with fuzz 2 (offset -1 lines).=0AHunk=
 #2 succeeded at 305 (offset -14 lines).=0Apatching file kernel/power/hiber=
nate.c=0AHunk #1 succeeded at 238 (offset -32 lines).=0AHunk #2 succeeded a=
t 268 (offset -34 lines).=0AHunk #3 succeeded at 361 (offset -42 lines).=0A=
Hunk #4 succeeded at 393 (offset -42 lines).=0AHunk #5 succeeded at 475 wit=
h fuzz 2 (offset -44 lines).=0Apatching file kernel/printk.c=0AHunk #1 succ=
eeded at 564 (offset -33 lines).=0AHunk #2 succeeded at 623 (offset -33 lin=
es).=0AHunk #3 succeeded at 691 (offset -41 lines).=0Apatching file kernel/=
sched.c=0AHunk #1 FAILED at 2561.=0AHunk #2 succeeded at 2826 (offset -209 =
lines).=0AHunk #3 succeeded at 2876 (offset -209 lines).=0AHunk #4 succeede=
d at 5275 (offset 1321 lines).=0AHunk #5 succeeded at 5298 (offset 1321 lin=
es).=0AHunk #6 succeeded at 5347 (offset 1321 lines).=0AHunk #7 succeeded a=
t 5426 (offset 1342 lines).=0AHunk #8 succeeded at 5441 with fuzz 2 (offset=
 1343 lines).=0AHunk #9 succeeded at 5481 with fuzz 2 (offset 1328 lines).=
=0AHunk #10 FAILED at 5491.=0AHunk #11 succeeded at 5502 (offset 1326 lines=
).=0AHunk #12 FAILED at 5595.=0AHunk #13 succeeded at 6357 with fuzz 2 (off=
set 1296 lines).=0AHunk #14 succeeded at 7006 (offset 1276 lines).=0AHunk #=
15 succeeded at 10938 (offset 1288 lines).=0A3 out of 15 hunks FAILED -- sa=
ving rejects to file kernel/sched.c.rej=0Apatching file kernel/signal.c=0AH=
unk #1 succeeded at 518 (offset -40 lines).=0Apatching file kernel/spinlock=
.c=0AHunk #1 FAILED at 26.=0A1 out of 1 hunk FAILED -- saving rejects to fi=
le kernel/spinlock.c.rej=0Apatching file kernel/time/tick-common.c=0AHunk #=
1 succeeded at 69 (offset -4 lines).=0AHunk #2 succeeded at 177 (offset -4 =
lines).=0Apatching file kernel/time/tick-sched.c=0AHunk #1 succeeded at 525=
 (offset -73 lines).=0AHunk #2 succeeded at 676 (offset -82 lines).=0Apatch=
ing file kernel/timer.c=0AHunk #1 succeeded at 1204 (offset -89 lines).=0Ap=
atching file kernel/trace/ftrace.c=0AHunk #1 FAILED at 29.=0AHunk #2 succee=
ded at 1143 (offset -14 lines).=0AHunk #3 succeeded at 1153 (offset -14 lin=
es).=0AHunk #4 succeeded at 2658 (offset -74 lines).=0AHunk #5 succeeded at=
 2739 (offset -74 lines).=0A1 out of 5 hunks FAILED -- saving rejects to fi=
le kernel/trace/ftrace.c.rej=0Apatching file lib/Kconfig.debug=0Apatching f=
ile lib/bust_spinlocks.c=0Apatching file lib/ioremap.c=0Apatching file lib/=
smp_processor_id.c=0Apatching file mm/memory.c=0AHunk #1 succeeded at 566 (=
offset -74 lines).=0AHunk #2 succeeded at 600 with fuzz 2 (offset -74 lines=
).=0AHunk #3 succeeded at 640 (offset -78 lines).=0AHunk #4 FAILED at 692.=
=0AHunk #5 FAILED at 735.=0AHunk #6 FAILED at 2055.=0AHunk #7 succeeded at =
3423 (offset -233 lines).=0A3 out of 7 hunks FAILED -- saving rejects to fi=
le mm/memory.c.rej=0Apatching file mm/mmu_context.c=0AHunk #1 succeeded at =
23 (offset -1 lines).=0Apatching file mm/vmalloc.c=0AHunk #1 succeeded at 1=
72 (offset 1 line).=0Aprepare-kernel.sh: Unable to patch kernel 2.6.32 with=
 adeos-ipipe-2.6.37.6-x86-2.9-02.patch.=0A=A0=A0=0A=0APlease give me a solu=
tion for removing above error and how can I install correct Xenomai 2.6.0 w=
ith my=A0existing=A0Ubuntu=A0Linux=A0kernel.--=A0=0A=0AThanks & Regards,=0A=
=0AJignesh J. Patel=0A+91 9998651686
