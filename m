Content-Type: text/plain; charset="us-ascii"
Date: Fri, 15 Feb 2008 07:32:47 +0100
From: timo.pallach@domain.hid
Message-ID: <20080215063247.193470@domain.hid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Error in output of xeno-test
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

Hello,

I just finished compiling and rebooting into my new xenomai-kernel.
I used the xeno-test application to check if xenomai was installed correctly and I got the following error in the output of the xeno-test application:
eval: 1: arith: syntax error: "jobsct-1"
Where does this error come from and how can I get rid of this error?
You find the complete xeno-test output attached.







xxx@domain.hid:~$ sudo /usr/xenomai/bin/xeno-test
xeno-test: started
withBusybox is 0
xeno-test: running tests

Fri Feb 15 06:09:31 CET 2008
running: /usr/xenomai/bin/xeno-config --verbose
xeno-config --verbose
        --version="2.4.2"
        --cc="gcc"
        --arch="x86"
        --prefix="/usr/xenomai"
        --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XEN                                                                                 O__"
        --xeno-ldflags="-L/usr/xenomai/lib -lpthread "
        --posix-cflags="-I/usr/xenomai/include -I/usr/xenomai/include/posix -D_G                                                                                 NU_SOURCE -D_REENTRANT -D__XENO__"
        --posix-ldflags="-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib                                                                                  -lpthread_rt -lpthread -lrt "
        --library-dir="/usr/xenomai/lib"

Fri Feb 15 06:09:31 CET 2008
running: /usr/xenomai/bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux yyy 2.6.22.9 #1 Thu Feb 14 21:03:15 CET 2008 i586 GNU/Linux

Gnu C                  4.1.3
Gnu make               3.81
util-linux             ng 2.13)
mount                  ng 2.13)
module-init-tools      3.3-pre2
e2fsprogs              1.40.2
PPP                    2.4.4
Linux C Library        2.6.1
Dynamic linker (ldd)   2.6.1
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
Modules Loaded         parport_pc lp parport loop geode_aes psmouse blkcipher pc                                                                                 spkr serio_raw cs5535_gpio geode_rng ipv6 evdev ext3 jbd mbcache ide_disk ehci_h                                                                                 cd amd74xx ide_core ata_generic libata scsi_mod ohci_hcd usbcore e100 mii fuse

Fri Feb 15 06:09:34 CET 2008
running: cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 10
model name      : Geode(TM) Integrated Processor by AMD PCS
stepping        : 2
cpu MHz         : 498.112
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de pse tsc msr cx8 sep pge cmov clflush mmx mmxext 3dnowex                                                                                 t 3dnow
bogomips        : 997.18
clflush size    : 32


Fri Feb 15 06:09:34 CET 2008
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
8de8963f4ffe305fc6e0cbcfb0cb0f40  /proc/cpuinfo
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_IPIPE=y
CONFIG_IPIPE_DOMAINS=4
CONFIG_IPIPE_COMPAT=y
# CONFIG_PM is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_IPIPE_DEBUG is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set

Fri Feb 15 06:09:35 CET 2008
running: cat /proc/ipipe/Linux
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
   0:  A....
   1:  A....
   2:  A....
   3:  A....
   4:  A....
   5:  A....
   6:  A....
   7:  A....
   8:  A....
   9:  A....
  10:  A....
  11:  A....
  12:  A....
  13:  A....
  14:  A....
  15:  A....
  32:  G...V
  33:  G...V
[Domain info]
id=0x00000000
priority=100

Fri Feb 15 06:09:35 CET 2008
running: cat /proc/ipipe/Xenomai
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
   0:  W..X.
  34:  W...V
[Domain info]
id=0x58454e4f
priority=topmost

Fri Feb 15 06:09:35 CET 2008
running: cat /proc/ipipe/version
1.10-12

Fri Feb 15 06:09:35 CET 2008
running: generate_loads 1
eval: 1: arith: syntax error: "jobsct-1"
cleanup_load: no dd_jobs found

