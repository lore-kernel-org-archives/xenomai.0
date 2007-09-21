Message-ID: <OF3EF80531.231E36EB-ONC125735D.002FAC4D-C125735D.0032AD8D@datacon.at>
From: juergen.lanner@domain.hid
Date: Fri, 21 Sep 2007 11:13:55 +0200
MIME-Version: 1.0
Content-type: multipart/related; 
	Boundary="0__=4EBBF9CEDFBC2ADD8f9e8a93df938690918c4EBBF9CEDFBC2ADD"
Subject: [Xenomai-help] POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled
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

--0__=4EBBF9CEDFBC2ADD8f9e8a93df938690918c4EBBF9CEDFBC2ADD
Content-type: multipart/alternative; 
	Boundary="1__=4EBBF9CEDFBC2ADD8f9e8a93df938690918c4EBBF9CEDFBC2ADD"

--1__=4EBBF9CEDFBC2ADD8f9e8a93df938690918c4EBBF9CEDFBC2ADD
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



Hi there!

Sorry for the newbie question, but I am stuck here ...
I get this message every time I try to run e.g. latency test on my syst=
em.

What do I wrong?

I use
Ubuntu 7.04 desktop
Kernel 2.6.20.19 from www.kernel.org
Xenomai 2.3.3
adeos-ipipe-2.6.20-i386-1.8-08.patch

I already saw Jan's advice to Vicki (feb 12th, 2007) but didn't help.

The setting in .config seem (imho) correct
CONFIG_XENOMAI=3Dy
CONFIG_XENO_OPT_NUCLEUS=3Dy
CONFIG_XENO_OPT_PERVASIVE=3Dy
...
#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=3Dy
CONFIG_XENO_OPT_NATIVE_PIPE=3Dy
...
CONFIG_XENO_SKIN_POSIX=3Dy
...


According to /proc/xenomai everything seems fine.

root@domain.hid# ls /proc/xenomai/
apc  faults  hal  heap  interfaces  irq  latency  registry  rtdm  sched=

stat  timer  version
root@domain.hid# ls /proc/xenomai/interfaces/
native  posix  rtdm  sys



Maybe I did something wrong during installation?

modprobe xeno_native yields that there is no such module.
But how do I load the module?
xeno-load wants some .runinfo file which I could not find anywhere in t=
he
xenomai directory.


Thanks in advance!

juergen




PS: Running xeno-test gives following output.
I think there is all the debug/system information available...


root@domain.hid# xeno-test
xeno-test: started
withBusybox is 0
xeno-test: running tests

Fri Sep 21 10:54:47 CEST 2007
running: /usr/xenomai/bin/xeno-config --verbose
xeno-config --verbose
    --version=3D"2.3.3"
    --cc=3D"gcc"
    --arch=3D"i386"
    --prefix=3D"/usr/xenomai"
    --xeno-cflags=3D"-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-D__XENO__"
    --xeno-ldflags=3D"-L/usr/xenomai/lib -lpthread "
    --posix-cflags=3D"-I/usr/xenomai/include -I/usr/xenomai/include/pos=
ix
-D_GNU_SOURCE -D_REENTRANT -D__XENO__"
    --posix-ldflags=3D"-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "=

    --library-dir=3D"/usr/xenomai/lib"

Fri Sep 21 10:54:47 CEST 2007
running: /usr/xenomai/bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux gncu-desktop 2.6.20.19-custom-adeos-xenomai2.3.0 #1 SMP Thu Sep 2=
0
14:07:48 CEST 2007 i686 GNU/Linux

Gnu C                  4.1.2
Gnu make               3.81
util-linux             2.12r
mount                  2.12r
module-init-tools      3.3-pre2
e2fsprogs              1.40-WIP
PPP                    2.4.4
Linux C Library        > libc.2.5
Dynamic linker (ldd)   2.5
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
Modules Loaded         nls_iso8859_1 nls_cp437 vfat fat binfmt_misc rfc=
omm
l2cap bluetooth i915 drm ppdev capability commoncap ipv6 parport_pc lp
parport fuse sg sd_mod serio_raw psmouse intel_agp agpgart shpchp
pci_hotplug af_packet evdev ext3 jbd mbcache ide_disk ata_generic ata_p=
iix
libata usb_storage scsi_mod libusual piix e100 mii generic ehci_hcd
uhci_hcd usbcore

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Mobile Genuine Intel(R) processor       1100MHz
stepping        : 5
cpu MHz         : 897.137
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca =
cmov
pat clflush dts acpi mmx fxsr sse sse2 tm pbe up est tm2
bogomips        : 1794.79
clflush size    : 64


Fri Sep 21 10:54:48 CEST 2007
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
30428c81001e2b353139beb5d4c58f78  /proc/cpuinfo
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=3Dy
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=3Dy
CONFIG_IPIPE=3Dy
# CONFIG_PM is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_IPIPE_DEBUG is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set

Fri Sep 21 10:54:48 CEST 2007
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
   3:  A.L..
   4:  A.L..
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
  16:  A....
  17:  A....
  18:  A....
  19:  A....
  20:  A....
  21:  A....
  22:  A....
  23:  A....
  24:  A....
  25:  A....
  26:  A....
  27:  A....
  28:  A....
  29:  A....
  30:  A....
  31:  A....
  32:  A....
  33:  A....
  34:  A....
  35:  A....
  36:  A....
  37:  A....
  38:  A....
  39:  A....
  40:  A....
  41:  A....
  42:  A....
  43:  A....
  44:  A....
  45:  A....
  46:  A....
  47:  A....
  48:  A....
  49:  A....
  50:  A....
  51:  A....
  52:  A....
  53:  A....
  54:  A....
  55:  A....
  56:  A....
  57:  A....
  58:  A....
  59:  A....
  60:  A....
  61:  A....
  62:  A....
  63:  A....
  64:  A....
  65:  A....
  66:  A....
  67:  A....
  68:  A....
  69:  A....
  70:  A....
  71:  A....
  72:  A....
  73:  A....
  74:  A....
  75:  A....
  76:  A....
  77:  A....
  78:  A....
  79:  A....
  80:  A....
  81:  A....
  82:  A....
  83:  A....
  84:  A....
  85:  A....
  86:  A....
  87:  A....
  88:  A....
  89:  A....
  90:  A....
  91:  A....
  92:  A....
  93:  A....
  94:  A....
  95:  A....
  96:  A....
  97:  A....
  98:  A....
  99:  A....
 100:  A....
 101:  A....
 102:  A....
 103:  A....
 104:  A....
 105:  A....
 106:  A....
 107:  A....
 108:  A....
 109:  A....
 110:  A....
 111:  A....
 112:  A....
 113:  A....
 114:  A....
 115:  A....
 116:  A....
 117:  A....
 118:  A....
 119:  A....
 120:  A....
 121:  A....
 122:  A....
 123:  A....
 124:  A....
 125:  A....
 126:  A....
 127:  A....
 128:  A....
 129:  A....
 130:  A....
 131:  A....
 132:  A....
 133:  A....
 134:  A....
 135:  A....
 136:  A....
 137:  A....
 138:  A....
 139:  A....
 140:  A....
 141:  A....
 142:  A....
 143:  A....
 144:  A....
 145:  A....
 146:  A....
 147:  A....
 148:  A....
 149:  A....
 150:  A....
 151:  A....
 152:  A....
 153:  A....
 154:  A....
 155:  A....
 156:  A....
 157:  A....
 158:  A....
 159:  A....
 160:  A....
 161:  A....
 162:  A....
 163:  A....
 164:  A....
 165:  A....
 166:  A....
 167:  A....
 168:  A....
 169:  A....
 170:  A....
 171:  A....
 172:  A....
 173:  A....
 174:  A....
 175:  A....
 176:  A....
 177:  A....
 178:  A....
 179:  A....
 180:  A....
 181:  A....
 182:  A....
 183:  A....
 184:  A....
 185:  A....
 186:  A....
 187:  A....
 188:  A....
 189:  A....
 190:  A....
 191:  A....
 192:  A....
 193:  A....
 194:  A....
 195:  A....
 196:  A....
 197:  A....
 198:  A....
 199:  A....
 200:  A....
 201:  A....
 202:  A....
 203:  A....
 204:  A....
 205:  A....
 206:  A....
 207:  A....
 208:  A....
 209:  A....
 210:  A....
 211:  A....
 212:  A....
 213:  A....
 214:  A....
 215:  A....
 216:  A....
 217:  A....
 218:  A....
 219:  A....
 220:  A....
 221:  A....
 222:  A....
 223:  A....
 224:  A....
 230:  A....
 231:  A....
 232:  A....
 233:  A....
 234:  GS...
 236:  A....
 237:  A....
 238:  A....
 239:  A....
 240:  A....
 256:  G...V
 257:  G...V
