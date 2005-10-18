Message-ID: <435543AD.4010807@domain.hid>
Date: Tue, 18 Oct 2005 12:49:17 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040204080901010109040808"
Subject: [Xenomai-help] latency_rt: disagrees about version of symbol
	rt_task_wait_period
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

This is a multi-part message in MIME format.
--------------040204080901010109040808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Im having trouble with built/installed xenomai,

soekris:/usr/realtime/2.6.13-ski7-v1# insmod 
testsuite/klatency/latency_rt.ko
latency_rt: disagrees about version of symbol rt_task_delete
latency_rt: Unknown symbol rt_task_delete
latency_rt: disagrees about version of symbol rt_task_wait_period
latency_rt: Unknown symbol rt_task_wait_period
insmod: error inserting 'testsuite/klatency/latency_rt.ko': -1 Unknown 
symbol in module

this has been replicated after deleting old tree,
and doing a fresh checkout to -r41

modinfo reports same vermagic for above module,
and those in modules/xeno*.ko, and Im at a loss wrt how to track this down.

...
filename:       modules/xeno_rtdm.ko
vermagic:       2.6.13-ski7-v1 preempt GEODEGX1 gcc-3.4
filename:       modules/xeno_uitron.ko
vermagic:       2.6.13-ski7-v1 preempt GEODEGX1 gcc-3.4
filename:       modules/xeno_uvm.ko
vermagic:       2.6.13-ski7-v1 preempt GEODEGX1 gcc-3.4
filename:       modules/xeno_vrtx.ko
vermagic:       2.6.13-ski7-v1 preempt GEODEGX1 gcc-3.4
filename:       modules/xeno_vxworks.ko
vermagic:       2.6.13-ski7-v1 preempt GEODEGX1 gcc-3.4
filename:       testsuite/klatency/latency_rt.ko
vermagic:       2.6.13-ski7-v1 preempt GEODEGX1 gcc-3.4
soekris:/usr/realtime/2.6.13-ski7-v1#


Im attaching my .xeno_config and the file written by `xeno-test -L`,
in the hopes that it has all info which might be pertinent.

The output file is missing the following 4 console errors:

latency_rt: disagrees about version of symbol rt_task_delete
latency_rt: Unknown symbol rt_task_delete
latency_rt: disagrees about version of symbol rt_task_wait_period
latency_rt: Unknown symbol rt_task_wait_period

but shows the problem, including the insmod error itself:

insmod: error inserting 'latency_rt.ko': -1 Unknown symbol in module
HSH|--param|----range-|--samples
HSH|--param|----range-|--samples
HSH|--param|----range-|--samples
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|         0|        nan|     -0.000
HSS|    avg|         0|        nan|     -0.000
HSS|    max|         0|        nan|     -0.000


tia,
jimc

--------------040204080901010109040808
Content-Type: text/plain;
 name=".xeno_config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".xeno_config"

#
# Automatically generated make config: don't edit
#
CONFIG_MODULES=y
CONFIG_XENO_VERSION="2.0"

#
# General
#
CONFIG_XENO_INSTALLDIR="/usr/realtime/2.6.13-ski7-v1"
CONFIG_XENO_LINUXDIR="/lib/modules/2.6.13-ski7-v1/build"

#
# Documentation
#
CONFIG_XENO_DOC_DOX=y
# CONFIG_XENO_DOC_LATEX_NONSTOP is not set
# CONFIG_XENO_DOC_DBX is not set
CONFIG_XENO_OPT_UDEV=y
# CONFIG_XENO_OPT_EXPERT is not set

#
# Nucleus
#
CONFIG_XENO_OPT_PERVASIVE=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV="32"
CONFIG_XENO_OPT_SYS_HEAPSZ="128"

#
# Machine (x86)
#
CONFIG_XENO_HW_FPU=y
CONFIG_XENO_HW_PERIODIC_TIMER=y