Fri Feb 15 06:09:36 CET 2008
running: cat /proc/interrupts
           CPU0
  0:     114844    XT-PIC-XT        timer
  1:          2    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  7:          0    XT-PIC-XT        ohci_hcd:usb1, ehci_hcd:usb2
  8:          3    XT-PIC-XT        rtc
 12:          4    XT-PIC-XT        i8042
 14:      17305    XT-PIC-XT        ide0
 15:      13509    XT-PIC-XT        eth0
NMI:          0
ERR:          0

Fri Feb 15 06:09:36 CET 2008
running: cat /proc/loadavg
1.95 1.29 0.65 4/52 22749

Fri Feb 15 06:09:36 CET 2008
running: cat /proc/meminfo
MemTotal:       239740 kB
MemFree:         12052 kB
Buffers:         40168 kB
Cached:          63740 kB
SwapCached:          0 kB
Active:         134484 kB
Inactive:        74716 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       239740 kB
LowFree:         12052 kB
SwapTotal:      498004 kB
SwapFree:       498004 kB
Dirty:             584 kB
Writeback:           0 kB
AnonPages:      105320 kB
Mapped:           7144 kB
Slab:            15280 kB
SReclaimable:     9924 kB
SUnreclaim:       5356 kB
PageTables:        556 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:    617872 kB
Committed_AS:   128632 kB
VmallocTotal:   786424 kB
VmallocUsed:      1800 kB
VmallocChunk:   784400 kB

Fri Feb 15 06:09:36 CET 2008
running: cat /proc/xenomai/affinity
00000001

Fri Feb 15 06:09:36 CET 2008
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:            0    (lostage_handler)
  2:            0    (registry_export)
  3:            0    (posix_signals_handler)

Fri Feb 15 06:09:36 CET 2008
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:            0    (Divide error)
  1:            0    (Debug)
  3:            0    (Int3)
  4:            0    (Overflow)
  5:            0    (Bounds)
  6:            0    (Invalid opcode)
  7:            0    (FPU not available)
  8:            0    (Double fault)
  9:            0    (FPU segment overrun)
 10:            0    (Invalid TSS)
 11:            0    (Segment not present)
 12:            0    (Stack segment)
 13:            0    (General protection)
 14:            0    (Page fault)
 15:            0    (Spurious interrupt)
 16:            0    (FPU error)
 17:            0    (Alignment check)
 18:            0    (Machine check)
 19:            0    (SIMD error)

Fri Feb 15 06:09:36 CET 2008
running: cat /proc/xenomai/hal
1.10-12

Fri Feb 15 06:09:37 CET 2008
running: cat /proc/xenomai/heap
size=129536:used=64:pagesz=512

Fri Feb 15 06:09:37 CET 2008
running: cat /proc/xenomai/irq
IRQ         CPU0
  0:      116370         [timer]
 34:           0         [virtual]

Fri Feb 15 06:09:37 CET 2008
running: cat /proc/xenomai/latency
4201

Fri Feb 15 06:09:37 CET 2008
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT

Fri Feb 15 06:09:37 CET 2008
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          0          0     00500080  100.0  ROOT
  0  0      0          116465     0     00000000    0.0  IRQ0: [timer]

Fri Feb 15 06:09:37 CET 2008
running: cat /proc/xenomai/timebases
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled,set

Fri Feb 15 06:09:37 CET 2008
running: cat /proc/xenomai/timer
status=on:setup=2:clock=453075886548:timerdev=pit:clockdev=tsc

Fri Feb 15 06:09:37 CET 2008
running: cat /proc/xenomai/version
2.4.2

Fri Feb 15 06:09:38 CET 2008
running: cat /proc/xenomai/interfaces/native
0

Fri Feb 15 06:09:38 CET 2008
running: cat /proc/xenomai/interfaces/posix
0

Fri Feb 15 06:09:38 CET 2008
running: cat /proc/xenomai/interfaces/rtdm
0