[Domain info]
id=3D0x00000000
priority=3D100

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/ipipe/Xenomai
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
 230:  W....
 233:  W..X.
 234:  GS...
 258:  W...V
[Domain info]
id=3D0x58454e4f
priority=3Dtopmost

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/ipipe/version
1.8-08

Fri Sep 21 10:54:48 CEST 2007
running: generate_loads 1
eval: 1: arith: syntax error: "jobsct-1"
cleanup_load: no dd_jobs found

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/interrupts
           CPU0
  0:    7243712    XT-PIC-XT        timer, rthal_broadcast_timer
  1:         30    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  5:     544285    XT-PIC-XT        uhci_hcd:usb1, eth3,
i915@domain.hid
  7:      18259    XT-PIC-XT        ehci_hcd:usb3
  8:          3    XT-PIC-XT        rtc
  9:   17584667    XT-PIC-XT        eth0
 12:        196    XT-PIC-XT        i8042
 14:      10992    XT-PIC-XT        ide0
 15:       7236    XT-PIC-XT        uhci_hcd:usb2, eth1, eth2
NMI:       3198
LOC:    7243618
ERR:          0
MIS:          0

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/loadavg
0.19 0.16 0.16 3/116 13945

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/meminfo
MemTotal:       506576 kB
MemFree:        175296 kB
Buffers:         15676 kB
Cached:         145256 kB
SwapCached:          0 kB
Active:         156200 kB
Inactive:        93720 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       506576 kB
LowFree:        175296 kB
SwapTotal:     1477940 kB
SwapFree:      1477940 kB
Dirty:              64 kB
Writeback:           0 kB
AnonPages:       89004 kB
Mapped:          46844 kB
Slab:            17244 kB
SReclaimable:     6468 kB
SUnreclaim:      10776 kB
PageTables:       1904 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   1731228 kB
Committed_AS:   403968 kB
VmallocTotal:   516088 kB
VmallocUsed:      4288 kB
VmallocChunk:   511604 kB

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:            0    (lostage_handler)
  2:            0    (registry_export)
  3:            0    (posix_signals_handler)

Fri Sep 21 10:54:48 CEST 2007
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

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/hal
1.8-08

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/heap
size=3D130560:used=3D64:pagesz=3D512

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/irq
IRQ         CPU0
230:           0
233:       14482         [timer]
234:           0
258:           0         [virtual]

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/latency
2699

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT/0

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          0          0     00500080  100.0  ROOT/0
  0  0      0          14482      0     00000000    0.0  IRQ233: [timer=
]

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/timer
status=3Doneshot+watchdog:setup=3D84:tickval=3D1:jiffies=3D725985499253=
2

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/version
2.3.3

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/interfaces/native
0

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/interfaces/posix
0

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/interfaces/rtdm
0

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/interfaces/sys
0

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/rtdm/fildes
total=3D128:open=3D0:free=3D128

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/rtdm/named_devices
Hash    Name                            Driver          /proc

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/rtdm/open_fildes
Index   Locked  Device

Fri Sep 21 10:54:48 CEST 2007
running: cat /proc/xenomai/rtdm/protocol_devices
Hash    ProtocolFamily:SocketType       Driver          /proc

Fri Sep 21 10:54:48 CEST 2007
running: top -bn1c
top - 10:54:48 up  2:00,  2 users,  load average: 0.19, 0.16, 0.16
Tasks: 106 total,   1 running, 105 sleeping,   0 stopped,   0 zombie
Cpu(s):  9.8%us,  2.9%sy,  0.0%ni, 84.2%id,  2.6%wa,  0.0%hi,  0.5%si,
0.0%st
Mem:    506576k total,   331280k used,   175296k free,    15676k buffer=
s
Swap:  1477940k total,        0k used,  1477940k free,   145256k cached=


  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 8702 gncu      15   0 35504  12m  10m S 15.6  2.5  14:12.39
/usr/lib/vino/vino-
14006 root      21   0  2312 1056  792 R  1.9  0.2   0:00.01 top -bn1c
    1 root      15   0  2908 1844  524 S  0.0  0.4   0:01.60 /sbin/init=


Fri Sep 21 10:54:48 CEST 2007
running: ./run -- -sh -T 120 -t0 # latency
*
*
* Type ^C to stop this application.
*
*
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)

Fri Sep 21 10:54:49 CEST 2007
running: ./run -- -sh -T 120 -t1 # latency
*
*
* Type ^C to stop this application.
*
*
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)

Fri Sep 21 10:54:50 CEST 2007
running: ./run -- -sh -T 120 -t2 # latency
*
*
* Type ^C to stop this application.
*
*
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)

Fri Sep 21 10:54:50 CEST 2007
running: ./run -- -T 120 # switchtest
*
*
* Type ^C to stop this application.
*
*
Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_posix?)

Fri Sep 21 10:54:50 CEST 2007
running: ./run -- -h # switchbench
*
*
* Type ^C to stop this application.
*
*
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)

Fri Sep 21 10:54:51 CEST 2007
running: ./run -- -p 10 -n -l 1000 # cyclictest
*
*
* Type ^C to stop this application.
*
*
Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_posix?)

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/interrupts
           CPU0
  0:    7247076    XT-PIC-XT        timer, rthal_broadcast_timer
  1:         30    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  5:     544540    XT-PIC-XT        uhci_hcd:usb1, eth3,
i915@domain.hid
  7:      18263    XT-PIC-XT        ehci_hcd:usb3
  8:          3    XT-PIC-XT        rtc
  9:   17593022    XT-PIC-XT        eth0
 12:        196    XT-PIC-XT        i8042
 14:      11257    XT-PIC-XT        ide0
 15:       7239    XT-PIC-XT        uhci_hcd:usb2, eth1, eth2
NMI:       3201
LOC:    7246981
ERR:          0
MIS:          0

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/loadavg
0.41 0.21 0.18 6/116 14519

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/meminfo
MemTotal:       506576 kB
MemFree:        174908 kB
Buffers:         16000 kB
Cached:         145268 kB
SwapCached:          0 kB
Active:         156216 kB
Inactive:        94040 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       506576 kB
LowFree:        174908 kB
SwapTotal:     1477940 kB
SwapFree:      1477940 kB
Dirty:               8 kB
Writeback:           0 kB
AnonPages:       89004 kB
Mapped:          46840 kB
Slab:            17324 kB
SReclaimable:     6488 kB
SUnreclaim:      10836 kB
PageTables:       1932 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   1731228 kB
Committed_AS:   403968 kB
VmallocTotal:   516088 kB
VmallocUsed:      4288 kB
VmallocChunk:   511604 kB

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:            0    (lostage_handler)
  2:            0    (registry_export)
  3:            0    (posix_signals_handler)

Fri Sep 21 10:54:51 CEST 2007
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

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/hal
1.8-08

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/heap
size=3D130560:used=3D64:pagesz=3D512

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/irq
IRQ         CPU0
230:           0
233:       14488         [timer]
234:           0
258:           0         [virtual]

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/latency
2699

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT/0

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          0          0     00500080  100.0  ROOT/0
  0  0      0          14488      0     00000000    0.0  IRQ233: [timer=
]

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/timer
status=3Doneshot+watchdog:setup=3D84:tickval=3D1:jiffies=3D726318776804=
2

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/version
2.3.3

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/interfaces/native
0

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/interfaces/posix
0

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/interfaces/rtdm
0

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/interfaces/sys
0

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/rtdm/fildes
total=3D128:open=3D0:free=3D128

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/rtdm/named_devices
Hash    Name                            Driver          /proc

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/rtdm/open_fildes
Index   Locked  Device

Fri Sep 21 10:54:51 CEST 2007
running: cat /proc/xenomai/rtdm/protocol_devices
Hash    ProtocolFamily:SocketType       Driver          /proc

Fri Sep 21 10:54:51 CEST 2007
running: top -bn1c
top - 10:54:52 up  2:00,  2 users,  load average: 0.41, 0.21, 0.18
Tasks: 106 total,   1 running, 105 sleeping,   0 stopped,   0 zombie
Cpu(s):  9.8%us,  2.9%sy,  0.0%ni, 84.1%id,  2.6%wa,  0.0%hi,  0.5%si,
0.0%st
Mem:    506576k total,   331668k used,   174908k free,    16000k buffer=
s
Swap:  1477940k total,        0k used,  1477940k free,   145268k cached=


  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 8702 gncu      15   0 35504  12m  10m S 13.5  2.5  14:12.88
/usr/lib/vino/vino-
14580 root      21   0  2316 1060  792 R  3.9  0.2   0:00.02 top -bn1c
    1 root      15   0  2908 1844  524 S  0.0  0.4   0:01.60 /sbin/init=

cleanup_load: no dd_jobs found
xeno-test: finished
root@domain.hid#















Juergen Lanner
Software Development
Datacon Technology GmbH
Tel.: +43 5337 600-403
www.datacon.at

