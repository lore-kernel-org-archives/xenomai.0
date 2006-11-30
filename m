Content-Transfer-Encoding: 7bit
Content-Type: multipart/mixed; boundary="_----------=_1164872122233272"
MIME-Version: 1.0
From: "Marc Brown" <marc.brown@domain.hid>
Date: Thu, 30 Nov 2006 08:35:22 +0100
Message-Id: <20061130073522.3BBF9EE753@domain.hid>
Subject: [Xenomai-core] structure alignement problem in RTDM?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

--_----------=_1164872122233272
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

It seems that there are still structure alignment problems in RTDM (while r=
unning xenotest), as already=20
talked about with Philippe. Compiled with a GCC 4.0.3-2 (on x86), here is t=
he=20
problem (output trace and xenomai /proc are provided herewith):

> ---------- 8<----------------------------------------------------
> Mon Nov 27 11:24:22 CET 2006
> running: ./run -- -sh -T 120 -t1 # latency
> *
> *
> * Type ^C to stop this application.
> *
> *
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: in-kernel periodic task
> =3D=3D All results in microseconds
> latency: failed to start in-kernel timer benchmark, code -25
> ---|--param|----range-|--samples
> ---|--param|----range-|--samples
> ---|--param|----range-|--samples
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|         0|        nan|     -0.000
> HSS|    avg|         0|        nan|     -0.000
> HSS|    max|         0|        nan|     -0.000
> ---|------------|------------|------------|--------|---------------------=
----
> RTS|  134514.515|  134525.280|-1208401.520|-1076345508|    00:02:00/00:02=
:00
>
> Mon Nov 27 11:26:26 CET 2006
> running: ./run -- -sh -T 120 -t2 # latency
> *
> *
> * Type ^C to stop this application.
> *
> *
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: in-kernel timer handler
> =3D=3D All results in microseconds
> latency: failed to start in-kernel timer benchmark, code -25
> ---|--param|----range-|--samples
> ---|--param|----range-|--samples
> ---|--param|----range-|--samples
> HSH|--param|--samples-|--average--|---stddev--
> HSS|    min|         0|        nan|     -0.000
> HSS|    avg|         0|        nan|     -0.000
> HSS|    max|         0|        nan|     -0.000
> ---|------------|------------|------------|--------|---------------------=
----
> RTS|  134514.515|  134525.280|-1208749.680|-1080938244|    00:02:00/00:02=
:00
>
> Mon Nov 27 11:28:30 CET 2006
> running: ./run -- -T 120 # switchtest


KR,

MAB


--_----------=_1164872122233272
Content-Disposition: attachment; filename="xeno-test_output.txt"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; name="xeno-test_output.txt"

xeno-test: started=20
withBusybox is 0
xeno-test: running tests

Mon Nov 27 11:22:12 CET 2006
running: ./bin/xeno-config --verbose
xeno-config --verbose
    --version=3D"2.2.91"
    --cc=3D"gcc"
    --arch=3D"i386"
    --prefix=3D"/usr/xenomai"
    --xeno-cflags=3D"-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT"
    --xeno-ldflags=3D"-L/usr/xenomai/lib -lpthread "
    --posix-cflags=3D"-I/usr/xenomai/include -I/usr/xenomai/include/posix -=
D_GNU_SOURCE -D_REENTRANT -D__XENO__"
    --posix-ldflags=3D"-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
    --library-dir=3D"/usr/xenomai/lib"

Mon Nov 27 11:22:12 CET 2006
running: ./bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux troul05 2.6.17.13-2-i686-ipipe #1 PREEMPT Mon Nov 27 09:10:00 CET 200=
6 i686 GNU/Linux
=20
Gnu C                  4.0.3
Gnu make               3.81beta4
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
jfsutils               1.1.8
xfsprogs               2.7.7
PPP                    2.4.4b1
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.93
Modules Loaded         xeno_switchtest xeno_timerbench ppdev r128 drm speed=
step_lib cpufreq_powersave cpufreq_stats cpufreq_userspace cpufreq_ondemand=
 cpufreq_conservative freq_table video battery container button ac af_packe=
t ext2 mbcache lp snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_=
mixer_oss snd_pcm snd_timer e100 mii snd parport_pc parport xeno_irqbench s=
oundcore snd_page_alloc rtc intel_agp agpgart shpchp pci_hotplug hw_random =
psmouse serio_raw sg sd_mod evdev usb_storage scsi_mod usbhid reiserfs ide_=
generic uhci_hcd usbcore ide_cd cdrom ide_disk piix thermal processor fan