Fri Feb 15 06:09:38 CET 2008
running: cat /proc/xenomai/interfaces/sys
0

Fri Feb 15 06:09:38 CET 2008
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Fri Feb 15 06:09:38 CET 2008
running: cat /proc/xenomai/rtdm/named_devices
Hash    Name                            Driver          /proc

Fri Feb 15 06:09:38 CET 2008
running: cat /proc/xenomai/rtdm/open_fildes
Index   Locked  Device          Owner [PID]

Fri Feb 15 06:09:39 CET 2008
running: cat /proc/xenomai/rtdm/protocol_devices
Hash    ProtocolFamily:SocketType       Driver          /proc

Fri Feb 15 06:09:39 CET 2008
running: cat /proc/xenomai/timerstat/master
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME
0    143457      110090      1350144    -          NULL         [host-timer]

Fri Feb 15 06:09:39 CET 2008
running: top -bn1c
top - 06:09:40 up 15 min,  2 users,  load average: 1.87, 1.29, 0.65
Tasks:  54 total,   2 running,  52 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0%us, 49.8%sy,  0.0%ni, 46.8%id,  3.4%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:    239740k total,   236424k used,     3316k free,    40172k buffers
Swap:   498004k total,        0k used,   498004k free,    63904k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
22567 root      25   0 75052  62m 4868 R 97.7 26.7   0:14.84 /usr/lib/gcc/i486-l
22820 root      21   0  2256  976  760 R  2.0  0.4   0:00.02 top -bn1c
    1 root      18   0  2864 1848  528 S  0.0  0.8   0:22.38 /sbin/init

Fri Feb 15 06:09:40 CET 2008
running: ./run -- -sh -T 120 -t0 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       6.978|      10.039|      14.617|       0|       6.978|      14.617
RTD|       2.680|      10.027|      18.471|       0|       2.680|      18.471
RTD|       2.752|       9.839|      15.910|       0|       2.680|      18.471
RTD|       2.463|      10.057|      18.503|       0|       2.463|      18.503
RTD|       9.032|      10.049|      17.343|       0|       2.463|      18.503
RTD|       2.401|      10.023|      18.883|       0|       2.401|      18.883
RTD|       8.875|       9.997|      18.855|       0|       2.401|      18.883
RTD|       2.461|      10.029|      18.885|       0|       2.401|      18.885
RTD|       8.951|       9.985|      19.445|       0|       2.401|      19.445
RTD|       2.176|       9.999|      19.339|       0|       2.176|      19.445
RTD|       8.973|       9.809|      18.252|       0|       2.176|      19.445
RTD|       2.136|       9.746|      19.055|       0|       2.136|      19.445
RTD|       9.006|       9.756|      19.228|       0|       2.136|      19.445
RTD|       2.025|       9.756|      18.905|       0|       2.025|      19.445
RTD|       4.944|       9.927|      20.192|       0|       2.025|      20.192
RTD|       2.629|      10.106|      18.955|       0|       2.025|      20.192
RTD|       2.409|      10.068|      18.792|       0|       2.025|      20.192
RTD|       2.702|      10.096|      17.791|       0|       2.025|      20.192
RTD|       2.617|      10.019|      19.563|       0|       2.025|      20.192
RTD|       6.952|      10.017|      19.266|       0|       2.025|      20.192
RTD|       2.603|      10.025|      19.860|       0|       2.025|      20.192
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       8.887|      10.070|      18.967|       0|       2.025|      20.192
RTD|       2.668|      10.015|      18.805|       0|       2.025|      20.192
RTD|       8.901|       9.995|      18.648|       0|       2.025|      20.192
RTD|       2.746|      10.005|      17.937|       0|       2.025|      20.192
RTD|       8.825|       9.979|      11.270|       0|       2.025|      20.192
RTD|       2.591|       9.969|      17.825|       0|       2.025|      20.192
RTD|       8.917|       9.965|      18.451|       0|       2.025|      20.192

