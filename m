From: "Heinick, J Michael" <Michael.Heinick@Honeywell.com>
Date: Wed, 8 Jun 2016 09:42:26 +0000
Message-ID: <D9EDB4F689BF9F4EA6F2158A073942732E8007D6@de08ex3008.global.ds.honeywell.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Xenomai/Cobalt on i7-3770S CPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


We currently have an RTDM driver that is running well on Xenomai/Cobalt 3.0=
.1 on 2 Dell computers with Core2 processors, but will hang (unresponsive m=
ouse and keyboard, no discernable activity) an entire SuperLogics i7 comput=
er with a Core i7-3770S processor (4 physical cores, 4 logical cores).  The=
 hang occurs in the ioctl function at an rtdm_sem_down call that waits for =
the interrupt handler to signal the handling of an interrupt.  We suspect t=
hat we have a problem with our kernel build/installation configuration opti=
ons.  We have attempted to configure the Core i7-3770S system so that Xenom=
ai/Cobalt only uses 2 cores like the other 2 working Core2 computers, but t=
he system still hangs (more detail on the results of our attempt is include=
d beow).  Eventually, we would like to configure Xenomai/Cobalt to run on 4=
 cores of the i7 computer if possible.

Any suggestions to help us make/install/configure Xenomai/Cobalt to run on =
the SuperLogics computer with the i7-3770S processor so that the rtdm_sem_d=
own call in the RTDM driver does not hang the entire system would be apprec=
iated.

Thank you for any help,
Mike

<<<<<<< Output from /lib/xenomai/bin/xeno-config -info: >>>>>>>>
Xenomai version: Xenomai/cobalt v3.0.1
Linux sgslrtest 3.14.44-RTneti10X301SomeD-kMod2cpu #6 SMP Fri Jun 3 11:06:4=
1 EDT 2016 x86_64 x86_64 x86_64 GNU/Linux
Kernel parameters: BOOT_IMAGE=3D/vmlinuz-3.14.44-RTneti10X301SomeD-kMod2cpu=
 root=3DUUID=3D2c093713-cc31-4dd0-9f1b-8fc31992825a ro quiet splash vt.hand=
off=3D7
I-pipe release #10 detected
Cobalt core 3.0.1 detected
Compiler: gcc version 4.9.1 (Ubuntu 4.9.1-16ubuntu6)=20
Build args: --with-core=3Dcobalt --enable-smp --enable-pshared --host=3Dx86=
_64-linux host_alias=3Dx86_64-linux

Contents of selected files in the /proc directory:
cat /proc/cpuinfo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3770S CPU @ 3.10GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 3100.102
cache size	: 8192 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr =
pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c=
 rdrand lahf_lm ida arat xsaveopt pln pts dtherm tpr_shadow vnmi flexpriori=
ty ept vpid fsgsbase smep erms
bogomips	: 6200.20
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 58
model name	: Intel(R) Core(TM) i7-3770S CPU @ 3.10GHz
stepping	: 9
microcode	: 0x1b
cpu MHz		: 3100.102
cache size	: 8192 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr =
pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c=
 rdrand lahf_lm ida arat xsaveopt pln pts dtherm tpr_shadow vnmi flexpriori=
ty ept vpid fsgsbase smep erms
bogomips	: 6200.20
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

<<<<< cat /proc/sys/kernel/sem >>>>>>>>>>>>>>>>>>>>>>
250	32000	32	128
<<<<< ls /proc/xenomai >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
affinity
apc
clock
debug
faults
heap
irq
latency
registry
sched
timer
version
<<<<< cat /proc/xenomai/affinity >>>>>>>>>>>>>>>>>>>>
00000003
<<<<< cat /proc/xenomai/faults >>>>>>>>>>>>>>>>>>>>>>
TRAP         CPU0        CPU1
  0:            0           0    (Divide error)
  1:            0           0    (Debug)
  3:            0           0    (Int3)
  4:            0           0    (Overflow)
  5:            0           0    (Bounds)
  6:            0           0    (Invalid opcode)
  7:            0           0    (FPU not available)
  8:            0           0    (Double fault)
  9:            0           0    (FPU segment overrun)
 10:            0           0    (Invalid TSS)
 11:            0           0    (Segment not present)
 12:            0           0    (Stack segment)
 13:            0           0    (General protection)
 14:            0           0    (Page fault)
 15:            0           0    (Spurious interrupt)
 16:            0           0    (FPU error)
 17:            0           0    (Alignment check)
 18:            0           0    (Machine check)
 19:            0           0    (SIMD error)