#
# NMI watchdog
#

#
# This menu requires enabling the 'Expert' mode.
#

#
# SMI workaround
#
CONFIG_XENO_HW_SMI_DETECT=y
CONFIG_XENO_HW_SMI_WORKAROUND=y
CONFIG_XENO_HW_SMI_ALL=y

#
# APIs
#
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_REGISTRY=y
CONFIG_XENO_OPT_NATIVE_REGISTRY_NRSLOTS="512"
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ="4096"
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
CONFIG_XENO_OPT_NATIVE_INTR=y
CONFIG_XENO_SKIN_POSIX=y
CONFIG_XENO_SKIN_PSOS=y
CONFIG_XENO_SKIN_UITRON=y
CONFIG_XENO_SKIN_VRTX=y
CONFIG_XENO_SKIN_VXWORKS=y
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_SKIN_RTAI=y
CONFIG_XENO_OPT_UVM=y

#
# Drivers
#
CONFIG_XENO_DRIVERS_16550A=y

#
# Simulator
#
# CONFIG_XENO_MVM is not set

--------------040204080901010109040808
Content-Type: text/plain;
 name="test-2.6.13-ski7-v1-051018.104018"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test-2.6.13-ski7-v1-051018.104018"

Script started on Tue Oct 18 10:40:18 2005
running ./xeno-test -s -h -T 20

Tue Oct 18 10:40:20 MDT 2005
running: cat /proc/cpuinfo
processor	: 0
vendor_id	: Geode by NSC
cpu family	: 5
model		: 9
model name	: Unknown
stepping	: 1
cpu MHz		: 266.667
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
flags		: fpu tsc msr cx8 cmov mmx cxmmx
bogomips	: 535.64


Tue Oct 18 10:40:20 MDT 2005
running: cat /proc/meminfo
MemTotal:       125868 kB
MemFree:         87388 kB
Buffers:            12 kB
Cached:          25884 kB
SwapCached:          0 kB
Active:          25468 kB
Inactive:         7288 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       125868 kB
LowFree:         87388 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:          11128 kB
Slab:             4232 kB
CommitLimit:     62932 kB
Committed_AS:    13436 kB
PageTables:        432 kB
VmallocTotal:   909292 kB
VmallocUsed:       632 kB
VmallocChunk:   908008 kB

Tue Oct 18 10:40:20 MDT 2005
running: cat /proc/ipipe/Linux
Priority=100, Id=0x00000000
irq0-15: accepted
irq32-33: grabbed, virtual
irq34: passed, virtual

Tue Oct 18 10:40:21 MDT 2005
running: cat /proc/ipipe/Linux_stats
> STALL TIME:
CPU0       7625789  (__ipipe_stall_root+0x1c)
> PROPAGATION TIME:
IRQ         CPU0
  0:     15514445
  3:        15518
  4:      3321250
  8:         5751
 10:     15365063
 14:       276146
 32:         5154
 33:       505665

Tue Oct 18 10:40:21 MDT 2005
running: cat /proc/ipipe/Xenomai
Priority=200, Id=0x58454e4f
irq0-31: passed
irq32-33: passed, virtual
irq34: grabbed, virtual

Tue Oct 18 10:40:21 MDT 2005
running: cat /proc/ipipe/Xenomai_stats
> STALL TIME:
CPU0       1426973  (rthal_apc_alloc+0x18 [xeno_hal])
> PROPAGATION TIME:
IRQ         CPU0
  0:        36718
 34:         8627

Tue Oct 18 10:40:21 MDT 2005
running: cat /proc/ipipe/version
1.0-07

Tue Oct 18 10:40:21 MDT 2005
running: generate_loads 1
dd workload started, pids 15629

Tue Oct 18 10:40:21 MDT 2005
running: cat /proc/interrupts
           CPU0       
  0:   19939891          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:     316405          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:     361471          XT-PIC  eth0, eth1
 14:         89          XT-PIC  ide0