Mon Nov 27 11:22:13 CET 2006
running: cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Pentium(R) 4 CPU 1.80GHz
stepping	: 2
cpu MHz		: 1793.609
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm up
bogomips	: 3590.40


Mon Nov 27 11:22:13 CET 2006
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
2c99b37d49a322d0c726158fd917f51b  /proc/cpuinfo
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
CONFIG_PREEMPT_BKL=3Dy
CONFIG_IPIPE=3Dy
CONFIG_PM=3Dy
CONFIG_PM_LEGACY=3Dy
# CONFIG_PM_DEBUG is not set
CONFIG_PM_STD_PARTITION=3D""
CONFIG_ACPI=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SLEEP_PROC_FS=3Dy
CONFIG_ACPI_SLEEP_PROC_SLEEP=3Dy
CONFIG_ACPI_AC=3Dm
CONFIG_ACPI_BATTERY=3Dm
CONFIG_ACPI_BUTTON=3Dm
CONFIG_ACPI_VIDEO=3Dm
CONFIG_ACPI_HOTKEY=3Dm
CONFIG_ACPI_FAN=3Dm
CONFIG_ACPI_PROCESSOR=3Dm
CONFIG_ACPI_THERMAL=3Dm
CONFIG_ACPI_ASUS=3Dm
CONFIG_ACPI_IBM=3Dm
# CONFIG_ACPI_IBM_DOCK is not set
CONFIG_ACPI_TOSHIBA=3Dm
CONFIG_ACPI_BLACKLIST_YEAR=3D2000
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_ACPI_CONTAINER=3Dm
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dm
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=3Dm
CONFIG_CPU_FREQ_STAT_DETAILS=3Dy
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dm
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dm
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dm
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dm
# CONFIG_IPIPE_DEBUG is not set
CONFIG_IPIPE_TRACE_ENABLE_VALUE=3D0
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set

Mon Nov 27 11:22:13 CET 2006
running: cat /proc/ipipe/Linux
Priority=3D100, Id=3D0x00000000
irq0-238: accepted
irq256-257: grabbed, virtual
irq258: passed, virtual
irq259: grabbed, virtual

Mon Nov 27 11:22:13 CET 2006
running: cat /proc/ipipe/version
1.5-02

Mon Nov 27 11:22:13 CET 2006
running: cat /proc/ipipe/Xenomai
Invariant head, Id=3D0x58454e4f
irq0-215: passed
irq216: wired
irq217-255: passed
irq256-257: passed, virtual
irq258: wired, virtual
irq259: passed, virtual

Mon Nov 27 11:22:13 CET 2006
running: generate_loads 1
dd workload started, pids 22995 stored in /var/lock/xeno-test.22857.pids

Mon Nov 27 11:22:13 CET 2006
running: cat /proc/interrupts
           CPU0=20=20=20=20=20=20=20
  0:     372862    IO-APIC-edge  timer, rthal_broadcast_timer
  8:          3    IO-APIC-edge  rtc
  9:          1   IO-APIC-level  acpi
 14:      12077    IO-APIC-edge  ide0
 15:      25183    IO-APIC-edge  ide1
169:      32190   IO-APIC-level  uhci_hcd:usb1
177:       5524   IO-APIC-level  uhci_hcd:usb2
185:        741   IO-APIC-level  eth0
193:          0   IO-APIC-level  Intel 82801BA-ICH2
201:     123627   IO-APIC-level  r128@domain.hid
NMI:          0=20
LOC:     372811=20
ERR:          0
MIS:          0

Mon Nov 27 11:22:13 CET 2006
running: cat /proc/loadavg
0.55 0.95 0.67 2/83 23001

Mon Nov 27 11:22:14 CET 2006
running: cat /proc/meminfo
MemTotal:       515928 kB
MemFree:        245076 kB
Buffers:         43760 kB
Cached:         138616 kB
SwapCached:          0 kB
Active:         152436 kB
Inactive:        90932 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       515928 kB
LowFree:        245076 kB
SwapTotal:     2048276 kB
SwapFree:      2048276 kB
Dirty:              16 kB
Writeback:           0 kB
Mapped:          87636 kB
Slab:            13220 kB
CommitLimit:   2306240 kB
Committed_AS:   104972 kB
PageTables:       1288 kB
VmallocTotal:   507896 kB
VmallocUsed:      7280 kB
VmallocChunk:   499700 kB