IMPORTANT: The contents of this email and any attachments are confident=
ial.
They are intended for the named recipient(s) only.
If you have received this email in error, please notify the system mana=
ger
or the sender immediately and do not disclose the contents to anyone or=

make copies thereof.
=

--1__=4EBBF9CEDFBC2ADD8f9e8a93df938690918c4EBBF9CEDFBC2ADD
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font face=3D"Arial">Hi there!</font><br>
<br>
<font face=3D"Arial">Sorry for the newbie question, but I am stuck here=
 ...</font><br>
<font face=3D"Arial">I get this message every time I try to run e.g. la=
tency test on my system.</font><br>
<br>
<font face=3D"Arial">What do I wrong?</font><br>
<br>
<font face=3D"Arial">I use </font><br>
<font face=3D"Arial">Ubuntu 7.04 desktop </font><br>
<font face=3D"Arial">Kernel 2.6.20.19 from www.kernel.org</font><br>
<font face=3D"Arial">Xenomai 2.3.3</font><br>
<font face=3D"Arial">adeos-ipipe-2.6.20-i386-1.8-08.patch</font><br>
<br>
<font face=3D"Arial">I already saw Jan's advice to Vicki (feb 12th, 200=
7) but didn't help.</font><br>
<br>
<font face=3D"Arial">The setting in .config seem (imho) correct</font><=
br>
<font face=3D"Arial">CONFIG_XENOMAI=3Dy</font><br>
<font face=3D"Arial">CONFIG_XENO_OPT_NUCLEUS=3Dy</font><br>
<font face=3D"Arial">CONFIG_XENO_OPT_PERVASIVE=3Dy</font><br>
<font face=3D"Arial">...</font><br>
<font face=3D"Arial">#</font><br>
<font face=3D"Arial"># Interfaces</font><br>
<font face=3D"Arial">#</font><br>
<font face=3D"Arial">CONFIG_XENO_SKIN_NATIVE=3Dy</font><br>
<font face=3D"Arial">CONFIG_XENO_OPT_NATIVE_PIPE=3Dy</font><br>
<font face=3D"Arial">...</font><br>
<font face=3D"Arial">CONFIG_XENO_SKIN_POSIX=3Dy</font><br>
<font face=3D"Arial">...</font><br>
<br>
<br>
<font face=3D"Arial">According to /proc/xenomai everything seems fine.<=
/font><br>
<br>
<font face=3D"Arial">root@domain.hid# ls /proc/xenomai/</fon=
t><br>
<font face=3D"Arial">apc  faults  hal  heap  interfaces  irq  latency  =
registry  rtdm  sched  stat  timer  version</font><br>
<font face=3D"Arial">root@domain.hid# ls /proc/xenomai/inter=
faces/</font><br>
<font face=3D"Arial">native  posix  rtdm  sys</font><br>
<br>
<br>
<br>
<font face=3D"Arial">Maybe I did something wrong during installation?</=
font><br>
<br>
<font face=3D"Arial">modprobe xeno_native yields that there is no such =
module.</font><br>
<font face=3D"Arial">But how do I load the module?</font><br>
<font face=3D"Arial">xeno-load wants some .runinfo file which I could n=
ot find anywhere in the xenomai directory.</font><br>
<br>
<br>
<font face=3D"Arial">Thanks in advance!</font><br>
<br>
<font face=3D"Arial">juergen</font><br>
<br>
<br>
<br>
<br>
<font face=3D"Arial">PS: Running xeno-test gives following output.</fon=
t><br>
<font face=3D"Arial">I think there is all the debug/system information =
available...</font><br>
<br>
<br>
<font face=3D"Arial">root@domain.hid# xeno-test</font><br>
<font face=3D"Arial">xeno-test: started</font><br>
<font face=3D"Arial">withBusybox is 0</font><br>
<font face=3D"Arial">xeno-test: running tests</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:47 CEST 2007</font><br>
<font face=3D"Arial">running: /usr/xenomai/bin/xeno-config --verbose</f=
ont><br>
<font face=3D"Arial">xeno-config --verbose</font><br>
<font face=3D"Arial">    --version=3D&quot;2.3.3&quot;</font><br>
<font face=3D"Arial">    --cc=3D&quot;gcc&quot;</font><br>
<font face=3D"Arial">    --arch=3D&quot;i386&quot;</font><br>
<font face=3D"Arial">    --prefix=3D&quot;/usr/xenomai&quot;</font><br>=

<font face=3D"Arial">    --xeno-cflags=3D&quot;-I/usr/xenomai/include -=
D_GNU_SOURCE -D_REENTRANT -D__XENO__&quot;</font><br>
<font face=3D"Arial">    --xeno-ldflags=3D&quot;-L/usr/xenomai/lib -lpt=
hread &quot;</font><br>
<font face=3D"Arial">    --posix-cflags=3D&quot;-I/usr/xenomai/include =
-I/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__&quot=
;</font><br>
<font face=3D"Arial">    --posix-ldflags=3D&quot;-L/usr/xenomai/lib -lp=
thread_rt -lpthread -lrt &quot;</font><br>
<font face=3D"Arial">    --library-dir=3D&quot;/usr/xenomai/lib&quot;</=
font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:47 CEST 2007</font><br>
<font face=3D"Arial">running: /usr/xenomai/bin/xeno-info</font><br>
<font face=3D"Arial">If some fields are empty or look unusual you may h=
ave an old version.</font><br>
<font face=3D"Arial">Compare to the current minimal requirements in Doc=
umentation/Changes.</font><br>
<br>
<font face=3D"Arial">Linux gncu-desktop 2.6.20.19-custom-adeos-xenomai2=
.3.0 #1 SMP Thu Sep 20 14:07:48 CEST 2007 i686 GNU/Linux</font><br>
<br>
<font face=3D"Arial">Gnu C                  4.1.2</font><br>
<font face=3D"Arial">Gnu make               3.81</font><br>
<font face=3D"Arial">util-linux             2.12r</font><br>
<font face=3D"Arial">mount                  2.12r</font><br>
<font face=3D"Arial">module-init-tools      3.3-pre2</font><br>
<font face=3D"Arial">e2fsprogs              1.40-WIP</font><br>
<font face=3D"Arial">PPP                    2.4.4</font><br>
<font face=3D"Arial">Linux C Library        &gt; libc.2.5</font><br>
<font face=3D"Arial">Dynamic linker (ldd)   2.5</font><br>
<font face=3D"Arial">Procps                 3.2.7</font><br>
<font face=3D"Arial">Net-tools              1.60</font><br>
<font face=3D"Arial">Console-tools          0.2.3</font><br>
<font face=3D"Arial">Sh-utils               5.97</font><br>
<font face=3D"Arial">Modules Loaded         nls_iso8859_1 nls_cp437 vfa=
t fat binfmt_misc rfcomm l2cap bluetooth i915 drm ppdev capability comm=
oncap ipv6 parport_pc lp parport fuse sg sd_mod serio_raw psmouse intel=
_agp agpgart shpchp pci_hotplug af_packet evdev ext3 jbd mbcache ide_di=
sk ata_generic ata_piix libata usb_storage scsi_mod libusual piix e100 =
mii generic ehci_hcd uhci_hcd usbcore</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/cpuinfo</font><br>
<font face=3D"Arial">processor       : 0</font><br>
<font face=3D"Arial">vendor_id       : GenuineIntel</font><br>
<font face=3D"Arial">cpu family      : 6</font><br>
<font face=3D"Arial">model           : 9</font><br>
<font face=3D"Arial">model name      : Mobile Genuine Intel(R) processo=
r       1100MHz</font><br>
<font face=3D"Arial">stepping        : 5</font><br>
<font face=3D"Arial">cpu MHz         : 897.137</font><br>
<font face=3D"Arial">cache size      : 1024 KB</font><br>
<font face=3D"Arial">fdiv_bug        : no</font><br>
<font face=3D"Arial">hlt_bug         : no</font><br>
<font face=3D"Arial">f00f_bug        : no</font><br>
<font face=3D"Arial">coma_bug        : no</font><br>
<font face=3D"Arial">fpu             : yes</font><br>
<font face=3D"Arial">fpu_exception   : yes</font><br>
<font face=3D"Arial">cpuid level     : 2</font><br>
<font face=3D"Arial">wp              : yes</font><br>
<font face=3D"Arial">flags           : fpu vme de pse tsc msr mce cx8 a=
pic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 tm pbe=
 up est tm2</font><br>