NMI:          0 
ERR:          0

Tue Oct 18 10:40:21 MDT 2005
running: cat /proc/loadavg
10.12 9.62 8.81 12/50 15633

Tue Oct 18 10:40:22 MDT 2005
running: top -bn1c
top - 10:40:23 up 22:09,  1 user,  load average: 10.12, 9.62, 8.81
Tasks:  52 total,  12 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s): 16.8% us, 52.7% sy,  0.0% ni, 30.4% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    125868k total,    38840k used,    87028k free,       12k buffers
Swap:        0k total,        0k used,        0k free,    25884k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
11912 root      25   0  1584  384  316 R 18.2  0.3  14:07.15 dd if /dev/zero of 
12090 root      25   0  1588  384  316 R 18.2  0.3   6:26.42 dd if /dev/zero of 
12476 root      25   0  1588  384  316 R 18.2  0.3   5:46.77 dd if /dev/zero of 

Tue Oct 18 10:40:23 MDT 2005
running: ./run -- -h -s -h -T 20
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
RTT|  00:00:03
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       29429|       40589|       60352|       0|       29429|       60352
RTD|       25871|       40259|       51633|       1|       25871|       60352
RTD|       20958|       40394|       47891|       1|       20958|       60352
RTD|       30528|       40342|       57101|       1|       20958|       60352
RTD|       28001|       40627|       60839|       1|       20958|       60839
RTD|       25507|       40222|       50381|       1|       20958|       60839
RTD|       21153|       40102|       47771|       1|       20958|       60839
RTD|       28597|       40702|       58867|       1|       20958|       60839
RTD|       28713|       40552|       62362|       1|       20958|       62362
RTD|       24648|       40106|       49132|       1|       20958|       62362
RTD|       21506|       40252|       50849|       1|       20958|       62362
RTD|       29152|       40484|       60573|       1|       20958|       62362
RTD|       27374|       40353|       61117|       1|       20958|       62362
RTD|       21329|       40361|       49586|       1|       20958|       62362
RTD|       19863|       40244|       51269|       1|       19863|       62362
RTD|       27472|       40728|       60476|       1|       19863|       62362
RTD|       26399|       40256|       62583|       1|       19863|       62583
RTD|       19694|       40128|       62868|       1|       19694|       62868
---|--param|----range-|--samples
HSD|    min|  19 - 20 |        2
HSD|    min|  20 - 21 |        1
HSD|    min|  21 - 22 |        3
HSD|    min|  24 - 25 |        1
HSD|    min|  25 - 26 |        2
HSD|    min|  26 - 27 |        1
HSD|    min|  27 - 28 |        2
HSD|    min|  28 - 29 |        3
HSD|    min|  29 - 30 |        2
HSD|    min|  30 - 31 |        1
---|--param|----range-|--samples
HSD|    avg|  19 - 20 |        3
HSD|    avg|  20 - 21 |        3
HSD|    avg|  21 - 22 |       23
HSD|    avg|  22 - 23 |       34
HSD|    avg|  23 - 24 |       32
HSD|    avg|  24 - 25 |       35
HSD|    avg|  25 - 26 |       46
HSD|    avg|  26 - 27 |      134
HSD|    avg|  27 - 28 |      296
HSD|    avg|  28 - 29 |      368
HSD|    avg|  29 - 30 |      483
HSD|    avg|  30 - 31 |      458
HSD|    avg|  31 - 32 |      508
HSD|    avg|  32 - 33 |      488
HSD|    avg|  33 - 34 |      479
HSD|    avg|  34 - 35 |      606
HSD|    avg|  35 - 36 |     1438
HSD|    avg|  36 - 37 |     4288
HSD|    avg|  37 - 38 |     9888
HSD|    avg|  38 - 39 |    22502
HSD|    avg|  39 - 40 |    33098
HSD|    avg|  40 - 41 |    40267
HSD|    avg|  41 - 42 |    31804
HSD|    avg|  42 - 43 |    21621
HSD|    avg|  43 - 44 |    12144
HSD|    avg|  44 - 45 |     4481
HSD|    avg|  45 - 46 |      256
HSD|    avg|  46 - 47 |       37
HSD|    avg|  47 - 48 |       19
HSD|    avg|  48 - 49 |       13
HSD|    avg|  49 - 50 |       11
HSD|    avg|  50 - 51 |        8
HSD|    avg|  51 - 52 |       27
HSD|    avg|  52 - 53 |       46
HSD|    avg|  53 - 54 |       74
HSD|    avg|  54 - 55 |      101
HSD|    avg|  55 - 56 |      130
HSD|    avg|  56 - 57 |      198
HSD|    avg|  57 - 58 |      197
HSD|    avg|  58 - 59 |      154
HSD|    avg|  59 - 60 |       56
HSD|    avg|  60 - 61 |       20
HSD|    avg|  61 - 62 |        2
HSD|    avg|  62 - 63 |        3
---|--param|----range-|--samples
HSD|    max|  47 - 48 |        2
HSD|    max|  49 - 50 |        2
HSD|    max|  50 - 51 |        2
HSD|    max|  51 - 52 |        2
HSD|    max|  57 - 58 |        1
HSD|    max|  58 - 59 |        1
HSD|    max|  60 - 61 |        4
HSD|    max|  61 - 62 |        1
HSD|    max|  62 - 63 |        3
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|        18|     24.833|      3.746
HSS|    avg|    186879|     39.876|      2.623
HSS|    max|        18|     55.333|      5.821
---|------------|------------|------------|--------|-------------------------
RTS|       19694|       40372|       62868|       1|    00:00:20/00:00:20