Mon Nov 27 11:22:14 CET 2006
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:       113761    (lostage_handler)
  2:            4    (registry_export)
  3:            0    (posix_signals_handler)

Mon Nov 27 11:22:14 CET 2006
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:            0    (Divide error)
  1:            0    (Debug)
  3:            0    (Int3)
  4:            0    (Overflow)
  5:            0    (Bounds)
  6:            0    (Invalid opcode)
  7:            1    (FPU not available)
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

Mon Nov 27 11:22:14 CET 2006
running: cat /proc/xenomai/hal
1.5-02

Mon Nov 27 11:22:14 CET 2006
running: cat /proc/xenomai/heap
size=3D130560:used=3D64:pagesz=3D512

Mon Nov 27 11:22:14 CET 2006
running: cat /proc/xenomai/irq
IRQ         CPU0
216:     1314281         [timer]
258:      577049         [virtual]

Mon Nov 27 11:22:14 CET 2006
running: cat /proc/xenomai/latency
2514

Mon Nov 27 11:22:15 CET 2006
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT

Mon Nov 27 11:22:15 CET 2006
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          1606038    0     01400080  100.0  ROOT
  0  0      0          1314281    0     00000000    0.0  IRQ216: [timer]

Mon Nov 27 11:22:15 CET 2006
running: cat /proc/xenomai/timer
status=3Doneshot:setup=3D838:tickval=3D1:jiffies=3D3556519070016

Mon Nov 27 11:22:15 CET 2006
running: cat /proc/xenomai/version
2.3-rc2

Mon Nov 27 11:22:15 CET 2006
running: cat /proc/xenomai/interfaces/core
0

Mon Nov 27 11:22:15 CET 2006
running: cat /proc/xenomai/interfaces/native
0

Mon Nov 27 11:22:15 CET 2006
running: cat /proc/xenomai/interfaces/posix
0

Mon Nov 27 11:22:15 CET 2006
running: cat /proc/xenomai/interfaces/rtdm
0

Mon Nov 27 11:22:16 CET 2006
running: cat /proc/xenomai/rtdm/fildes
total=3D128:open=3D0:free=3D128

Mon Nov 27 11:22:16 CET 2006
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				/proc
D6	rttest0                        	rttest0
D7	rttest1                        	rttest1
D8	rttest2                        	rttest2

Mon Nov 27 11:22:16 CET 2006
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device

Mon Nov 27 11:22:16 CET 2006
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	/proc

Mon Nov 27 11:22:16 CET 2006
running: top -bn1c
top - 11:22:17 up 25 min,  3 users,  load average: 0.55, 0.95, 0.67
Tasks:  84 total,   2 running,  82 sleeping,   0 stopped,   0 zombie
Cpu(s): 19.3% us, 27.9% sy,  0.0% ni, 49.3% id,  3.5% wa,  0.0% hi,  0.0% si
Mem:    515928k total,   271472k used,   244456k free,    44028k buffers
Swap:  2048276k total,        0k used,  2048276k free,   138624k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND=20=20=
=20=20=20=20=20=20=20=20=20=20
22995 root      25   0  2788  756  560 R 81.1  0.1   0:02.91 dd if /dev/zer=
o of=20
23062 root      20   0  2192  996  752 R  1.6  0.2   0:00.01 top -bn1c=20=
=20=20=20=20=20=20=20=20=20
    1 root      16   0  1568  532  460 S  0.0  0.1   0:01.39 init [2]=20=20=
=20=20=20=20=20=20=20=20=20

