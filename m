MIME-Version: 1.0
Date: Mon, 24 Sep 2012 15:33:48 +0200
Message-ID: <CANKLDmsUnaOGUb9KQf=c-68h1YHB7R=Uc-GvMzsJL_L1jG2cJw@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] No TSC in SMP on Intel Atom
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I'm currently doing some tests on an Intel ATOM D2700 and try to run
Xenomai threads on different cores. Currently using kernel 3.4.6,
x86-32 SMP, and Xenomai 2.6.1 SMP.

It seems the kernel detects the ATOM's TSC as unusable in SMP
configuration and switches to the jiffies clock. This because there is
an offset between both TSC counters of both cores. It seems even
though the CPU has constant_tsc and nonstop_tsc, there is no guarantee
for the counters to have the same value. I guess just the offset stays
the same.

My question is what are the implications for Xenomai not being able to
have a TSC in SMP configuration, as Xenomai heavily relies on the TSC?
Are there any known workarounds for synchronizing the TSC's so TSC can
be used on these older Intel architectures?
If not, what would be the best kernel/Xenomai
configuration/workarounds to get a stable system able to run Xenomai
threads on different cores?

Thanks,
Henri

root@target:~# dmesg -s 64000 | grep -i tsc
[    0.001000] Fast TSC calibration using PIT
[    0.285498] TSC synchronization [CPU#0 -> CPU#1]:
[    0.285762] Measured 14592832 cycles TSC warp between CPUs, turning
off TSC clock.
[    0.002999] Marking TSC unstable due to check_tsc_sync_source failed
root@target:~# cat
/sys/devices/system/clocksource/clocksource0/available_clocksource
jiffies tsc
root@target:~# cat
/sys/devices/system/clocksource/clocksource0/current_clocksource
jiffies

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 54
model name      : Intel(R) Atom(TM) CPU D2700   @ 2.13GHz
stepping        : 1
microcode       : 0x109
cpu MHz         : 2133.378
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
constant_tsc arch_perfmon pebs bts nonstop_tsc aperfmperf pni dtes64
monitor ds_cpl tm2 ssse3 xtpr pdcm movbe lahf_lm arat dts
bogomips        : 4266.75
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 32 bits virtual
power management:

