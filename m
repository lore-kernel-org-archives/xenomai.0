From: Tobias Marschall <tmarscha@domain.hid>
Date: Thu, 13 Apr 2006 11:49:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604131149.40706.tmarscha@domain.hid>
Subject: [Xenomai-help] Problems running testsuite
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

Hallo,

I've been using rtai until now and decided to give xenomai (release 2.1) a 
try. I followed the instructions from README.INSTALL, and everything (kernel 
patching, compilation, etc.) went fine. Then I tried to run the latency test, 
which failed:

-----------
/usr/xenomai/testsuite/latency $ ./run
head: `-1' option is obsolete; use `-n 1' since this will be removed in the 
future
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
/usr/xenomai/bin/xeno-load: line 178:  5936 Killed                  $suflag $* 
$cmdargs
-----------

The same for "switch", the same if I call ./latency directly.

Is it correct that the xeno_timerbench module is required for the latency 
test? I get the same result wheter or not I load the module.

What am I doing wrong?

Thanks in advance and best regards,
Tobias

Some (hopefully useful) information follows:
-----------
/usr/xenomai/bin $ ./xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux tobi 2.6.14 #3 PREEMPT Thu Apr 13 09:13:53 CEST 2006 i686 AMD Athlon(tm) 
XP 1600+ AuthenticAMD GNU/Linux

Gnu C                  3.3.6
Gnu make               3.80
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.1
e2fsprogs              1.38
Linux C Library        2.3.5
head: `-1' option is obsolete; use `-n 1' since this will be removed in the 
future
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         xeno_timerbench
-----------
~ $ dmesg|grep -i xenomai
I-pipe: Domain Xenomai registered.
Xenomai: hal/x86 started.
Xenomai: real-time nucleus v2.1 (Champagne) loaded.
Xenomai: starting native API services.
Xenomai: starting RTDM services.
-----------
/usr/src/linux $ grep -3i xeno .config
#
# Real-time sub-system
#
CONFIG_XENOMAI=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY=y
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=128
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_STATS=y
# CONFIG_XENO_OPT_DEBUG is not set
# CONFIG_XENO_OPT_WATCHDOG is not set

#
# Timing
#
CONFIG_XENO_OPT_TIMING_PERIODIC=y
CONFIG_XENO_OPT_TIMING_PERIOD=0
CONFIG_XENO_OPT_TIMING_TIMERLAT=0
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0

#
# Scalability
#
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=y
# CONFIG_XENO_OPT_TIMER_HEAP is not set

#
# Shared interrupts
#
# CONFIG_XENO_OPT_SHIRQ_LEVEL is not set
# CONFIG_XENO_OPT_SHIRQ_EDGE is not set

#
# Machine
#
CONFIG_XENO_HW_FPU=y

#
# NMI watchdog
#
# CONFIG_XENO_HW_NMI_DEBUG_LATENCY is not set

#
# SMI workaround
#
# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
CONFIG_XENO_HW_SMI_DETECT=y
# CONFIG_XENO_HW_SMI_WORKAROUND is not set

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=4096
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_SKIN_POSIX=m
CONFIG_XENO_SKIN_PSOS=m
CONFIG_XENO_SKIN_UITRON=m
CONFIG_XENO_SKIN_VRTX=m
CONFIG_XENO_SKIN_VXWORKS=m
CONFIG_XENO_SKIN_RTAI=m
CONFIG_XENO_OPT_RTAI_FIFO=y
CONFIG_XENO_OPT_RTAI_SEM=y
CONFIG_XENO_OPT_RTAI_SHM=y
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_SKIN_UVM=m

#
# Drivers
#
# CONFIG_XENO_DRIVERS_16550A is not set
CONFIG_XENO_DRIVERS_TIMERBENCH=m
-----------
/usr/xenomai/bin $ ./xeno-test
running ./xeno-test

Thu Apr 13 09:37:38 CEST 2006
running: cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1600+
stepping        : 2
cpu MHz         : 1400.291
cache size      : 256 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 2804.44


Thu Apr 13 09:37:38 CEST 2006
running: cat /proc/meminfo
MemTotal:       774728 kB
MemFree:        744832 kB
Buffers:          3000 kB
Cached:          12284 kB
SwapCached:          0 kB
Active:          11200 kB
Inactive:         6328 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       774728 kB
LowFree:        744832 kB
SwapTotal:     1959920 kB
SwapFree:      1959920 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           4804 kB
Slab:             8512 kB
CommitLimit:   2347284 kB
Committed_AS:     8200 kB
PageTables:        196 kB
VmallocTotal:   253924 kB
VmallocUsed:      2100 kB
VmallocChunk:   251804 kB