Mon Nov 27 11:22:17 CET 2006
running: ./run -- -sh -T 120 -t0 # latency
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:02  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat wor=
st
RTD|      32.685|      32.685|      37.714|       0|      32.685|      37.7=
14
RTD|      32.685|      33.523|      40.228|       0|      32.685|      40.2=
28
RTD|      32.685|      32.685|      38.552|       0|      32.685|      40.2=
28
RTD|      32.685|      33.523|      39.390|       0|      32.685|      40.2=
28
RTD|      32.685|      32.685|      38.552|       0|      32.685|      40.2=
28
RTD|      32.685|      33.523|      38.552|       0|      32.685|      40.2=
28
RTD|      32.685|      32.685|      37.714|       0|      32.685|      40.2=
28
RTD|      32.685|      33.523|      38.552|       0|      32.685|      40.2=
28
RTD|      32.685|      32.685|      37.714|       0|      32.685|      40.2=
28
RTD|      32.685|      33.523|      38.552|       0|      32.685|      40.2=
28
RTD|      32.685|      32.685|      37.714|       0|      32.685|      40.2=
28
RTD|      32.685|      33.523|      40.228|       0|      32.685|      40.2=
28
RTD|      32.685|      32.685|      37.714|       0|      32.685|      40.2=
28
RTD|      32.685|      33.523|      39.390|       0|      32.685|      40.2=
28
RTD|      32.685|      32.685|      39.390|       0|      32.685|      40.2=
28
RTD|      32.685|      33.523|      39.390|       0|      32.685|      40.2=
28
RTD|      32.685|      32.685|      37.714|       0|      32.685|      40.2=
28
RTD|      32.685|      33.523|      40.228|       0|      32.685|      40.2=
28
RTD|      32.685|      32.685|      37.714|       0|      32.685|      40.2=
28
RTD|      32.685|      33.523|      39.390|       0|      32.685|      40.2=
28
RTD|      32.685|      32.685|      41.066|       0|      32.685|      41.0=
66
RTT|  00:00:23  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat wor=
st
RTD|      32.685|      33.523|      39.390|       0|      32.685|      41.0=
66
RTD|      32.685|      32.685|      41.066|       0|      32.685|      41.0=
66
RTD|      32.685|      33.523|      41.904|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      38.552|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      39.390|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      38.552|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      38.552|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      38.552|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      40.228|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      37.714|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      38.552|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      37.714|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      40.228|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      37.714|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      39.390|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      37.714|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      39.390|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      39.390|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      40.228|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      37.714|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      38.552|       0|      32.685|      41.9=
04
RTT|  00:00:43  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat wor=
st
RTD|      32.685|      32.685|      37.714|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      37.714|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      37.714|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      39.390|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      37.714|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      39.390|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      37.714|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      40.228|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      37.714|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      39.390|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      37.714|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      39.390|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      37.714|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      40.228|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      36.876|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      38.552|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      38.552|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      41.066|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      41.066|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      38.552|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      38.552|       0|      32.685|      41.9=
04
RTT|  00:01:04  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat wor=
st
RTD|      32.685|      33.523|      39.390|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      37.714|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      38.552|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      41.066|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      38.552|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      39.390|       0|      32.685|      41.9=
04
RTD|      32.685|      32.685|      41.066|       0|      32.685|      41.9=
04
RTD|      32.685|      33.523|      43.580|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      39.390|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      38.552|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      39.390|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      38.552|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      40.228|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      39.390|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      39.390|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      38.552|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      38.552|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      41.066|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      38.552|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      40.228|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      38.552|       0|      32.685|      43.5=
80
RTT|  00:01:25  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat wor=
st
RTD|      32.685|      33.523|      41.066|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      39.390|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      39.390|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      37.714|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      39.390|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      39.390|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      40.228|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      38.552|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      43.580|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      38.552|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      39.390|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      37.714|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      38.552|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      36.876|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      40.228|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      37.714|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      40.228|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      38.552|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      40.228|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      38.552|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      39.390|       0|      32.685|      43.5=
80
RTT|  00:01:46  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat wor=
st
RTD|      32.685|      32.685|      38.552|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      40.228|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      36.876|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      39.390|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      37.714|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      39.390|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      38.552|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      38.552|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      37.714|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      40.228|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      37.714|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      39.390|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      36.876|       0|      32.685|      43.5=
80
RTD|      32.685|      33.523|      40.228|       0|      32.685|      43.5=
80
RTD|      32.685|      32.685|      39.390|       0|      32.685|      43.5=
80
---|--param|----range-|--samples
HSD|    min|  32 - 33 |      120
---|--param|----range-|--samples
HSD|    avg|  32 - 33 |   337531
HSD|    avg|  33 - 34 |   728068
HSD|    avg|  34 - 35 |    30590
HSD|    avg|  35 - 36 |    57220
HSD|    avg|  36 - 37 |    46994
HSD|    avg|  37 - 38 |      492
HSD|    avg|  38 - 39 |      225
HSD|    avg|  39 - 40 |       55
HSD|    avg|  40 - 41 |       21
HSD|    avg|  41 - 42 |        9
HSD|    avg|  43 - 44 |        2
---|--param|----range-|--samples
HSD|    max|  36 - 37 |        4
HSD|    max|  37 - 38 |       27
HSD|    max|  38 - 39 |       31
HSD|    max|  39 - 40 |       30
HSD|    max|  40 - 41 |       17
HSD|    max|  41 - 42 |        9
HSD|    max|  43 - 44 |        2
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       120|     32.000|      0.000
HSS|    avg|   1201207|     32.960|      0.928
HSS|    max|       120|     38.550|      1.407
---|------------|------------|------------|--------|-----------------------=
--
RTS|      32.685|      32.685|      43.580|       0|    00:02:00/00:02:00