<font face=3D"Arial">bogomips        : 1794.79</font><br>
<font face=3D"Arial">clflush size    : 64</font><br>
<br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: md5sum /proc/cpuinfo # cpuinfo fingerprin=
t</font><br>
<font face=3D"Arial">30428c81001e2b353139beb5d4c58f78  /proc/cpuinfo</f=
ont><br>
<font face=3D"Arial"># CONFIG_PREEMPT_NONE is not set</font><br>
<font face=3D"Arial">CONFIG_PREEMPT_VOLUNTARY=3Dy</font><br>
<font face=3D"Arial"># CONFIG_PREEMPT is not set</font><br>
<font face=3D"Arial">CONFIG_PREEMPT_BKL=3Dy</font><br>
<font face=3D"Arial">CONFIG_IPIPE=3Dy</font><br>
<font face=3D"Arial"># CONFIG_PM is not set</font><br>
<font face=3D"Arial"># CONFIG_CPU_FREQ is not set</font><br>
<font face=3D"Arial"># CONFIG_IPIPE_DEBUG is not set</font><br>
<font face=3D"Arial"># CONFIG_DEBUG_SPINLOCK is not set</font><br>
<font face=3D"Arial"># CONFIG_DEBUG_SPINLOCK_SLEEP is not set</font><br=
>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/ipipe/Linux</font><br>
<font face=3D"Arial">       +----- Handling ([A]ccepted, [G]rabbed, [W]=
ired, [D]iscarded)</font><br>
<font face=3D"Arial">       |+---- Sticky</font><br>
<font face=3D"Arial">       ||+--- Locked</font><br>
<font face=3D"Arial">       |||+-- Exclusive</font><br>
<font face=3D"Arial">       ||||+- Virtual</font><br>
<font face=3D"Arial">[IRQ]  |||||</font><br>
<font face=3D"Arial">   0:  A....</font><br>
<font face=3D"Arial">   1:  A....</font><br>
<font face=3D"Arial">   2:  A....</font><br>
<font face=3D"Arial">   3:  A.L..</font><br>
<font face=3D"Arial">   4:  A.L..</font><br>
<font face=3D"Arial">   5:  A....</font><br>
<font face=3D"Arial">   6:  A....</font><br>
<font face=3D"Arial">   7:  A....</font><br>
<font face=3D"Arial">   8:  A....</font><br>
<font face=3D"Arial">   9:  A....</font><br>
<font face=3D"Arial">  10:  A....</font><br>
<font face=3D"Arial">  11:  A....</font><br>
<font face=3D"Arial">  12:  A....</font><br>
<font face=3D"Arial">  13:  A....</font><br>
<font face=3D"Arial">  14:  A....</font><br>
<font face=3D"Arial">  15:  A....</font><br>
<font face=3D"Arial">  16:  A....</font><br>
<font face=3D"Arial">  17:  A....</font><br>
<font face=3D"Arial">  18:  A....</font><br>
<font face=3D"Arial">  19:  A....</font><br>
<font face=3D"Arial">  20:  A....</font><br>
<font face=3D"Arial">  21:  A....</font><br>
<font face=3D"Arial">  22:  A....</font><br>
<font face=3D"Arial">  23:  A....</font><br>
<font face=3D"Arial">  24:  A....</font><br>
<font face=3D"Arial">  25:  A....</font><br>
<font face=3D"Arial">  26:  A....</font><br>
<font face=3D"Arial">  27:  A....</font><br>
<font face=3D"Arial">  28:  A....</font><br>
<font face=3D"Arial">  29:  A....</font><br>
<font face=3D"Arial">  30:  A....</font><br>
<font face=3D"Arial">  31:  A....</font><br>
<font face=3D"Arial">  32:  A....</font><br>
<font face=3D"Arial">  33:  A....</font><br>
<font face=3D"Arial">  34:  A....</font><br>
<font face=3D"Arial">  35:  A....</font><br>
<font face=3D"Arial">  36:  A....</font><br>
<font face=3D"Arial">  37:  A....</font><br>
<font face=3D"Arial">  38:  A....</font><br>
<font face=3D"Arial">  39:  A....</font><br>
<font face=3D"Arial">  40:  A....</font><br>
<font face=3D"Arial">  41:  A....</font><br>
<font face=3D"Arial">  42:  A....</font><br>
<font face=3D"Arial">  43:  A....</font><br>
<font face=3D"Arial">  44:  A....</font><br>
<font face=3D"Arial">  45:  A....</font><br>
<font face=3D"Arial">  46:  A....</font><br>
<font face=3D"Arial">  47:  A....</font><br>
<font face=3D"Arial">  48:  A....</font><br>
<font face=3D"Arial">  49:  A....</font><br>
<font face=3D"Arial">  50:  A....</font><br>
<font face=3D"Arial">  51:  A....</font><br>
<font face=3D"Arial">  52:  A....</font><br>
<font face=3D"Arial">  53:  A....</font><br>
<font face=3D"Arial">  54:  A....</font><br>
<font face=3D"Arial">  55:  A....</font><br>
<font face=3D"Arial">  56:  A....</font><br>
<font face=3D"Arial">  57:  A....</font><br>
<font face=3D"Arial">  58:  A....</font><br>
<font face=3D"Arial">  59:  A....</font><br>
<font face=3D"Arial">  60:  A....</font><br>
<font face=3D"Arial">  61:  A....</font><br>
<font face=3D"Arial">  62:  A....</font><br>
<font face=3D"Arial">  63:  A....</font><br>
<font face=3D"Arial">  64:  A....</font><br>
<font face=3D"Arial">  65:  A....</font><br>
<font face=3D"Arial">  66:  A....</font><br>
<font face=3D"Arial">  67:  A....</font><br>
<font face=3D"Arial">  68:  A....</font><br>
<font face=3D"Arial">  69:  A....</font><br>
<font face=3D"Arial">  70:  A....</font><br>
<font face=3D"Arial">  71:  A....</font><br>
<font face=3D"Arial">  72:  A....</font><br>
<font face=3D"Arial">  73:  A....</font><br>
<font face=3D"Arial">  74:  A....</font><br>
<font face=3D"Arial">  75:  A....</font><br>
<font face=3D"Arial">  76:  A....</font><br>
<font face=3D"Arial">  77:  A....</font><br>
<font face=3D"Arial">  78:  A....</font><br>
<font face=3D"Arial">  79:  A....</font><br>
<font face=3D"Arial">  80:  A....</font><br>
<font face=3D"Arial">  81:  A....</font><br>
<font face=3D"Arial">  82:  A....</font><br>
<font face=3D"Arial">  83:  A....</font><br>
<font face=3D"Arial">  84:  A....</font><br>
<font face=3D"Arial">  85:  A....</font><br>
<font face=3D"Arial">  86:  A....</font><br>
<font face=3D"Arial">  87:  A....</font><br>
<font face=3D"Arial">  88:  A....</font><br>
<font face=3D"Arial">  89:  A....</font><br>
<font face=3D"Arial">  90:  A....</font><br>
<font face=3D"Arial">  91:  A....</font><br>
<font face=3D"Arial">  92:  A....</font><br>
<font face=3D"Arial">  93:  A....</font><br>
<font face=3D"Arial">  94:  A....</font><br>
<font face=3D"Arial">  95:  A....</font><br>
<font face=3D"Arial">  96:  A....</font><br>
<font face=3D"Arial">  97:  A....</font><br>
<font face=3D"Arial">  98:  A....</font><br>
<font face=3D"Arial">  99:  A....</font><br>
<font face=3D"Arial"> 100:  A....</font><br>
<font face=3D"Arial"> 101:  A....</font><br>
<font face=3D"Arial"> 102:  A....</font><br>
<font face=3D"Arial"> 103:  A....</font><br>
<font face=3D"Arial"> 104:  A....</font><br>
<font face=3D"Arial"> 105:  A....</font><br>
<font face=3D"Arial"> 106:  A....</font><br>
<font face=3D"Arial"> 107:  A....</font><br>
<font face=3D"Arial"> 108:  A....</font><br>
<font face=3D"Arial"> 109:  A....</font><br>
<font face=3D"Arial"> 110:  A....</font><br>
<font face=3D"Arial"> 111:  A....</font><br>
<font face=3D"Arial"> 112:  A....</font><br>
<font face=3D"Arial"> 113:  A....</font><br>
<font face=3D"Arial"> 114:  A....</font><br>
<font face=3D"Arial"> 115:  A....</font><br>
<font face=3D"Arial"> 116:  A....</font><br>
<font face=3D"Arial"> 117:  A....</font><br>
<font face=3D"Arial"> 118:  A....</font><br>
<font face=3D"Arial"> 119:  A....</font><br>
<font face=3D"Arial"> 120:  A....</font><br>
<font face=3D"Arial"> 121:  A....</font><br>
<font face=3D"Arial"> 122:  A....</font><br>
<font face=3D"Arial"> 123:  A....</font><br>
<font face=3D"Arial"> 124:  A....</font><br>
<font face=3D"Arial"> 125:  A....</font><br>
<font face=3D"Arial"> 126:  A....</font><br>
<font face=3D"Arial"> 127:  A....</font><br>
<font face=3D"Arial"> 128:  A....</font><br>
<font face=3D"Arial"> 129:  A....</font><br>
<font face=3D"Arial"> 130:  A....</font><br>
<font face=3D"Arial"> 131:  A....</font><br>
<font face=3D"Arial"> 132:  A....</font><br>
<font face=3D"Arial"> 133:  A....</font><br>
<font face=3D"Arial"> 134:  A....</font><br>
<font face=3D"Arial"> 135:  A....</font><br>
<font face=3D"Arial"> 136:  A....</font><br>
<font face=3D"Arial"> 137:  A....</font><br>
<font face=3D"Arial"> 138:  A....</font><br>
<font face=3D"Arial"> 139:  A....</font><br>
<font face=3D"Arial"> 140:  A....</font><br>
<font face=3D"Arial"> 141:  A....</font><br>
<font face=3D"Arial"> 142:  A....</font><br>
<font face=3D"Arial"> 143:  A....</font><br>
<font face=3D"Arial"> 144:  A....</font><br>
<font face=3D"Arial"> 145:  A....</font><br>
<font face=3D"Arial"> 146:  A....</font><br>
<font face=3D"Arial"> 147:  A....</font><br>
<font face=3D"Arial"> 148:  A....</font><br>
<font face=3D"Arial"> 149:  A....</font><br>
<font face=3D"Arial"> 150:  A....</font><br>
<font face=3D"Arial"> 151:  A....</font><br>
<font face=3D"Arial"> 152:  A....</font><br>
<font face=3D"Arial"> 153:  A....</font><br>
<font face=3D"Arial"> 154:  A....</font><br>
<font face=3D"Arial"> 155:  A....</font><br>
<font face=3D"Arial"> 156:  A....</font><br>
<font face=3D"Arial"> 157:  A....</font><br>
<font face=3D"Arial"> 158:  A....</font><br>
<font face=3D"Arial"> 159:  A....</font><br>
<font face=3D"Arial"> 160:  A....</font><br>
<font face=3D"Arial"> 161:  A....</font><br>
<font face=3D"Arial"> 162:  A....</font><br>
<font face=3D"Arial"> 163:  A....</font><br>
<font face=3D"Arial"> 164:  A....</font><br>
<font face=3D"Arial"> 165:  A....</font><br>
<font face=3D"Arial"> 166:  A....</font><br>
<font face=3D"Arial"> 167:  A....</font><br>
<font face=3D"Arial"> 168:  A....</font><br>
<font face=3D"Arial"> 169:  A....</font><br>
<font face=3D"Arial"> 170:  A....</font><br>
<font face=3D"Arial"> 171:  A....</font><br>
<font face=3D"Arial"> 172:  A....</font><br>
<font face=3D"Arial"> 173:  A....</font><br>
<font face=3D"Arial"> 174:  A....</font><br>
<font face=3D"Arial"> 175:  A....</font><br>
<font face=3D"Arial"> 176:  A....</font><br>
<font face=3D"Arial"> 177:  A....</font><br>
<font face=3D"Arial"> 178:  A....</font><br>
<font face=3D"Arial"> 179:  A....</font><br>
<font face=3D"Arial"> 180:  A....</font><br>
<font face=3D"Arial"> 181:  A....</font><br>
<font face=3D"Arial"> 182:  A....</font><br>
<font face=3D"Arial"> 183:  A....</font><br>
<font face=3D"Arial"> 184:  A....</font><br>
<font face=3D"Arial"> 185:  A....</font><br>
<font face=3D"Arial"> 186:  A....</font><br>
<font face=3D"Arial"> 187:  A....</font><br>
<font face=3D"Arial"> 188:  A....</font><br>
<font face=3D"Arial"> 189:  A....</font><br>
<font face=3D"Arial"> 190:  A....</font><br>
<font face=3D"Arial"> 191:  A....</font><br>
<font face=3D"Arial"> 192:  A....</font><br>
<font face=3D"Arial"> 193:  A....</font><br>
<font face=3D"Arial"> 194:  A....</font><br>
<font face=3D"Arial"> 195:  A....</font><br>
<font face=3D"Arial"> 196:  A....</font><br>
<font face=3D"Arial"> 197:  A....</font><br>
<font face=3D"Arial"> 198:  A....</font><br>
<font face=3D"Arial"> 199:  A....</font><br>
<font face=3D"Arial"> 200:  A....</font><br>
<font face=3D"Arial"> 201:  A....</font><br>
<font face=3D"Arial"> 202:  A....</font><br>
<font face=3D"Arial"> 203:  A....</font><br>
<font face=3D"Arial"> 204:  A....</font><br>
<font face=3D"Arial"> 205:  A....</font><br>
<font face=3D"Arial"> 206:  A....</font><br>
<font face=3D"Arial"> 207:  A....</font><br>
<font face=3D"Arial"> 208:  A....</font><br>
<font face=3D"Arial"> 209:  A....</font><br>
<font face=3D"Arial"> 210:  A....</font><br>
<font face=3D"Arial"> 211:  A....</font><br>
<font face=3D"Arial"> 212:  A....</font><br>
<font face=3D"Arial"> 213:  A....</font><br>
<font face=3D"Arial"> 214:  A....</font><br>
<font face=3D"Arial"> 215:  A....</font><br>
<font face=3D"Arial"> 216:  A....</font><br>
<font face=3D"Arial"> 217:  A....</font><br>
<font face=3D"Arial"> 218:  A....</font><br>
<font face=3D"Arial"> 219:  A....</font><br>
<font face=3D"Arial"> 220:  A....</font><br>
<font face=3D"Arial"> 221:  A....</font><br>
<font face=3D"Arial"> 222:  A....</font><br>
<font face=3D"Arial"> 223:  A....</font><br>
<font face=3D"Arial"> 224:  A....</font><br>
<font face=3D"Arial"> 230:  A....</font><br>
<font face=3D"Arial"> 231:  A....</font><br>
<font face=3D"Arial"> 232:  A....</font><br>
<font face=3D"Arial"> 233:  A....</font><br>
<font face=3D"Arial"> 234:  GS...</font><br>
<font face=3D"Arial"> 236:  A....</font><br>
<font face=3D"Arial"> 237:  A....</font><br>
<font face=3D"Arial"> 238:  A....</font><br>
<font face=3D"Arial"> 239:  A....</font><br>
<font face=3D"Arial"> 240:  A....</font><br>
<font face=3D"Arial"> 256:  G...V</font><br>
<font face=3D"Arial"> 257:  G...V</font><br>
<font face=3D"Arial">[Domain info]</font><br>
<font face=3D"Arial">id=3D0x00000000</font><br>
<font face=3D"Arial">priority=3D100</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/ipipe/Xenomai</font><br>
<font face=3D"Arial">       +----- Handling ([A]ccepted, [G]rabbed, [W]=
ired, [D]iscarded)</font><br>
<font face=3D"Arial">       |+---- Sticky</font><br>
<font face=3D"Arial">       ||+--- Locked</font><br>
<font face=3D"Arial">       |||+-- Exclusive</font><br>
<font face=3D"Arial">       ||||+- Virtual</font><br>
<font face=3D"Arial">[IRQ]  |||||</font><br>
<font face=3D"Arial"> 230:  W....</font><br>
<font face=3D"Arial"> 233:  W..X.</font><br>
<font face=3D"Arial"> 234:  GS...</font><br>
<font face=3D"Arial"> 258:  W...V</font><br>
<font face=3D"Arial">[Domain info]</font><br>
<font face=3D"Arial">id=3D0x58454e4f</font><br>
<font face=3D"Arial">priority=3Dtopmost</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/ipipe/version</font><br>
<font face=3D"Arial">1.8-08</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: generate_loads 1</font><br>
<font face=3D"Arial">eval: 1: arith: syntax error: &quot;jobsct-1&quot;=
</font><br>
<font face=3D"Arial">cleanup_load: no dd_jobs found</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/interrupts</font><br>
<font face=3D"Arial">           CPU0</font><br>
<font face=3D"Arial">  0:    7243712    XT-PIC-XT        timer, rthal_b=
roadcast_timer</font><br>
<font face=3D"Arial">  1:         30    XT-PIC-XT        i8042</font><b=
r>
<font face=3D"Arial">  2:          0    XT-PIC-XT        cascade</font>=
<br>
<font face=3D"Arial">  5:     544285    XT-PIC-XT        uhci_hcd:usb1,=
 eth3, i915@domain.hid</font><br>