<<<<< cat /proc/xenomai/irq >>>>>>>>>>>>>>>>>>>>>>>>>
  IRQ         CPU0        CPU1
 4352:           0           1         [reschedule]
 4353:       28214       22346         [timer/0]
 4354:           1           0         [timer-ipi]
 4355:           0           0         [sync]
 4419:           3           1         [virtual]
<<<<< cat /proc/xenomai/apc >>>>>>>>>>>>>>>>>>>>>>>>>
APC          CPU0        CPU1
  0:            0           0    (selector_list_destroy)
  1:            0           0    (registry_export)
<<<<< cat /proc/xenomai/heap >>>>>>>>>>>>>>>>>>>>>>>>
    TOTAL      FREE  NAME
   262144    262144  system heap
    16384     16384  debug log
    65536     65408  shared heap
<<<<< cat /proc/xenomai/latency >>>>>>>>>>>>>>>>>>>>>
1162
<<<<< cat /proc/xenomai/version >>>>>>>>>>>>>>>>>>>>>
3.0.1
<<<<< ls /proc/xenomai/clock >>>>>>>>>>>>>>>>>>>>>>>>
coreclk
<<<<< cat /proc/xenomai/clock/coreclk >>>>>>>>>>>>>>>
gravity: irq=3D81 kernel=3D1162 user=3D1162
devices: timer=3Dlapic, clock=3Dtsc
 status: on
  setup: 81
  ticks: 2592839844596
<<<<< ls /proc/xenomai/registry >>>>>>>>>>>>>>>>>>>>>
usage
<<<<< cat /proc/xenomai/registry/usage >>>>>>>>>>>>>>
9/512
<<<<< ls /proc/xenomai/timer >>>>>>>>>>>>>>>>>>>>>>>>
coreclk
<<<<< cat /proc/xenomai/timer/coreclk >>>>>>>>>>>>>>
CPU  SCHED/SHOT            TIMEOUT     INTERVAL    NAME
0    151861/26621          170us       -           [host-timer/0]
1    156824/21589          94us        -           [host-timer/1]
<<<<< ls /proc/xenomai/debug >>>>>>>>>>>>>>>>>>>>>>>>
relax
<<<<< cat /proc/xenomai/debug/relax >>>>>>>>>>>>>>>>>
<<<<< ls /proc/xenomai/sched >>>>>>>>>>>>>>>>>>>>>>>>
acct
rt
stat
threads
<<<<< cat /proc/xenomai/sched/acct >>>>>>>>>>>>>>>>>>
0 0 0 2 0 0 00018000 706537604072 706535605162 836373274151 ROOT/0 idle -1 =
0
1 0 0 2 0 0 00018000 706535604243 706534275732 836373921556 ROOT/1 idle -1 =
0
1 429 0 2 0 0 00000042 706535604243 0 2923 rtnet-stack rt 98 0
0 431 0 2 0 0 00020042 706537604072 0 2299 rtnet-rtpc rt 0 0
1 0 0 22354 0 0 00000000 706535604243 1057211 2559533 IRQ4353: [timer] idle=
 0 0
<<<<< cat /proc/xenomai/sched/stat >>>>>>>>>>>>>>>>>>
CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  NAME
  0  0      0          2          0          0     00018000  100.0  [ROOT/0=
]
  1  0      0          2          0          0     00018000  100.0  [ROOT/1=
]
  1  429    0          2          0          0     00000042    0.0  [rtnet-=
stack]
  0  431    0          2          0          0     00020042    0.0  [rtnet-=
rtpc]
  1  0      0          22354      0          0     00000000    0.0  [IRQ435=
3: [timer]]
<<<<< cat /proc/xenomai/sched/threads >>>>>>>>>>>>>>>
CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  0  0      idle   core       -1   -             R          [ROOT/0]
  1  0      idle   core       -1   -             R          [ROOT/1]
  1  429    rt     core       98   -             W          [rtnet-stack]
  0  431    rt     core        0   -             W          [rtnet-rtpc]
<<<<< ls /proc/xenomai/sched/rt >>>>>>>>>>>>>>>>>>>>>
threads
<<<<< cat /proc/xenomai/sched/rt/threads >>>>>>>>>>>>
CPU  PID    PRI      PERIOD     NAME
  1  429     98      -          rtnet-stack
<<<<<<<<<<<<<<<<<<<<<<< End of Message >>>>>>>>>>>