Mon Nov 27 11:24:22 CET 2006
running: ./run -- -sh -T 120 -t1 # latency
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 100 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
latency: failed to start in-kernel timer benchmark, code -25
---|--param|----range-|--samples
---|--param|----range-|--samples
---|--param|----range-|--samples
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|         0|        nan|     -0.000
HSS|    avg|         0|        nan|     -0.000
HSS|    max|         0|        nan|     -0.000
---|------------|------------|------------|--------|-----------------------=
--
RTS|  134514.515|  134525.280|-1208401.520|-1076345508|    00:02:00/00:02:00

Mon Nov 27 11:26:26 CET 2006
running: ./run -- -sh -T 120 -t2 # latency
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 100 us
=3D=3D Test mode: in-kernel timer handler
=3D=3D All results in microseconds
latency: failed to start in-kernel timer benchmark, code -25
---|--param|----range-|--samples
---|--param|----range-|--samples
---|--param|----range-|--samples
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|         0|        nan|     -0.000
HSS|    avg|         0|        nan|     -0.000
HSS|    max|         0|        nan|     -0.000
---|------------|------------|------------|--------|-----------------------=
--
RTS|  134514.515|  134525.280|-1208749.680|-1080938244|    00:02:00/00:02:00

Mon Nov 27 11:28:30 CET 2006
running: ./run -- -T 120 # switchtest
*
*
* Type ^C to stop this application.
*
*
=3D=3D Testing FPU check routines...
r0: 1 !=3D 2
r1: 1 !=3D 2
r2: 1 !=3D 2
r3: 1 !=3D 2
r4: 1 !=3D 2
r5: 1 !=3D 2
r6: 1 !=3D 2
r7: 1 !=3D 2
=3D=3D FPU check routines: OK.
=3D=3D Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-5 =
rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12 rtus_u=
fps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18 rtuo_ufps-19 =
rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|        5520|        5520
RTD|        5635|       11155
RTD|        5520|       16675
RTD|        5451|       22126
RTD|        5405|       27531
RTD|        5566|       33097
RTD|        5589|       38686
RTD|        5474|       44160
RTD|        5474|       49634
RTD|        5520|       55154
RTD|        5451|       60605
RTD|        5543|       66148
RTD|        5589|       71737
RTD|        5520|       77257
RTD|        5290|       82547
RTD|        5566|       88113
RTD|        5451|       93564
RTD|        5566|       99130
RTD|        5405|      104535
RTD|        5543|      110078
RTD|        5520|      115598
RTT|  00:00:22
RTH|ctx switches|-------total
RTD|        5474|      121072
RTD|        5428|      126500
RTD|        5451|      131951
RTD|        5520|      137471
RTD|        5543|      143014
RTD|        5520|      148534
RTD|        5589|      154123
RTD|        5497|      159620
RTD|        5474|      165094
RTD|        5566|      170660
RTD|        5451|      176111
RTD|        5520|      181631
RTD|        5497|      187128
RTD|        5520|      192648
RTD|        5520|      198168
RTD|        5543|      203711
RTD|        5543|      209254
RTD|        5635|      214889
RTD|        5589|      220478
RTD|        5359|      225837
RTD|        5474|      231311
RTT|  00:00:43
RTH|ctx switches|-------total
RTD|        5658|      236969
RTD|        5405|      242374
RTD|        5704|      248078
RTD|        5428|      253506
RTD|        5428|      258934
RTD|        5474|      264408
RTD|        5474|      269882
RTD|        5520|      275402
RTD|        5589|      280991
RTD|        5451|      286442
RTD|        5520|      291962
RTD|        5520|      297482
RTD|        5497|      302979
RTD|        5497|      308476
RTD|        5451|      313927
RTD|        5589|      319516
RTD|        5520|      325036
RTD|        5543|      330579
RTD|        5543|      336122
RTD|        5520|      341642
RTD|        5589|      347231
RTT|  00:01:04
RTH|ctx switches|-------total
RTD|        5589|      352820
RTD|        5497|      358317
RTD|        5382|      363699
RTD|        5520|      369219
RTD|        5520|      374739
RTD|        5635|      380374
RTD|        5520|      385894
RTD|        5382|      391276
RTD|        5589|      396865
RTD|        5589|      402454
RTD|        5451|      407905
RTD|        5497|      413402
RTD|        5451|      418853
RTD|        5382|      424235
RTD|        5520|      429755
RTD|        5543|      435298
RTD|        5451|      440749
RTD|        5474|      446223
RTD|        5589|      451812
RTD|        5405|      457217
RTD|        5474|      462691
RTT|  00:01:25
RTH|ctx switches|-------total
RTD|        5520|      468211
RTD|        5612|      473823
RTD|        5382|      479205
RTD|        5566|      484771
RTD|        5520|      490291
RTD|        5474|      495765
RTD|        5497|      501262
RTD|        5497|      506759
RTD|        5543|      512302
RTD|        5497|      517799
RTD|        5405|      523204
RTD|        5474|      528678
RTD|        5543|      534221
RTD|        5451|      539672
RTD|        5474|      545146
RTD|        5474|      550620
RTD|        5451|      556071
RTD|        5405|      561476
RTD|        5543|      567019
RTD|        5405|      572424
RTD|        5497|      577921
RTT|  00:01:46
RTH|ctx switches|-------total
RTD|        5612|      583533
RTD|        5451|      588984
RTD|        5543|      594527
RTD|        5520|      600047
RTD|        5589|      605636
RTD|        5543|      611179
RTD|        5635|      616814
RTD|        5543|      622357
RTD|        5474|      627831
RTD|        5520|      633351
RTD|        5497|      638848
RTD|        5520|      644368
RTD|        5589|      649957
RTD|        5428|      655385
RTD|         460|      655845