Thu Apr 13 09:37:38 CEST 2006
running: cat /proc/ipipe/Linux
Priority=100, Id=0x00000000
irq0-15: accepted
irq16-206: passed
irq207-208: accepted
irq209-212: passed
irq213-216: accepted
irq217-221: passed
irq222-223: accepted
irq224-225: grabbed, virtual
irq226: passed, virtual

Thu Apr 13 09:37:38 CEST 2006
running: cat /proc/ipipe/Xenomai
Priority=200, Id=0x58454e4f
irq0-215: passed
irq216: grabbed
irq217-223: passed
irq224-225: passed, virtual
irq226: grabbed, virtual

Thu Apr 13 09:37:38 CEST 2006
running: cat /proc/ipipe/version
1.2-01

Thu Apr 13 09:37:38 CEST 2006
running: generate_loads 1
dd workload started, pids 5785

Thu Apr 13 09:37:38 CEST 2006
running: cat /proc/interrupts
           CPU0
  0:     169640          XT-PIC  timer, rthal_broadcast_timer
  1:          8          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  9:          0          XT-PIC  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
 11:       1956          XT-PIC  eth0
 12:        127          XT-PIC  i8042
 14:       1246          XT-PIC  ide0
 15:         16          XT-PIC  ide1
NMI:          0
LOC:     169605
ERR:          2

Thu Apr 13 09:37:38 CEST 2006
running: cat /proc/loadavg
0.16 0.03 0.01 2/33 5789
head: `-13' option is obsolete; use `-n 13' since this will be removed in the 
future

Thu Apr 13 09:37:38 CEST 2006
running: top -bn1c
top - 09:37:39 up 11 min,  1 user,  load average: 0.16, 0.03, 0.01
Tasks:  35 total,   2 running,  33 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.8% us,  0.8% sy,  0.0% ni, 97.4% id,  1.1% wa,  0.0% hi,  0.0% si
Mem:    774728k total,    30400k used,   744328k free,     3008k buffers
Swap:  1959920k total,        0k used,  1959920k free,    12344k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5785 root      25   0  1464  356  292 R 98.4  0.0   0:00.63 dd if /dev/zero 
of /dev/null
    1 root      16   0  1460  488  428 S  0.0  0.1   0:00.06 init [3]
    2 root      39  19     0    0    0 S  0.0  0.0   0:00.00 [ksoftirqd/0]

Thu Apr 13 09:37:39 CEST 2006
running: ./run -- -q -s -T 10 -t0
head: `-1' option is obsolete; use `-n 1' since this will be removed in the 
future
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
/usr/xenomai/bin/xeno-load: line 178:  5865 Killed                  $suflag $* 
$cmdargs

Thu Apr 13 09:37:40 CEST 2006
running: ./run -- -q -s -T 10 -t1
head: `-1' option is obsolete; use `-n 1' since this will be removed in the 
future
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
/usr/xenomai/bin/xeno-load: line 178:  5944 Killed                  $suflag $* 
$cmdargs

Thu Apr 13 09:37:41 CEST 2006
running: ./run -- -q -s -T 10 -t2
head: `-1' option is obsolete; use `-n 1' since this will be removed in the 
future
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel timer handler
== All results in microseconds
latency: failed to open benchmark device, code -16
(modprobe xeno_timerbench?)

Thu Apr 13 09:37:42 CEST 2006
running: cat /proc/interrupts
           CPU0
  0:     170509          XT-PIC  timer, rthal_broadcast_timer
  1:          8          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  9:          0          XT-PIC  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
 11:       2055          XT-PIC  eth0
 12:        127          XT-PIC  i8042
 14:       1260          XT-PIC  ide0
 15:         16          XT-PIC  ide1
NMI:          0
LOC:     170474
ERR:          2

Thu Apr 13 09:37:42 CEST 2006
running: cat /proc/loadavg
0.16 0.03 0.01 4/33 6033
head: `-13' option is obsolete; use `-n 13' since this will be removed in the 
future

Thu Apr 13 09:37:42 CEST 2006
running: top -bn1c
top - 09:37:42 up 11 min,  1 user,  load average: 0.16, 0.03, 0.01
Tasks:  35 total,   2 running,  33 sleeping,   0 stopped,   0 zombie
Cpu(s):  1.0% us,  1.1% sy,  0.0% ni, 96.9% id,  1.1% wa,  0.0% hi,  0.0% si
Mem:    774728k total,    30556k used,   744172k free,     3044k buffers
Swap:  1959920k total,        0k used,  1959920k free,    12344k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5785 root      25   0  1464  356  292 R 98.9  0.0   0:03.70 dd if /dev/zero 
of /dev/null
    1 root      19   0  1460  488  428 S  0.0  0.1   0:00.06 init [3]
    2 root      39  19     0    0    0 S  0.0  0.0   0:00.00 [ksoftirqd/0]