Tue Oct 18 10:41:09 MDT 2005
running: ./run -- -h -s -h -T 20
*
*
* Type ^C to stop this application.
*
*
insmod: error inserting 'latency_rt.ko': -1 Unknown symbol in module
ERROR: cannot load latency_rt.ko
HSH|--param|----range-|--samples
HSH|--param|----range-|--samples
HSH|--param|----range-|--samples
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|         0|        nan|     -0.000
HSS|    avg|         0|        nan|     -0.000
HSS|    max|         0|        nan|     -0.000
---|------------|------------|------------|--------|-------------------------
RTS|    10000000|           0|   -10000000|       0|    00:00:20/00:00:20

Tue Oct 18 10:42:01 MDT 2005
running: cat /proc/interrupts
           CPU0       
  0:   19964879          XT-PIC  timer
  2:          0          XT-PIC  cascade
  4:     316801          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:     362784          XT-PIC  eth0, eth1
 14:         89          XT-PIC  ide0
NMI:          0 
ERR:          0

Tue Oct 18 10:42:01 MDT 2005
running: cat /proc/loadavg
11.28 10.19 9.10 12/50 15801

Tue Oct 18 10:42:01 MDT 2005
running: top -bn1c
top - 10:42:02 up 22:11,  1 user,  load average: 11.28, 10.19, 9.10
Tasks:  52 total,  12 running,  40 sleeping,   0 stopped,   0 zombie
Cpu(s): 16.8% us, 52.8% sy,  0.0% ni, 30.4% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    125868k total,    38932k used,    86936k free,       12k buffers
Swap:        0k total,        0k used,        0k free,    25892k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
11912 root      25   0  1584  384  316 R 18.1  0.3  14:15.87 dd if /dev/zero of 
12090 root      25   0  1588  384  316 R 16.4  0.3   6:35.17 dd if /dev/zero of 
12476 root      25   0  1588  384  316 R 16.4  0.3   5:55.48 dd if /dev/zero of 

Script done on Tue Oct 18 10:42:02 2005

--------------040204080901010109040808--