Mon Nov 27 11:30:34 CET 2006
running: ./run -- -h # switchbench
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 100 us
=3D=3D Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|      17.599|      17.599|      25.142|           0
---|---range-|---samples
HSD| 17 - 18 |      65409
HSD| 18 - 19 |      26791
HSD| 19 - 20 |       7432
HSD| 20 - 21 |        272
HSD| 21 - 22 |         42
HSD| 22 - 23 |         17
HSD| 23 - 24 |         16
HSD| 24 - 25 |         10
HSD| 25 - 26 |          7
HSS|     99996|     17.429|      0.657

Mon Nov 27 11:30:46 CET 2006
running: ./run -- -p 10 -n -l 1000 # cyclictest
*
*
* Type ^C to stop this application.
*
*
1.17 1.09 0.84 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (    0) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 5/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 5/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 5/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.17 1.09 0.84 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 5/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 6/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.24 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 5/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:     =
  0 Max:-1000000
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:      12 Min:      21 Act:      24 Avg:     =
 24 Max:      42
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:      24 Min:      21 Act:      23 Avg:     =
 23 Max:      42
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:      36 Min:      21 Act:      21 Avg:     =
 22 Max:      42
=1B[3A1.22 1.10 0.85 4/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:      48 Min:      21 Act:      23 Avg:     =
 22 Max:      42
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:      60 Min:      21 Act:      25 Avg:     =
 23 Max:      50
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:      72 Min:      21 Act:      26 Avg:     =
 24 Max:      50
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:      84 Min:      21 Act:      25 Avg:     =
 24 Max:      50
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:      96 Min:      21 Act:      25 Avg:     =
 24 Max:      50
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     108 Min:      21 Act:      24 Avg:     =
 24 Max:      50
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     120 Min:      21 Act:      25 Avg:     =
 24 Max:      50
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     132 Min:      21 Act:      24 Avg:     =
 24 Max:      50
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     144 Min:      21 Act:      24 Avg:     =
 24 Max:      50
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     156 Min:      21 Act:      23 Avg:     =
 23 Max:      50
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     168 Min:      21 Act:      25 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     180 Min:      21 Act:      22 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     192 Min:      21 Act:      22 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     204 Min:      21 Act:      21 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     216 Min:      20 Act:      24 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     228 Min:      20 Act:      23 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     240 Min:      20 Act:      23 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     252 Min:      20 Act:      23 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     264 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     276 Min:      20 Act:      26 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     288 Min:      20 Act:      24 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     300 Min:      20 Act:      23 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     312 Min:      20 Act:      23 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     325 Min:      20 Act:      21 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     336 Min:      20 Act:      23 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     348 Min:      20 Act:      23 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     360 Min:      20 Act:      23 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     372 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     384 Min:      20 Act:      22 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     396 Min:      20 Act:      21 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     408 Min:      20 Act:      23 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     420 Min:      20 Act:      21 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     432 Min:      20 Act:      22 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     444 Min:      20 Act:      22 Avg:     =
 24 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     456 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     469 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     480 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     493 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     505 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     516 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     528 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     540 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     554 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     569 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     581 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     594 Min:      20 Act:      40 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     608 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     621 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     633 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     644 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     657 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     670 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     684 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     696 Min:      20 Act:      25 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     709 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     721 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     733 Min:      20 Act:      23 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     745 Min:      20 Act:      23 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     756 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     769 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     780 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     793 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     804 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     817 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     829 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     840 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     852 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     864 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     876 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     889 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     900 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     914 Min:      20 Act:      46 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     928 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     940 Min:      20 Act:      21 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 5/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     952 Min:      20 Act:      23 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     964 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 2/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     976 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:     988 Min:      20 Act:      22 Avg:     =
 23 Max:      58
=1B[3A1.22 1.10 0.85 3/88 23511=20=20=20=20=20=20=20=20=20=20

T: 0 (23511) P:10 I:    1000 C:    1000 Min:      20 Act:      21 Avg:     =
 23 Max:      58

Mon Nov 27 11:31:00 CET 2006
running: cat /proc/interrupts
           CPU0=20=20=20=20=20=20=20
  0:     504056    IO-APIC-edge  timer, rthal_broadcast_timer
  8:          3    IO-APIC-edge  rtc
  9:          1   IO-APIC-level  acpi
 14:      13090    IO-APIC-edge  ide0
 15:      34195    IO-APIC-edge  ide1
169:      32190   IO-APIC-level  uhci_hcd:usb1
177:       7443   IO-APIC-level  uhci_hcd:usb2
185:       1004   IO-APIC-level  eth0
193:          0   IO-APIC-level  Intel 82801BA-ICH2
201:     168188   IO-APIC-level  r128@domain.hid
NMI:          0=20
LOC:     504005=20
ERR:          0
MIS:          0

Mon Nov 27 11:31:00 CET 2006
running: cat /proc/loadavg
1.22 1.10 0.85 6/83 23523

Mon Nov 27 11:31:00 CET 2006
running: cat /proc/meminfo
MemTotal:       515928 kB
MemFree:        240580 kB
Buffers:         47512 kB
Cached:         138884 kB
SwapCached:          0 kB
Active:         155052 kB
Inactive:        92456 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       515928 kB
LowFree:        240580 kB
SwapTotal:     2048276 kB
SwapFree:      2048276 kB
Dirty:             232 kB
Writeback:           0 kB
Mapped:          87756 kB
Slab:            13324 kB
CommitLimit:   2306240 kB
Committed_AS:   105096 kB
PageTables:       1288 kB
VmallocTotal:   507896 kB
VmallocUsed:      7280 kB
VmallocChunk:   499700 kB

Mon Nov 27 11:31:00 CET 2006
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:       227986    (lostage_handler)
  2:            8    (registry_export)
  3:            0    (posix_signals_handler)

Mon Nov 27 11:31:00 CET 2006
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:            0    (Divide error)
  1:            0    (Debug)
  3:            0    (Int3)
  4:            0    (Overflow)
  5:            0    (Bounds)
  6:            0    (Invalid opcode)
  7:            2    (FPU not available)
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

Mon Nov 27 11:31:00 CET 2006
running: cat /proc/xenomai/hal
1.5-02

Mon Nov 27 11:31:01 CET 2006
running: cat /proc/xenomai/heap
size=3D130560:used=3D64:pagesz=3D512

Mon Nov 27 11:31:01 CET 2006
running: cat /proc/xenomai/irq
IRQ         CPU0
216:     2626532         [timer]
258:     1156405         [virtual]

Mon Nov 27 11:31:01 CET 2006
running: cat /proc/xenomai/latency
2514

Mon Nov 27 11:31:01 CET 2006
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT

Mon Nov 27 11:31:01 CET 2006
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          3211243    0     01400080   74.1  ROOT
  0  0      0          2626532    0     00000000    7.8  IRQ216: [timer]

Mon Nov 27 11:31:01 CET 2006
running: cat /proc/xenomai/timer
status=3Doneshot:setup=3D838:tickval=3D1:jiffies=3D3808818512180

Mon Nov 27 11:31:01 CET 2006
running: cat /proc/xenomai/version
2.3-rc2

Mon Nov 27 11:31:01 CET 2006
running: cat /proc/xenomai/interfaces/core
0

Mon Nov 27 11:31:01 CET 2006
running: cat /proc/xenomai/interfaces/native
0

Mon Nov 27 11:31:01 CET 2006
running: cat /proc/xenomai/interfaces/posix
0

Mon Nov 27 11:31:02 CET 2006
running: cat /proc/xenomai/interfaces/rtdm
0

Mon Nov 27 11:31:02 CET 2006
running: cat /proc/xenomai/rtdm/fildes
total=3D128:open=3D0:free=3D128

Mon Nov 27 11:31:02 CET 2006
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				/proc
D6	rttest0                        	rttest0
D7	rttest1                        	rttest1
D8	rttest2                        	rttest2

Mon Nov 27 11:31:02 CET 2006
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device

Mon Nov 27 11:31:02 CET 2006
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	/proc

Mon Nov 27 11:31:02 CET 2006
running: top -bn1c
top - 11:31:03 up 33 min,  3 users,  load average: 1.36, 1.13, 0.86
Tasks:  84 total,   2 running,  82 sleeping,   0 stopped,   0 zombie
Cpu(s): 23.0% us, 37.9% sy,  0.0% ni, 36.5% id,  2.6% wa,  0.0% hi,  0.0% si
Mem:    515928k total,   275596k used,   240332k free,    47628k buffers
Swap:  2048276k total,        0k used,  2048276k free,   138892k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND=20=20=
=20=20=20=20=20=20=20=20=20=20
22995 root      25   0  2788  756  560 R 95.1  0.1   8:37.06 dd if /dev/zer=
o of=20
 4180 haldaemo  16   0  2012  864  760 S  2.0  0.2   0:00.25 /usr/lib/hal/h=
ald-a
 4602 busenham  16   0 14372  10m 4148 S  2.0  2.0   0:09.22 emacs doc/Xeno=
mai_I
22995 pts/1    00:08:37 dd
xeno-test: finished

--_----------=_1164872122233272
Content-Disposition: attachment; filename="proc_xenomai.txt"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; name="proc_xenomai.txt"

/proc/xenomai/rtdm/rttest0/information
driver:		xeno_irqbench
version:	0.1.1
peripheral:	IRQ Latency Benchmark
provider:	Jan Kiszka
class:		6
sub-class:	1
flags:		NAMED_DEVICE=20=20
lock count:	0
/proc/xenomai/rtdm/fildes
total=3D128:open=3D0:free=3D128
/proc/xenomai/rtdm/open_fildes
Index	Locked	Device
/proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	/proc
/proc/xenomai/rtdm/named_devices
Hash	Name				/proc
D6	rttest0                        	rttest0
/proc/xenomai/interfaces/rtdm
0
/proc/xenomai/interfaces/posix
0
/proc/xenomai/interfaces/native
0
/proc/xenomai/interfaces/core
0
/proc/xenomai/heap
size=3D130560:used=3D64:pagesz=3D512
/proc/xenomai/irq
IRQ         CPU0
216:     1314284         [timer]
258:      577695         [virtual]
/proc/xenomai/timer
status=3Doneshot:setup=3D838:tickval=3D1:jiffies=3D3555886796817
/proc/xenomai/version
2.3-rc2
/proc/xenomai/latency
2514
/proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          1606360    0     01400080  100.0  ROOT
  0  0      0          1314284    0     00000000    0.0  IRQ216: [timer]
/proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT
/proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:       113881    (lostage_handler)
  2:            4    (registry_export)
  3:            0    (posix_signals_handler)
/proc/xenomai/faults
TRAP         CPU0
  0:            0    (Divide error)
  1:            0    (Debug)
  3:            0    (Int3)
  4:            0    (Overflow)
  5:            0    (Bounds)
  6:            0    (Invalid opcode)
  7:            1    (FPU not available)
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
/proc/xenomai/hal
1.5-02

--_----------=_1164872122233272--