<font face=3D"Arial">  7:      18259    XT-PIC-XT        ehci_hcd:usb3<=
/font><br>
<font face=3D"Arial">  8:          3    XT-PIC-XT        rtc</font><br>=

<font face=3D"Arial">  9:   17584667    XT-PIC-XT        eth0</font><br=
>
<font face=3D"Arial"> 12:        196    XT-PIC-XT        i8042</font><b=
r>
<font face=3D"Arial"> 14:      10992    XT-PIC-XT        ide0</font><br=
>
<font face=3D"Arial"> 15:       7236    XT-PIC-XT        uhci_hcd:usb2,=
 eth1, eth2</font><br>
<font face=3D"Arial">NMI:       3198</font><br>
<font face=3D"Arial">LOC:    7243618</font><br>
<font face=3D"Arial">ERR:          0</font><br>
<font face=3D"Arial">MIS:          0</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/loadavg</font><br>
<font face=3D"Arial">0.19 0.16 0.16 3/116 13945</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/meminfo</font><br>
<font face=3D"Arial">MemTotal:       506576 kB</font><br>
<font face=3D"Arial">MemFree:        175296 kB</font><br>
<font face=3D"Arial">Buffers:         15676 kB</font><br>
<font face=3D"Arial">Cached:         145256 kB</font><br>
<font face=3D"Arial">SwapCached:          0 kB</font><br>
<font face=3D"Arial">Active:         156200 kB</font><br>
<font face=3D"Arial">Inactive:        93720 kB</font><br>
<font face=3D"Arial">HighTotal:           0 kB</font><br>
<font face=3D"Arial">HighFree:            0 kB</font><br>
<font face=3D"Arial">LowTotal:       506576 kB</font><br>
<font face=3D"Arial">LowFree:        175296 kB</font><br>
<font face=3D"Arial">SwapTotal:     1477940 kB</font><br>
<font face=3D"Arial">SwapFree:      1477940 kB</font><br>
<font face=3D"Arial">Dirty:              64 kB</font><br>
<font face=3D"Arial">Writeback:           0 kB</font><br>
<font face=3D"Arial">AnonPages:       89004 kB</font><br>
<font face=3D"Arial">Mapped:          46844 kB</font><br>
<font face=3D"Arial">Slab:            17244 kB</font><br>
<font face=3D"Arial">SReclaimable:     6468 kB</font><br>
<font face=3D"Arial">SUnreclaim:      10776 kB</font><br>
<font face=3D"Arial">PageTables:       1904 kB</font><br>
<font face=3D"Arial">NFS_Unstable:        0 kB</font><br>
<font face=3D"Arial">Bounce:              0 kB</font><br>
<font face=3D"Arial">CommitLimit:   1731228 kB</font><br>
<font face=3D"Arial">Committed_AS:   403968 kB</font><br>
<font face=3D"Arial">VmallocTotal:   516088 kB</font><br>
<font face=3D"Arial">VmallocUsed:      4288 kB</font><br>
<font face=3D"Arial">VmallocChunk:   511604 kB</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/apc</font><br>
<font face=3D"Arial">APC          CPU0</font><br>
<font face=3D"Arial">  0:            0    (pipe_wakeup)</font><br>
<font face=3D"Arial">  1:            0    (lostage_handler)</font><br>
<font face=3D"Arial">  2:            0    (registry_export)</font><br>
<font face=3D"Arial">  3:            0    (posix_signals_handler)</font=
><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/faults</font><br>
<font face=3D"Arial">TRAP         CPU0</font><br>
<font face=3D"Arial">  0:            0    (Divide error)</font><br>
<font face=3D"Arial">  1:            0    (Debug)</font><br>
<font face=3D"Arial">  3:            0    (Int3)</font><br>
<font face=3D"Arial">  4:            0    (Overflow)</font><br>
<font face=3D"Arial">  5:            0    (Bounds)</font><br>
<font face=3D"Arial">  6:            0    (Invalid opcode)</font><br>
<font face=3D"Arial">  7:            0    (FPU not available)</font><br=
>
<font face=3D"Arial">  8:            0    (Double fault)</font><br>
<font face=3D"Arial">  9:            0    (FPU segment overrun)</font><=
br>
<font face=3D"Arial"> 10:            0    (Invalid TSS)</font><br>
<font face=3D"Arial"> 11:            0    (Segment not present)</font><=
br>
<font face=3D"Arial"> 12:            0    (Stack segment)</font><br>
<font face=3D"Arial"> 13:            0    (General protection)</font><b=
r>
<font face=3D"Arial"> 14:            0    (Page fault)</font><br>
<font face=3D"Arial"> 15:            0    (Spurious interrupt)</font><b=
r>
<font face=3D"Arial"> 16:            0    (FPU error)</font><br>
<font face=3D"Arial"> 17:            0    (Alignment check)</font><br>
<font face=3D"Arial"> 18:            0    (Machine check)</font><br>
<font face=3D"Arial"> 19:            0    (SIMD error)</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/hal</font><br>
<font face=3D"Arial">1.8-08</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/heap</font><br>
<font face=3D"Arial">size=3D130560:used=3D64:pagesz=3D512</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/irq</font><br>
<font face=3D"Arial">IRQ         CPU0</font><br>
<font face=3D"Arial">230:           0</font><br>
<font face=3D"Arial">233:       14482         [timer]</font><br>
<font face=3D"Arial">234:           0</font><br>
<font face=3D"Arial">258:           0         [virtual]</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/latency</font><br>
<font face=3D"Arial">2699</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/sched</font><br>
<font face=3D"Arial">CPU  PID    PRI      PERIOD   TIMEOUT    STAT     =
  NAME</font><br>
<font face=3D"Arial">  0  0       -1      0        0          R        =
  ROOT/0</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/stat</font><br>
<font face=3D"Arial">CPU  PID    MSW        CSW        PF    STAT      =
 %CPU  NAME</font><br>
<font face=3D"Arial">  0  0      0          0          0     00500080  =
100.0  ROOT/0</font><br>
<font face=3D"Arial">  0  0      0          14482      0     00000000  =
  0.0  IRQ233: [timer]</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/timer</font><br>
<font face=3D"Arial">status=3Doneshot+watchdog:setup=3D84:tickval=3D1:j=
iffies=3D7259854992532</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/version</font><br>
<font face=3D"Arial">2.3.3</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/interfaces/native</font=
><br>
<font face=3D"Arial">0</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/interfaces/posix</font>=
<br>
<font face=3D"Arial">0</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/interfaces/rtdm</font><=
br>
<font face=3D"Arial">0</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/interfaces/sys</font><b=
r>
<font face=3D"Arial">0</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/rtdm/fildes</font><br>
<font face=3D"Arial">total=3D128:open=3D0:free=3D128</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/rtdm/named_devices</fon=
t><br>
<font face=3D"Arial">Hash    Name                            Driver    =
      /proc</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/rtdm/open_fildes</font>=
<br>
<font face=3D"Arial">Index   Locked  Device</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/rtdm/protocol_devices</=
font><br>
<font face=3D"Arial">Hash    ProtocolFamily:SocketType       Driver    =
      /proc</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: top -bn1c</font><br>
<font face=3D"Arial">top - 10:54:48 up  2:00,  2 users,  load average: =
0.19, 0.16, 0.16</font><br>
<font face=3D"Arial">Tasks: 106 total,   1 running, 105 sleeping,   0 s=
topped,   0 zombie</font><br>
<font face=3D"Arial">Cpu(s):  9.8%us,  2.9%sy,  0.0%ni, 84.2%id,  2.6%w=
a,  0.0%hi,  0.5%si,  0.0%st</font><br>
<font face=3D"Arial">Mem:    506576k total,   331280k used,   175296k f=
ree,    15676k buffers</font><br>
<font face=3D"Arial">Swap:  1477940k total,        0k used,  1477940k f=
ree,   145256k cached</font><br>
<br>
<font face=3D"Arial">  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM=
    TIME+  COMMAND</font><br>
<font face=3D"Arial"> 8702 gncu      15   0 35504  12m  10m S 15.6  2.5=
  14:12.39 /usr/lib/vino/vino-</font><br>
<font face=3D"Arial">14006 root      21   0  2312 1056  792 R  1.9  0.2=
   0:00.01 top -bn1c</font><br>
<font face=3D"Arial">    1 root      15   0  2908 1844  524 S  0.0  0.4=
   0:01.60 /sbin/init</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:48 CEST 2007</font><br>
<font face=3D"Arial">running: ./run -- -sh -T 120 -t0 # latency</font><=
br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">* Type ^C to stop this application.</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE =
disabled.</font><br>
<font face=3D"Arial">(modprobe xeno_native?)</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:49 CEST 2007</font><br>
<font face=3D"Arial">running: ./run -- -sh -T 120 -t1 # latency</font><=
br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">* Type ^C to stop this application.</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE =
disabled.</font><br>
<font face=3D"Arial">(modprobe xeno_native?)</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:50 CEST 2007</font><br>
<font face=3D"Arial">running: ./run -- -sh -T 120 -t2 # latency</font><=
br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">* Type ^C to stop this application.</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE =
disabled.</font><br>
<font face=3D"Arial">(modprobe xeno_native?)</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:50 CEST 2007</font><br>
<font face=3D"Arial">running: ./run -- -T 120 # switchtest</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">* Type ^C to stop this application.</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE d=
isabled.</font><br>
<font face=3D"Arial">(modprobe xeno_posix?)</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:50 CEST 2007</font><br>
<font face=3D"Arial">running: ./run -- -h # switchbench</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">* Type ^C to stop this application.</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE =
disabled.</font><br>
<font face=3D"Arial">(modprobe xeno_native?)</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: ./run -- -p 10 -n -l 1000 # cyclictest</f=
ont><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">* Type ^C to stop this application.</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">*</font><br>
<font face=3D"Arial">Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE d=
isabled.</font><br>
<font face=3D"Arial">(modprobe xeno_posix?)</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/interrupts</font><br>
<font face=3D"Arial">           CPU0</font><br>
<font face=3D"Arial">  0:    7247076    XT-PIC-XT        timer, rthal_b=
roadcast_timer</font><br>
<font face=3D"Arial">  1:         30    XT-PIC-XT        i8042</font><b=
r>
<font face=3D"Arial">  2:          0    XT-PIC-XT        cascade</font>=
<br>
<font face=3D"Arial">  5:     544540    XT-PIC-XT        uhci_hcd:usb1,=
 eth3, i915@domain.hid</font><br>
<font face=3D"Arial">  7:      18263    XT-PIC-XT        ehci_hcd:usb3<=
/font><br>
<font face=3D"Arial">  8:          3    XT-PIC-XT        rtc</font><br>=

<font face=3D"Arial">  9:   17593022    XT-PIC-XT        eth0</font><br=
>
<font face=3D"Arial"> 12:        196    XT-PIC-XT        i8042</font><b=
r>
<font face=3D"Arial"> 14:      11257    XT-PIC-XT        ide0</font><br=
>
<font face=3D"Arial"> 15:       7239    XT-PIC-XT        uhci_hcd:usb2,=
 eth1, eth2</font><br>
<font face=3D"Arial">NMI:       3201</font><br>
<font face=3D"Arial">LOC:    7246981</font><br>
<font face=3D"Arial">ERR:          0</font><br>
<font face=3D"Arial">MIS:          0</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/loadavg</font><br>
<font face=3D"Arial">0.41 0.21 0.18 6/116 14519</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/meminfo</font><br>
<font face=3D"Arial">MemTotal:       506576 kB</font><br>
<font face=3D"Arial">MemFree:        174908 kB</font><br>
<font face=3D"Arial">Buffers:         16000 kB</font><br>
<font face=3D"Arial">Cached:         145268 kB</font><br>
<font face=3D"Arial">SwapCached:          0 kB</font><br>
<font face=3D"Arial">Active:         156216 kB</font><br>
<font face=3D"Arial">Inactive:        94040 kB</font><br>
<font face=3D"Arial">HighTotal:           0 kB</font><br>
<font face=3D"Arial">HighFree:            0 kB</font><br>
<font face=3D"Arial">LowTotal:       506576 kB</font><br>
<font face=3D"Arial">LowFree:        174908 kB</font><br>
<font face=3D"Arial">SwapTotal:     1477940 kB</font><br>
<font face=3D"Arial">SwapFree:      1477940 kB</font><br>
<font face=3D"Arial">Dirty:               8 kB</font><br>
<font face=3D"Arial">Writeback:           0 kB</font><br>
<font face=3D"Arial">AnonPages:       89004 kB</font><br>
<font face=3D"Arial">Mapped:          46840 kB</font><br>
<font face=3D"Arial">Slab:            17324 kB</font><br>
<font face=3D"Arial">SReclaimable:     6488 kB</font><br>
<font face=3D"Arial">SUnreclaim:      10836 kB</font><br>
<font face=3D"Arial">PageTables:       1932 kB</font><br>
<font face=3D"Arial">NFS_Unstable:        0 kB</font><br>
<font face=3D"Arial">Bounce:              0 kB</font><br>
<font face=3D"Arial">CommitLimit:   1731228 kB</font><br>
<font face=3D"Arial">Committed_AS:   403968 kB</font><br>
<font face=3D"Arial">VmallocTotal:   516088 kB</font><br>
<font face=3D"Arial">VmallocUsed:      4288 kB</font><br>
<font face=3D"Arial">VmallocChunk:   511604 kB</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/apc</font><br>
<font face=3D"Arial">APC          CPU0</font><br>
<font face=3D"Arial">  0:            0    (pipe_wakeup)</font><br>
<font face=3D"Arial">  1:            0    (lostage_handler)</font><br>
<font face=3D"Arial">  2:            0    (registry_export)</font><br>
<font face=3D"Arial">  3:            0    (posix_signals_handler)</font=
><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/faults</font><br>
<font face=3D"Arial">TRAP         CPU0</font><br>
<font face=3D"Arial">  0:            0    (Divide error)</font><br>
<font face=3D"Arial">  1:            0    (Debug)</font><br>
<font face=3D"Arial">  3:            0    (Int3)</font><br>
<font face=3D"Arial">  4:            0    (Overflow)</font><br>
<font face=3D"Arial">  5:            0    (Bounds)</font><br>
<font face=3D"Arial">  6:            0    (Invalid opcode)</font><br>
<font face=3D"Arial">  7:            0    (FPU not available)</font><br=
>
<font face=3D"Arial">  8:            0    (Double fault)</font><br>
<font face=3D"Arial">  9:            0    (FPU segment overrun)</font><=
br>
<font face=3D"Arial"> 10:            0    (Invalid TSS)</font><br>
<font face=3D"Arial"> 11:            0    (Segment not present)</font><=
br>
<font face=3D"Arial"> 12:            0    (Stack segment)</font><br>
<font face=3D"Arial"> 13:            0    (General protection)</font><b=
r>
<font face=3D"Arial"> 14:            0    (Page fault)</font><br>
<font face=3D"Arial"> 15:            0    (Spurious interrupt)</font><b=
r>
<font face=3D"Arial"> 16:            0    (FPU error)</font><br>
<font face=3D"Arial"> 17:            0    (Alignment check)</font><br>
<font face=3D"Arial"> 18:            0    (Machine check)</font><br>
<font face=3D"Arial"> 19:            0    (SIMD error)</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/hal</font><br>
<font face=3D"Arial">1.8-08</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/heap</font><br>
<font face=3D"Arial">size=3D130560:used=3D64:pagesz=3D512</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/irq</font><br>
<font face=3D"Arial">IRQ         CPU0</font><br>
<font face=3D"Arial">230:           0</font><br>
<font face=3D"Arial">233:       14488         [timer]</font><br>
<font face=3D"Arial">234:           0</font><br>
<font face=3D"Arial">258:           0         [virtual]</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/latency</font><br>
<font face=3D"Arial">2699</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/sched</font><br>
<font face=3D"Arial">CPU  PID    PRI      PERIOD   TIMEOUT    STAT     =
  NAME</font><br>
<font face=3D"Arial">  0  0       -1      0        0          R        =
  ROOT/0</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/stat</font><br>
<font face=3D"Arial">CPU  PID    MSW        CSW        PF    STAT      =
 %CPU  NAME</font><br>
<font face=3D"Arial">  0  0      0          0          0     00500080  =
100.0  ROOT/0</font><br>
<font face=3D"Arial">  0  0      0          14488      0     00000000  =
  0.0  IRQ233: [timer]</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/timer</font><br>
<font face=3D"Arial">status=3Doneshot+watchdog:setup=3D84:tickval=3D1:j=
iffies=3D7263187768042</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/version</font><br>
<font face=3D"Arial">2.3.3</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/interfaces/native</font=
><br>
<font face=3D"Arial">0</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/interfaces/posix</font>=
<br>
<font face=3D"Arial">0</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/interfaces/rtdm</font><=
br>
<font face=3D"Arial">0</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/interfaces/sys</font><b=
r>
<font face=3D"Arial">0</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/rtdm/fildes</font><br>
<font face=3D"Arial">total=3D128:open=3D0:free=3D128</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/rtdm/named_devices</fon=
t><br>
<font face=3D"Arial">Hash    Name                            Driver    =
      /proc</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/rtdm/open_fildes</font>=
<br>
<font face=3D"Arial">Index   Locked  Device</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: cat /proc/xenomai/rtdm/protocol_devices</=
font><br>
<font face=3D"Arial">Hash    ProtocolFamily:SocketType       Driver    =
      /proc</font><br>
<br>
<font face=3D"Arial">Fri Sep 21 10:54:51 CEST 2007</font><br>
<font face=3D"Arial">running: top -bn1c</font><br>
<font face=3D"Arial">top - 10:54:52 up  2:00,  2 users,  load average: =
0.41, 0.21, 0.18</font><br>
<font face=3D"Arial">Tasks: 106 total,   1 running, 105 sleeping,   0 s=
topped,   0 zombie</font><br>
<font face=3D"Arial">Cpu(s):  9.8%us,  2.9%sy,  0.0%ni, 84.1%id,  2.6%w=
a,  0.0%hi,  0.5%si,  0.0%st</font><br>
<font face=3D"Arial">Mem:    506576k total,   331668k used,   174908k f=
ree,    16000k buffers</font><br>
<font face=3D"Arial">Swap:  1477940k total,        0k used,  1477940k f=
ree,   145268k cached</font><br>
<br>
<font face=3D"Arial">  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM=
    TIME+  COMMAND</font><br>
<font face=3D"Arial"> 8702 gncu      15   0 35504  12m  10m S 13.5  2.5=
  14:12.88 /usr/lib/vino/vino-</font><br>
<font face=3D"Arial">14580 root      21   0  2316 1060  792 R  3.9  0.2=
   0:00.02 top -bn1c</font><br>
<font face=3D"Arial">    1 root      15   0  2908 1844  524 S  0.0  0.4=
   0:01.60 /sbin/init</font><br>
<font face=3D"Arial">cleanup_load: no dd_jobs found</font><br>
<font face=3D"Arial">xeno-test: finished</font><br>
<font face=3D"Arial">root@domain.hid#</font><br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<font face=3D"Arial"><br>
</font><br>
<img src=3D"cid:1__=3D4EBBF9CEDFBC2ADD8f9e8a93df938@domain.hid" width=3D=
"120" height=3D"38"><font face=3D"Arial"><br>
<br>
Juergen Lanner <br>
Software Development <br>
Datacon Technology GmbH <br>
Tel.: +43 5337 600-403 </font><u><font face=3D"Arial"><br>
</font></u><a href=3D"http://www.datacon.at/"><u><font face=3D"Arial">w=
ww.datacon.at</font></u></a><font face=3D"Arial"> <br>
</font><br>
<i><font face=3D"Arial">IMPORTANT: The contents of this email and any a=
ttachments are confidential. They are intended for the named recipient(=
s) only. <br>
If you have received this email in error, please notify the system mana=
ger or the sender immediately and do not disclose the contents to anyon=
e or make copies thereof. </font></i><br>
<font face=3D"Arial"><br>
</font></body></html>=


--1__=4EBBF9CEDFBC2ADD8f9e8a93df938690918c4EBBF9CEDFBC2ADD--


--0__=4EBBF9CEDFBC2ADD8f9e8a93df938690918c4EBBF9CEDFBC2ADD
Content-type: image/gif; 
	name="07075857.gif"
Content-Disposition: inline; filename="07075857.gif"
Content-ID: <1__=4EBBF9CEDFBC2ADD8f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

R0lGODlheAAmAPcAAAAAAAClUgClWgCtUgCtWgCtYwitWgitYxCtYxC1axitaxi1ayG1ayG1cym1
cym9czExMTG9ezkxMTkxOTk5OTm9ezm9hEI5OUI5QkJCQkK9hELGhELGjEpCQkpCSkpKSkrGjFJK
SlJKUlJSUlLGjFLGlFpSUlpSWlpaWlrGlFrOlGNjY2POnGtjY2tra2vOnGvOpXNrc3Nzc3POpXPW
pXtze3t7e3vWrYR7hISEhITWrYTWtYyEhIyEjIyMjIzWtYzetZSMjJSMlJSUlJTetZTevZyUlJyU
nJycnJzevZzexqWcnKWlpaXexqXnxq2lra2tra3nxq3nzrWttbW1tbXnzr21tb29vb3nzr3v1sa9
xsbGxsbv1sbv3s7Gzs7Ozs7v3s7v58733tbOztbO1tbW1tbv59b3597W1t7e3t7359737+fn5+f3
7+f/9+/v7+/37+/39+//9/fv7/f39/f/9/f/////9///////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////ywAAAAAeAAmAAAI/gDxCBxI
UKAdPGpIaABTsKFBhxAjSpxIsaJFiHcIHsQTRwcCAQIQzHCDJyNBkxdTqlzJ8iIdKQ5AEgApYEET
OgJR3tnYsqfPnycL1jGzQSbNmQIIROCCxw7KkkCjSlWJcs2LAwGS0jRKk4UZkzynih0bsU4SBVuN
Il0b8kccsnDjEsRSQa3WrWxlOpAit+9UNSUO4B2MdDBNEAz9Kl65ZgaCrFzvErYLEsGNNhnDysW5
OGIVHT+IFPlRRDTpIqNLjyZygwTao1sdtGHJubPtnLgFtjlbGOkBNRI3Po1bu/PTnQ55mmEQGcGa
iGhQjDgxAkUMJmkKotQ8cDjcg96j/qKMAjvkc4hlKKhXLwECBiQr35Ap7pP+RQ0WKuTPH2FGzir7
6VcBCE0QFAFeCACHHgUZePFGGVesQAEEPqT0RQYocFbHbQQJlpYAJAzUxIcgMdXUC5I5F1F6GWQ3
0BATSHDFRVtQkOFi9g300UyFhSgQeVrxKEASA80AW4IrMujiQDJMgMKGAtHBxhdalPHGQFJSAYEJ
ZbDBxkBTbvHFlQ3RkcYWW5RRGx1voGklQWZ++cYXaXKGQG8g+YiHFOUJoAEcA2nAFZILtljQFhNQ
sIVAabiAAQQTmjCjHVYkKoF6EAyBxxs2ZBAjBR88UVAZLlDwaQ5RItHBhBSMoMVA/mlksEIZKEwA
wQUyXGkGGGCEwauvCuIBx6+8gmHGQHVUIZl5SXawpEBvfCABEwJdQYELSCBhg3qLlpGDDBBkkEMO
VODBBgQrDMFEDhRIAAWsHkgwgg9DuMCDQEZMkIEPSzRJwRcCsUFBByKMMESnE6BKEXcERaFAVkIS
6hCLzwrkQqaMljuQDxTEMNAXTtb2hsY7TUHBCgO1QEGuBs2BR3oQLCqQDxKsgBMbH0zgAmdDUBDC
l2VFhFwRHm6lYqEV4yEDBRVOHPKGNd4I0RugflnjBEkLAUELD8U6AcA4xwyrkmqYUfbZZswmUBxo
q6GG2gKNKGRIwTaUnrMNxZBp/nFvpFEGFRSYwBmiKABaUN9lfIFBB18OUTN3SxtREAoQUIvzBS7a
wcYFLSpwAAIHfG6AACWYFIUBnyOAOgIpGG6HoBHXPaqSBdGBAgXwVevCBRPGiMJbeGwhgdQHeSFD
BqxC8MGXOSSsHR4rQPAuQaVWyIYHhgacQYsfgQQZiAPxSaISRaZ19MS0E5TGoxrDuPIUVyABgdSE
G44HFOq58MQV+H9w5bYKm9wENDaQGEjAeh+gwJLYgIEWCSYvehoRV2aChYGgaC0Ss9vAKsYEClzg
S2NQz4wYJYETAK9GJ+BMGnJGLWht70rNswFUCLKCCbQwZRTQFM4wsMDtpSEC/g4IYhAfwAAYIAcL
DRBiECNQBIJYQCZZcU54XpY+aJmAAjLEAxMmIAOCfCFwg7ORy4JXM/tRzQNfYgIERmAfAMJJBBAo
Fxt8CCYfbogOdrBDHfBYGzvgsQ56rAOUBIKF8mRwdniDloSWJxAkSCCLM6PACQwnPKldYQI2Gwjg
OnClMmQgjg2BggQ+UJsthCs7O+xh9rpzkilupA0HKgzdmoK+DFyBDFfIQc46ALBq6auX1hoeZ74Q
rvnQwZOgxMOFJsBIPARBX1CYQxy+8K43oEACObhSGmrVNDZ0YJUMXOVAGKaRKFWhAYY5JEHIgKlP
YfFZdXDBpVzAzQyMgExv/hiBvkJQoRxcagUreOQIMgA0OsjgUhmQFsqU6akP3E4CLiDTHHkIJg+m
IQtNiEIVpFCFjVZBoxwFaRSkEIUkvMABeNIKA+DWkDTIwAUykIEPoMAG+8RhCCaQ1RU4lc2PueAD
I9AYElDgARRAgQ4+kAHQBEKFGADVBQRkQw5G0IEVMEFkNlDqQN4gAxuwAQws2Mr3SESimQSARykw
Azk7M8jgQCRH5ZyhQLoAu2WxRUhIOStIIlBBi6w1KBzySRPQGRlZprQmRfirQ6ZYEMUGdiJw8MgE
C0uTA8yApY/NbETMQILITFYAIDBRbjRL2tFm4UBB4ooDClTa1rKyIXE4JQtNBgCSA/zAfq7NLUTa
8ILuESAFsourbgMbnjvQNQJZGG5uAwIAOw==

--0__=4EBBF9CEDFBC2ADD8f9e8a93df938690918c4EBBF9CEDFBC2ADD--


