Content-Type: multipart/mixed; boundary="========GMX282091178882662983051"
Date: Fri, 11 May 2007 13:24:22 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
In-Reply-To: <46434837.9080605@domain.hid>
Message-ID: <20070511112422.282090@domain.hid>
MIME-Version: 1.0
References: <20070510120938.307800@domain.hid> <46434561.2090309@domain.hid>
	<46434837.9080605@domain.hid>
Subject: Re: [Xenomai-help] high latency with Intel Core 2 Duo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

--========GMX282091178882662983051
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Jan Kiszka wrote:
> > Karl Reichert wrote:
> > 
> >>Hello,
> >>
> >> I'm using an Intel Core 2 Duo at work and an AMD XP3000+ at home. I
> installed Xenomai 2.3.1 with nearly same configuration at both and run the
> xeno-test. I get 10 times higher latency with Core 2 Duo. How is it possible?
> May the SMP be the reason?
> > 
> > 
> > SMP surely increases latencies (more synchronisation overhead), but the
> > tests you ran were also far to short for a thorough comparison. 2 us
> > worst-case is far too good, even on high end. Also 20 us on loaded SMP
> > boxes may not hold. Leave the test running for a longer period ("-T"
> > parameter, I think).
Will do that and report the results later.

> 
> You should configure the user-space libraries with the --enable-smp
> option when configuring for SMP.
> 
I did that, but nothing changes, still the same latencys (see attached file).

> Also, did you compile a 32 bits or 64 bits kernel for the core 2 duo ?
> 
It's a 32 bit one.
> If you think that you observe high latencies, check the TROUBLESHOOTING
> file.
> 
> -- 
>                                                  Gilles Chanteperdrix
Karl
-- 
von Karl Reichert

GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail

--========GMX282091178882662983051
Content-Type: text/plain; charset="iso-8859-15"; name="[work]xeno-test.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="[work]xeno-test.txt"

xeno-test: started 
withBusybox is 0
xeno-test: running tests

Fr 11. Mai 13:56:51 CEST 2007
running: ./xeno-config --verbose
xeno-config --verbose
    --version="2.3.1"
    --cc="gcc"
    --arch="i386"
    --prefix="/usr/xenomai"
    --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT"
    --xeno-ldflags="-L/usr/xenomai/lib -lpthread "
    --posix-cflags="-I/usr/xenomai/include -I/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
    --posix-ldflags="-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
    --library-dir="/usr/xenomai/lib"

Fr 11. Mai 13:56:51 CEST 2007
running: ./xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux rtlinux 2.6.20.11-adeos-xenomai2.3.1 #2 SMP Thu May 10 15:05:15 CEST 2007 i686 GNU/Linux
 
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
Modules Loaded         parport_pc lp parport usb_storage libusual snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq sr_mod cdrom snd_timer snd_seq_device sg psmouse snd serio_raw intel_agp shpchp pci_hotplug soundcore snd_page_alloc uhci_hcd ehci_hcd agpgart usbcore sd_mod ata_piix ata_generic libata scsi_mod generic evdev fbcon tileblit font bitblit softcursor

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz
stepping	: 2
cpu MHz		: 1860.674
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm
bogomips	: 3722.38
clflush size	: 64

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz
stepping	: 2
cpu MHz		: 1860.674
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm
bogomips	: 3720.76
clflush size	: 64


Fr 11. Mai 13:56:52 CEST 2007
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
0839664b8bf8269f76f2f5cec387ba67  /proc/cpuinfo
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y
CONFIG_IPIPE=y
# CONFIG_PM is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_IPIPE_DEBUG is not set
CONFIG_IPIPE_TRACE_ENABLE_VALUE=0
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set

Fr 11. Mai 13:56:52 CEST 2007
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
   6:  A.L..
   7:  A.L..
   8:  A....
   9:  A.L..
  10:  A....
  11:  A....
  12:  A....
  13:  A.L..
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
 217:  GS...
 218:  A....
 219:  A....
 220:  A....
 221:  A....
 222:  A....
 223:  A....
 224:  G...V
 225:  G...V
[Domain info]
id=0x00000000
priority=100

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/ipipe/Xenomai
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
 213:  W....
 216:  W..X.
 217:  GS...
 226:  W...V
[Domain info]
id=0x58454e4f
priority=topmost

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/ipipe/version
1.7-03

Fr 11. Mai 13:56:52 CEST 2007
running: generate_loads 1
eval: 1: arith: syntax error: "jobsct-1"
cleanup_load: no dd_jobs found

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/interrupts
           CPU0       CPU1       
  0:      67455          0  local-APIC-edge-fasteio   timer, rthal_broadcast_timer
  1:        241          0   IO-APIC-edge      i8042
  2:          0          0    XT-PIC-XT        cascade
  8:          3          0   IO-APIC-edge      rtc
 12:        132          0   IO-APIC-edge      i8042
 14:       1329          0   IO-APIC-edge      libata
 15:         21          0   IO-APIC-edge      libata
 18:          0          0   IO-APIC-fasteoi   libata
 20:         69          0   IO-APIC-fasteoi   ehci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb5
 21:        104          0   IO-APIC-fasteoi   uhci_hcd:usb4, uhci_hcd:usb6, HDA Intel
 22:         32          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb7
NMI:          0          0 
LOC:      67294      67292 
ERR:          0
MIS:          0

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/loadavg
0.38 0.17 0.06 1/53 3202

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/meminfo
MemTotal:       905564 kB
MemFree:        864836 kB
Buffers:          3300 kB
Cached:          18912 kB
SwapCached:          0 kB
Active:          18940 kB
Inactive:         7788 kB
SwapTotal:     3004112 kB
SwapFree:      3004112 kB
Dirty:             136 kB
Writeback:           0 kB
AnonPages:        4380 kB
Mapped:           2412 kB
Slab:             7392 kB
SReclaimable:     2204 kB
SUnreclaim:       5188 kB
PageTables:        168 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   3456892 kB
Committed_AS:     8272 kB
VmallocTotal:   122600 kB
VmallocUsed:      4400 kB
VmallocChunk:   117668 kB

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/apc
APC          CPU0         CPU1
  0:            0           0    (pipe_wakeup)
  1:            5           0    (lostage_handler)
  2:            2           0    (registry_export)
  3:            0           0    (posix_signals_handler)

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/faults
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

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/hal
1.7-03

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/heap
size=130560:used=64:pagesz=512

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/irq
IRQ         CPU0        CPU1
213:           0           0
216:       12827          67         [timer]
217:           0           0
226:           9           0         [virtual]

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/latency
2699

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT/0
  1  0       -1      0        0          R          ROOT/1

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          12765      0     00500080   99.7  ROOT/0
  1  0      0          0          0     00500080  100.0  ROOT/1
  0  0      0          12827      0     00000000    0.1  IRQ216: [timer]
  1  0      0          67         0     00000000    0.0  IRQ216: [timer]

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/timer
status=oneshot+watchdog:setup=55:tickval=1:jiffies=67602393608

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/version
2.3.1

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/interfaces/native
0

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/interfaces/posix
0

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/interfaces/rtdm
0

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/interfaces/sys
0

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				Driver		/proc

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device

Fr 11. Mai 13:56:52 CEST 2007
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Fr 11. Mai 13:56:52 CEST 2007
running: top -bn1c
top - 13:56:52 up 1 min,  1 user,  load average: 0.38, 0.17, 0.06
Tasks:  55 total,   1 running,  54 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.7%us,  2.7%sy,  0.0%ni, 91.7%id,  5.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:    905564k total,    40480k used,   865084k free,     3300k buffers
Swap:  3004112k total,        0k used,  3004112k free,    18980k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
    1 root      18   0  2908 1844  524 S    0  0.2   0:00.72 /sbin/init         
    2 root      RT   0     0    0    0 S    0  0.0   0:00.00 [migration/0]      
    3 root      39  19     0    0    0 S    0  0.0   0:00.00 [ksoftirqd/0]      

Fr 11. Mai 13:56:52 CEST 2007
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
RTD|       1.220|       4.783|      21.968|       0|       1.220|      21.968
RTD|       1.269|       4.812|      22.472|       0|       1.220|      22.472
RTD|       1.224|       4.776|      22.182|       0|       1.220|      22.472
RTD|       1.209|       4.768|      21.938|       0|       1.209|      22.472
RTD|       1.201|       4.762|      22.152|       0|       1.201|      22.472
RTD|       1.235|       4.780|      21.784|       0|       1.201|      22.472
RTD|       1.231|       4.781|      22.250|       0|       1.201|      22.472
RTD|       1.213|       4.775|      22.258|       0|       1.201|      22.472
RTD|       1.209|       4.782|      22.246|       0|       1.201|      22.472
RTD|       1.235|       4.770|      22.431|       0|       1.201|      22.472
RTD|       1.224|       4.787|      21.908|       0|       1.201|      22.472
RTD|       1.258|       4.792|      21.784|       0|       1.201|      22.472
RTD|       1.235|       4.796|      21.802|       0|       1.201|      22.472
RTD|       1.205|       4.776|      21.776|       0|       1.201|      22.472
RTD|       1.213|       4.762|      22.205|       0|       1.201|      22.472
RTD|       1.243|       4.787|      21.851|       0|       1.201|      22.472
RTD|       1.235|       4.798|      21.795|       0|       1.201|      22.472
RTD|       1.258|       4.796|      21.787|       0|       1.201|      22.472
RTD|       1.205|       4.774|      21.957|       0|       1.201|      22.472
RTD|       1.209|       4.773|      21.893|       0|       1.201|      22.472
RTD|       1.243|       4.778|      22.333|       0|       1.201|      22.472
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.254|       4.788|      23.243|       0|       1.201|      23.243
RTD|       1.231|       4.789|      22.009|       0|       1.201|      23.243
RTD|       1.235|       4.777|      21.776|       0|       1.201|      23.243
RTD|       1.213|       4.762|      22.006|       0|       1.201|      23.243
RTD|       1.246|       4.798|      21.787|       0|       1.201|      23.243
RTD|       1.231|       4.778|      21.772|       0|       1.201|      23.243
RTD|       1.243|       4.775|      21.772|       0|       1.201|      23.243
RTD|       1.220|       4.788|      21.900|       0|       1.201|      23.243
RTD|       1.231|       4.770|      22.389|       0|       1.201|      23.243
RTD|       1.243|       4.786|      22.291|       0|       1.201|      23.243
RTD|       1.231|       4.787|      21.934|       0|       1.201|      23.243
RTD|       1.250|       4.783|      21.975|       0|       1.201|      23.243
RTD|       1.216|       4.775|      21.784|       0|       1.201|      23.243
RTD|       1.220|       4.761|      22.340|       0|       1.201|      23.243
RTD|       1.235|       4.788|      22.397|       0|       1.201|      23.243
RTD|       1.239|       4.788|      22.265|       0|       1.201|      23.243
RTD|       1.239|       4.797|      22.265|       0|       1.201|      23.243
RTD|       1.261|       4.795|      21.825|       0|       1.201|      23.243
RTD|       1.197|       4.759|      22.495|       0|       1.197|      23.243
RTD|       1.231|       4.770|      21.998|       0|       1.197|      23.243
RTD|       1.276|       4.803|      21.893|       0|       1.197|      23.243
RTT|  00:00:43  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.231|       4.788|      21.904|       0|       1.197|      23.243
RTD|       1.246|       4.797|      21.784|       0|       1.197|      23.243
RTD|       1.224|       4.764|      22.378|       0|       1.197|      23.243
RTD|       1.213|       4.786|      21.878|       0|       1.197|      23.243
RTD|       1.224|       4.784|      21.855|       0|       1.197|      23.243
RTD|       1.216|       4.764|      21.889|       0|       1.197|      23.243
RTD|       1.209|       4.774|      21.893|       0|       1.197|      23.243
RTD|       1.224|       4.765|      21.979|       0|       1.197|      23.243
RTD|       1.250|       4.807|      21.960|       0|       1.197|      23.243
RTD|       1.216|       4.788|      21.893|       0|       1.197|      23.243
RTD|       1.228|       4.774|      21.893|       0|       1.197|      23.243
RTD|       1.261|       4.788|      21.870|       0|       1.197|      23.243
RTD|       1.194|       4.764|      22.013|       0|       1.194|      23.243
RTD|       1.250|       4.786|      21.904|       0|       1.194|      23.243
RTD|       1.258|       4.787|      21.795|       0|       1.194|      23.243
RTD|       1.224|       4.778|      21.911|       0|       1.194|      23.243
RTD|       1.224|       4.776|      21.896|       0|       1.194|      23.243
RTD|       1.213|       4.762|      21.855|       0|       1.194|      23.243
RTD|       1.239|       4.789|      21.791|       0|       1.194|      23.243
RTD|       1.250|       4.796|      21.802|       0|       1.194|      23.243
RTD|       1.235|       4.773|      21.780|       0|       1.194|      23.243
RTT|  00:01:04  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.239|       4.791|      21.919|       0|       1.194|      23.243
RTD|       1.216|       4.773|      22.385|       0|       1.194|      23.243
RTD|       1.216|       4.773|      22.374|       0|       1.194|      23.243
RTD|       1.220|       4.786|      22.288|       0|       1.194|      23.243
RTD|       1.246|       4.797|      22.337|       0|       1.194|      23.243
RTD|       1.243|       4.786|      21.772|       0|       1.194|      23.243
RTD|       1.205|       4.763|      22.427|       0|       1.194|      23.243
RTD|       1.261|       4.792|      21.915|       0|       1.194|      23.243
RTD|       1.228|       4.800|      21.791|       0|       1.194|      23.243
RTD|       1.224|       4.798|      21.787|       0|       1.194|      23.243
RTD|       1.258|       4.797|      21.791|       0|       1.194|      23.243
RTD|       1.197|       4.762|      21.911|       0|       1.194|      23.243
RTD|       1.205|       4.786|      21.784|       0|       1.194|      23.243
RTD|       1.269|       4.810|      22.039|       0|       1.194|      23.243
RTD|       1.228|       4.784|      21.893|       0|       1.194|      23.243
RTD|       1.209|       4.777|      21.776|       0|       1.194|      23.243
RTD|       1.224|       4.766|      21.870|       0|       1.194|      23.243
RTD|       1.224|       4.786|      22.051|       0|       1.194|      23.243
RTD|       1.246|       4.799|      22.329|       0|       1.194|      23.243
RTD|       1.243|       4.790|      22.017|       0|       1.194|      23.243
RTD|       1.231|       4.793|      21.791|       0|       1.194|      23.243
RTT|  00:01:25  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.216|       4.762|      21.847|       0|       1.194|      23.243
RTD|       1.265|       4.801|      21.911|       0|       1.194|      23.243
RTD|       1.228|       4.785|      21.780|       0|       1.194|      23.243
RTD|       1.228|       4.787|      21.795|       0|       1.194|      23.243
RTD|       1.250|       4.799|      21.791|       0|       1.194|      23.243
RTD|       1.231|       4.762|      21.829|       0|       1.194|      23.243
RTD|       1.258|       4.799|      21.904|       0|       1.194|      23.243
RTD|       1.250|       4.779|      21.859|       0|       1.194|      23.243
RTD|       1.231|       4.791|      21.802|       0|       1.194|      23.243
RTD|       1.250|       4.785|      21.780|       0|       1.194|      23.243
RTD|       1.205|       4.762|      22.032|       0|       1.194|      23.243
RTD|       1.239|       4.802|      21.915|       0|       1.194|      23.243
RTD|       1.258|       4.781|      21.900|       0|       1.194|      23.243
RTD|       1.243|       4.785|      21.893|       0|       1.194|      23.243
RTD|       1.216|       4.763|      21.949|       0|       1.194|      23.243
RTD|       1.246|       4.761|      22.412|       0|       1.194|      23.243
RTD|       1.265|       4.786|      21.990|       0|       1.194|      23.243
RTD|       1.235|       4.792|      21.795|       0|       1.194|      23.243
RTD|       1.235|       4.778|      21.772|       0|       1.194|      23.243
RTD|       1.231|       4.774|      21.795|       0|       1.194|      23.243
RTD|       1.209|       4.768|      22.284|       0|       1.194|      23.243
RTT|  00:01:46  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.258|       4.781|      21.832|       0|       1.194|      23.243
RTD|       1.243|       4.787|      21.791|       0|       1.194|      23.243
RTD|       1.213|       4.790|      21.915|       0|       1.194|      23.243
RTD|       1.235|       4.784|      22.009|       0|       1.194|      23.243
RTD|       1.216|       4.760|      22.310|       0|       1.194|      23.243
RTD|       1.213|       4.789|      22.434|       0|       1.194|      23.243
RTD|       1.243|       4.803|      21.810|       0|       1.194|      23.243
RTD|       1.239|       4.774|      21.957|       0|       1.194|      23.243
RTD|       1.209|       4.777|      21.889|       0|       1.194|      23.243
RTD|       1.243|       4.773|      23.292|       0|       1.194|      23.292
RTD|       1.254|       4.810|      22.333|       0|       1.194|      23.292
RTD|       1.224|       4.802|      21.799|       0|       1.194|      23.292
RTD|       1.258|       4.797|      22.344|       0|       1.194|      23.292
RTD|       1.231|       4.775|      22.239|       0|       1.194|      23.292
---|--param|----range-|--samples
HSD|    min|   1 -  2 |      119
---|--param|----range-|--samples
HSD|    avg|   1 -  2 |   996297
HSD|    avg|   2 -  3 |     3413
HSD|    avg|   3 -  4 |      218
HSD|    avg|   5 -  6 |        2
HSD|    avg|   7 -  8 |        1
HSD|    avg|   8 -  9 |        1
HSD|    avg|  10 - 11 |        8
HSD|    avg|  11 - 12 |       32
HSD|    avg|  12 - 13 |        1
HSD|    avg|  13 - 14 |        1
HSD|    avg|  14 - 15 |        1
HSD|    avg|  16 - 17 |        1
HSD|    avg|  18 - 19 |        1
HSD|    avg|  21 - 22 |   199951
HSD|    avg|  22 - 23 |       47
HSD|    avg|  23 - 24 |        2
---|--param|----range-|--samples
HSD|    max|  21 - 22 |       79
HSD|    max|  22 - 23 |       38
HSD|    max|  23 - 24 |        2
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       119|      1.000|      0.000
HSS|    avg|   1199977|      4.337|      7.453
HSS|    max|       119|     21.353|      0.514
---|------------|------------|------------|--------|-------------------------
RTS|       1.194|       4.782|      23.292|       0|    00:02:00/00:02:00

Fr 11. Mai 13:58:53 CEST 2007
running: ./run -- -sh -T 120 -t1 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.348|       3.921|      21.132|       0|       0.348|      21.132
RTD|       0.352|       3.920|      20.910|       0|       0.348|      21.132
RTD|       0.347|       3.918|      20.921|       0|       0.347|      21.132
RTD|       0.346|       3.917|      20.914|       0|       0.346|      21.132
RTD|       0.354|       3.920|      20.908|       0|       0.346|      21.132
RTD|       0.349|       3.914|      21.102|       0|       0.346|      21.132
RTD|       0.345|       3.918|      21.098|       0|       0.345|      21.132
RTD|       0.345|       3.910|      21.100|       0|       0.345|      21.132
RTD|       0.347|       3.918|      21.021|       0|       0.345|      21.132
RTD|       0.346|       3.920|      20.939|       0|       0.345|      21.132
RTD|       0.347|       3.917|      20.944|       0|       0.345|      21.132
RTD|       0.349|       3.920|      21.012|       0|       0.345|      21.132
RTD|       0.336|       3.916|      20.913|       0|       0.336|      21.132
RTD|       0.335|       3.919|      21.072|       0|       0.335|      21.132
RTD|       0.353|       3.913|      20.916|       0|       0.335|      21.132
RTD|       0.360|       3.920|      20.961|       0|       0.335|      21.132
RTD|       0.350|       3.919|      20.948|       0|       0.335|      21.132
RTD|       0.328|       3.917|      21.131|       0|       0.328|      21.132
RTD|       0.350|       3.919|      20.907|       0|       0.328|      21.132
RTD|       0.348|       3.914|      21.096|       0|       0.328|      21.132
RTD|       0.341|       3.920|      21.162|       0|       0.328|      21.162
RTT|  00:00:22  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.368|       3.913|      21.157|       0|       0.328|      21.162
RTD|       0.359|       3.921|      21.017|       0|       0.328|      21.162
RTD|       0.348|       3.919|      20.909|       0|       0.328|      21.162
RTD|       0.327|       3.919|      21.103|       0|       0.327|      21.162
RTD|       0.344|       3.917|      21.143|       0|       0.327|      21.162
RTD|       0.346|       3.916|      21.088|       0|       0.327|      21.162
RTD|       0.341|       3.920|      20.960|       0|       0.327|      21.162
RTD|       0.344|       3.914|      20.955|       0|       0.327|      21.162
RTD|       0.372|       3.921|      21.034|       0|       0.327|      21.162
RTD|       0.348|       3.919|      20.994|       0|       0.327|      21.162
RTD|       0.352|       3.920|      20.894|       0|       0.327|      21.162
RTD|       0.348|       3.920|      20.904|       0|       0.327|      21.162
RTD|       0.347|       3.918|      20.908|       0|       0.327|      21.162
RTD|       0.348|       3.920|      20.912|       0|       0.327|      21.162
RTD|       0.363|       3.920|      20.937|       0|       0.327|      21.162
RTD|       0.349|       3.918|      21.084|       0|       0.327|      21.162
RTD|       0.355|       3.923|      21.135|       0|       0.327|      21.162
RTD|       0.335|       3.916|      21.077|       0|       0.327|      21.162
RTD|       0.359|       3.920|      20.905|       0|       0.327|      21.162
RTD|       0.332|       3.916|      20.965|       0|       0.327|      21.162
RTD|       0.350|       3.919|      20.964|       0|       0.327|      21.162
RTT|  00:00:43  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.339|       3.915|      20.910|       0|       0.327|      21.162
RTD|       0.342|       3.921|      20.983|       0|       0.327|      21.162
RTD|       0.358|       3.909|      21.105|       0|       0.327|      21.162
RTD|       0.328|       3.920|      21.111|       0|       0.327|      21.162
RTD|       0.351|       3.920|      20.956|       0|       0.327|      21.162
RTD|       0.365|       3.919|      20.958|       0|       0.327|      21.162
RTD|       0.334|       3.920|      20.913|       0|       0.327|      21.162
RTD|       0.338|       3.916|      20.916|       0|       0.327|      21.162
RTD|       0.347|       3.919|      20.979|       0|       0.327|      21.162
RTD|       0.351|       3.911|      20.940|       0|       0.327|      21.162
RTD|       0.355|       3.919|      20.947|       0|       0.327|      21.162
RTD|       0.355|       3.920|      20.897|       0|       0.327|      21.162
RTD|       0.339|       3.918|      20.912|       0|       0.327|      21.162
RTD|       0.351|       3.920|      20.912|       0|       0.327|      21.162
RTD|       0.369|       3.915|      20.906|       0|       0.327|      21.162
RTD|       0.372|       3.919|      20.927|       0|       0.327|      21.162
RTD|       0.347|       3.915|      20.906|       0|       0.327|      21.162
RTD|       0.338|       3.920|      20.909|       0|       0.327|      21.162
RTD|       0.363|       3.918|      21.035|       0|       0.327|      21.162
RTD|       0.356|       3.920|      21.002|       0|       0.327|      21.162
RTD|       0.359|       3.920|      20.892|       0|       0.327|      21.162
RTT|  00:01:04  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.360|       3.917|      20.905|       0|       0.327|      21.162
RTD|       0.358|       3.919|      20.905|       0|       0.327|      21.162
RTD|       0.342|       3.914|      20.984|       0|       0.327|      21.162
RTD|       0.354|       3.920|      20.995|       0|       0.327|      21.162
RTD|       0.341|       3.914|      20.916|       0|       0.327|      21.162
RTD|       0.357|       3.920|      20.879|       0|       0.327|      21.162
RTD|       0.381|       3.918|      21.094|       0|       0.327|      21.162
RTD|       0.363|       3.918|      21.074|       0|       0.327|      21.162
RTD|       0.337|       3.921|      20.953|       0|       0.327|      21.162
RTD|       0.372|       3.913|      20.963|       0|       0.327|      21.162
RTD|       0.363|       3.920|      20.906|       0|       0.327|      21.162
RTD|       0.338|       3.914|      21.075|       0|       0.327|      21.162
RTD|       0.341|       3.920|      20.961|       0|       0.327|      21.162
RTD|       0.347|       3.918|      20.903|       0|       0.327|      21.162
RTD|       0.343|       3.918|      20.912|       0|       0.327|      21.162
RTD|       0.364|       3.920|      20.925|       0|       0.327|      21.162
RTD|       0.342|       3.918|      20.949|       0|       0.327|      21.162
RTD|       0.348|       3.918|      21.062|       0|       0.327|      21.162
RTD|       0.350|       3.910|      21.071|       0|       0.327|      21.162
RTD|       0.360|       3.919|      21.092|       0|       0.327|      21.162
RTD|       0.344|       3.921|      20.983|       0|       0.327|      21.162
RTT|  00:01:25  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.366|       3.918|      20.920|       0|       0.327|      21.162
RTD|       0.352|       3.920|      21.029|       0|       0.327|      21.162
RTD|       0.350|       3.917|      20.889|       0|       0.327|      21.162
RTD|       0.350|       3.919|      20.948|       0|       0.327|      21.162
RTD|       0.335|       3.912|      20.919|       0|       0.327|      21.162
RTD|       0.356|       3.920|      21.012|       0|       0.327|      21.162
RTD|       0.333|       3.922|      20.918|       0|       0.327|      21.162
RTD|       0.358|       3.920|      21.004|       0|       0.327|      21.162
RTD|       0.351|       3.920|      20.902|       0|       0.327|      21.162
RTD|       0.350|       3.918|      20.938|       0|       0.327|      21.162
RTD|       0.342|       3.916|      21.073|       0|       0.327|      21.162
RTD|       0.350|       3.915|      21.064|       0|       0.327|      21.162
RTD|       0.352|       3.921|      20.977|       0|       0.327|      21.162
RTD|       0.344|       3.914|      20.975|       0|       0.327|      21.162
RTD|       0.345|       3.920|      20.901|       0|       0.327|      21.162
RTD|       0.356|       3.921|      21.054|       0|       0.327|      21.162
RTD|       0.375|       3.913|      21.071|       0|       0.327|      21.162
RTD|       0.349|       3.917|      21.062|       0|       0.327|      21.162
RTD|       0.345|       3.913|      20.945|       0|       0.327|      21.162
RTD|       0.342|       3.919|      20.950|       0|       0.327|      21.162
RTD|       0.364|       3.913|      20.914|       0|       0.327|      21.162
RTT|  00:01:46  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.347|       3.920|      20.977|       0|       0.327|      21.162
RTD|       0.344|       3.919|      20.927|       0|       0.327|      21.162
RTD|       0.364|       3.917|      21.019|       0|       0.327|      21.162
RTD|       0.350|       3.921|      20.916|       0|       0.327|      21.162
RTD|       0.347|       3.919|      20.906|       0|       0.327|      21.162
RTD|       0.365|       3.921|      20.909|       0|       0.327|      21.162
RTD|       0.343|       3.913|      21.094|       0|       0.327|      21.162
RTD|       0.331|       3.920|      21.089|       0|       0.327|      21.162
RTD|       0.352|       3.919|      21.087|       0|       0.327|      21.162
RTD|       0.338|       3.917|      20.999|       0|       0.327|      21.162
RTD|       0.346|       3.919|      20.975|       0|       0.327|      21.162
RTD|       0.348|       3.914|      20.922|       0|       0.327|      21.162
RTD|       0.342|       3.919|      21.073|       0|       0.327|      21.162
RTD|       0.352|       3.914|      21.053|       0|       0.327|      21.162
---|--param|----range-|--samples
HSD|    min|   0 -  1 |      119
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |   996535
HSD|    avg|   1 -  2 |     3397
HSD|    avg|   2 -  3 |        1
HSD|    avg|   9 - 10 |       26
HSD|    avg|  10 - 11 |       25
HSD|    avg|  20 - 21 |   199952
HSD|    avg|  21 - 22 |       48
---|--param|----range-|--samples
HSD|    max|  20 - 21 |       76
HSD|    max|  21 - 22 |       43
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       119|      0.000|      0.000
HSS|    avg|   1199984|      3.337|      7.453
HSS|    max|       119|     20.361|      0.482
---|------------|------------|------------|--------|-------------------------
RTS|       0.327|       3.917|      21.162|       0|    00:02:00/00:02:00

Fr 11. Mai 14:00:55 CEST 2007
running: ./run -- -sh -T 120 -t2 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel timer handler
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -1.994|       1.652|      18.637|       0|      -1.994|      18.637
RTD|      -1.929|       1.649|      18.680|       0|      -1.994|      18.680
RTD|      -1.980|       1.652|      18.660|       0|      -1.994|      18.680
RTD|      -1.933|       1.650|      18.623|       0|      -1.994|      18.680
RTD|      -2.002|       1.642|      18.735|       0|      -2.002|      18.735
RTD|      -1.951|       1.651|      18.626|       0|      -2.002|      18.735
RTD|      -1.979|       1.650|      18.687|       0|      -2.002|      18.735
RTD|      -1.991|       1.650|      18.663|       0|      -2.002|      18.735
RTD|      -2.027|       1.651|      18.692|       0|      -2.027|      18.735
RTD|      -2.016|       1.644|      18.610|       0|      -2.027|      18.735
RTD|      -2.037|       1.650|      18.612|       0|      -2.037|      18.735
RTD|      -1.930|       1.651|      18.629|       0|      -2.037|      18.735
RTD|      -1.950|       1.650|      18.655|       0|      -2.037|      18.735
RTD|      -1.945|       1.651|      18.680|       0|      -2.037|      18.735
RTD|      -2.044|       1.643|      18.663|       0|      -2.044|      18.735
RTD|      -1.993|       1.649|      18.611|       0|      -2.044|      18.735
RTD|      -1.965|       1.650|      18.678|       0|      -2.044|      18.735
RTD|      -1.948|       1.650|      18.658|       0|      -2.044|      18.735
RTD|      -1.935|       1.650|      18.626|       0|      -2.044|      18.735
RTD|      -1.924|       1.644|      19.250|       0|      -2.044|      19.250
RTD|      -1.978|       1.652|      18.620|       0|      -2.044|      19.250
RTT|  00:00:22  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -2.013|       1.650|      18.610|       0|      -2.044|      19.250
RTD|      -1.963|       1.650|      18.611|       0|      -2.044|      19.250
RTD|      -1.972|       1.652|      18.629|       0|      -2.044|      19.250
RTD|      -2.009|       1.642|      18.748|       0|      -2.044|      19.250
RTD|      -1.963|       1.650|      18.610|       0|      -2.044|      19.250
RTD|      -1.985|       1.652|      18.685|       0|      -2.044|      19.250
RTD|      -1.978|       1.650|      18.691|       0|      -2.044|      19.250
RTD|      -2.006|       1.651|      18.613|       0|      -2.044|      19.250
RTD|      -1.970|       1.642|      18.632|       0|      -2.044|      19.250
RTD|      -2.021|       1.650|      18.611|       0|      -2.044|      19.250
RTD|      -1.977|       1.650|      18.677|       0|      -2.044|      19.250
RTD|      -1.956|       1.650|      18.653|       0|      -2.044|      19.250
RTD|      -2.041|       1.652|      18.681|       0|      -2.044|      19.250
RTD|      -1.988|       1.641|      18.698|       0|      -2.044|      19.250
RTD|      -2.006|       1.650|      18.704|       0|      -2.044|      19.250
RTD|      -1.977|       1.650|      18.657|       0|      -2.044|      19.250
RTD|      -2.028|       1.651|      18.705|       0|      -2.044|      19.250
RTD|      -1.999|       1.650|      18.715|       0|      -2.044|      19.250
RTD|      -2.013|       1.643|      18.698|       0|      -2.044|      19.250
RTD|      -2.022|       1.650|      18.614|       0|      -2.044|      19.250
RTD|      -1.925|       1.649|      18.657|       0|      -2.044|      19.250
RTT|  00:00:43  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -2.005|       1.650|      18.914|       0|      -2.044|      19.250
RTD|      -2.033|       1.651|      18.611|       0|      -2.044|      19.250
RTD|      -1.997|       1.644|      19.716|       0|      -2.044|      19.716
RTD|      -1.995|       1.650|      18.611|       0|      -2.044|      19.716
RTD|      -1.975|       1.652|      18.620|       0|      -2.044|      19.716
RTD|      -1.972|       1.649|      18.615|       0|      -2.044|      19.716
RTD|      -1.990|       1.650|      18.653|       0|      -2.044|      19.716
RTD|      -2.004|       1.643|      18.704|       0|      -2.044|      19.716
RTD|      -1.949|       1.650|      18.615|       0|      -2.044|      19.716
RTD|      -1.995|       1.650|      18.656|       0|      -2.044|      19.716
RTD|      -1.968|       1.651|      18.692|       0|      -2.044|      19.716
RTD|      -1.974|       1.651|      18.619|       0|      -2.044|      19.716
RTD|      -1.934|       1.642|      18.604|       0|      -2.044|      19.716
RTD|      -1.989|       1.652|      18.628|       0|      -2.044|      19.716
RTD|      -2.000|       1.650|      18.705|       0|      -2.044|      19.716
RTD|      -1.951|       1.652|      18.662|       0|      -2.044|      19.716
RTD|      -1.994|       1.653|      18.690|       0|      -2.044|      19.716
RTD|      -2.025|       1.643|      18.962|       0|      -2.044|      19.716
RTD|      -1.974|       1.649|      18.611|       0|      -2.044|      19.716
RTD|      -1.954|       1.651|      18.627|       0|      -2.044|      19.716
RTD|      -2.017|       1.653|      18.676|       0|      -2.044|      19.716
RTT|  00:01:04  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -1.949|       1.650|      18.671|       0|      -2.044|      19.716
RTD|      -2.040|       1.642|      18.733|       0|      -2.044|      19.716
RTD|      -2.022|       1.650|      18.645|       0|      -2.044|      19.716
RTD|      -2.017|       1.649|      18.711|       0|      -2.044|      19.716
RTD|      -2.037|       1.652|      18.631|       0|      -2.044|      19.716
RTD|      -2.009|       1.650|      18.659|       0|      -2.044|      19.716
RTD|      -1.992|       1.644|      18.650|       0|      -2.044|      19.716
RTD|      -2.017|       1.650|      18.613|       0|      -2.044|      19.716
RTD|      -2.014|       1.650|      18.610|       0|      -2.044|      19.716
RTD|      -1.937|       1.650|      18.640|       0|      -2.044|      19.716
RTD|      -1.986|       1.650|      18.660|       0|      -2.044|      19.716
RTD|      -1.981|       1.643|      18.698|       0|      -2.044|      19.716
RTD|      -2.001|       1.649|      18.611|       0|      -2.044|      19.716
RTD|      -1.995|       1.653|      18.672|       0|      -2.044|      19.716
RTD|      -1.986|       1.650|      18.697|       0|      -2.044|      19.716
RTD|      -1.995|       1.649|      18.634|       0|      -2.044|      19.716
RTD|      -2.001|       1.652|      18.630|       0|      -2.044|      19.716
RTD|      -2.016|       1.650|      18.611|       0|      -2.044|      19.716
RTD|      -2.044|       1.651|      18.694|       0|      -2.044|      19.716
RTD|      -2.012|       1.651|      18.681|       0|      -2.044|      19.716
RTD|      -2.029|       1.650|      18.684|       0|      -2.044|      19.716
RTT|  00:01:25  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -1.993|       1.647|      18.690|       0|      -2.044|      19.716
RTD|      -1.968|       1.650|      18.636|       0|      -2.044|      19.716
RTD|      -2.004|       1.650|      18.654|       0|      -2.044|      19.716
RTD|      -1.991|       1.649|      18.700|       0|      -2.044|      19.716
RTD|      -1.921|       1.651|      18.675|       0|      -2.044|      19.716
RTD|      -1.990|       1.653|      18.776|       0|      -2.044|      19.716
RTD|      -2.036|       1.642|      18.604|       0|      -2.044|      19.716
RTD|      -1.993|       1.642|      18.635|       0|      -2.044|      19.716
RTD|      -1.949|       1.642|      18.606|       0|      -2.044|      19.716
RTD|      -1.978|       1.642|      18.598|       0|      -2.044|      19.716
RTD|      -1.983|       1.641|      18.595|       0|      -2.044|      19.716
RTD|      -2.028|       1.642|      18.595|       0|      -2.044|      19.716
RTD|      -1.977|       1.642|      18.605|       0|      -2.044|      19.716
RTD|      -2.036|       1.642|      18.602|       0|      -2.044|      19.716
RTD|      -1.985|       1.646|      18.659|       0|      -2.044|      19.716
RTD|      -2.021|       1.641|      18.699|       0|      -2.044|      19.716
RTD|      -1.996|       1.642|      18.701|       0|      -2.044|      19.716
RTD|      -2.036|       1.642|      18.681|       0|      -2.044|      19.716
RTD|      -2.020|       1.643|      18.645|       0|      -2.044|      19.716
RTD|      -1.937|       1.642|      18.610|       0|      -2.044|      19.716
RTD|      -2.002|       1.650|      18.740|       0|      -2.044|      19.716
RTT|  00:01:46  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -1.988|       1.643|      18.606|       0|      -2.044|      19.716
RTD|      -2.020|       1.642|      18.665|       0|      -2.044|      19.716
RTD|      -1.947|       1.644|      18.675|       0|      -2.044|      19.716
RTD|      -2.020|       1.642|      18.692|       0|      -2.044|      19.716
RTD|      -1.969|       1.643|      18.606|       0|      -2.044|      19.716
RTD|      -1.930|       1.641|      18.696|       0|      -2.044|      19.716
RTD|      -1.982|       1.643|      18.627|       0|      -2.044|      19.716
RTD|      -1.999|       1.648|      18.674|       0|      -2.044|      19.716
RTD|      -2.012|       1.649|      18.695|       0|      -2.044|      19.716
RTD|      -1.961|       1.643|      18.660|       0|      -2.044|      19.716
RTD|      -2.005|       1.643|      18.612|       0|      -2.044|      19.716
RTD|      -1.954|       1.646|      18.668|       0|      -2.044|      19.716
RTD|      -1.952|       1.650|      18.693|       0|      -2.044|      19.716
RTD|      -1.964|       1.651|      18.661|       0|      -2.044|      19.716
---|--param|----range-|--samples
HSD|    min|   1 -  2 |       74
HSD|    min|   2 -  3 |       45
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |     1230
HSD|    avg|   1 -  2 |   998640
HSD|    avg|   2 -  3 |       53
HSD|    avg|   8 -  9 |       30
HSD|    avg|  18 - 19 |   200023
HSD|    avg|  19 - 20 |        2
---|--param|----range-|--samples
HSD|    max|  18 - 19 |      117
HSD|    max|  19 - 20 |        2
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       119|      1.378|      0.487
HSS|    avg|   1199978|      3.833|      6.336
HSS|    max|       119|     18.017|      0.129
---|------------|------------|------------|--------|-------------------------
RTS|      -2.044|       1.647|      19.716|       0|    00:02:00/00:02:00

Fr 11. Mai 14:02:56 CEST 2007
running: ./run -- -T 120 # switchtest
*
*
* Type ^C to stop this application.
*
*
== Testing FPU check routines...
r0: 1 != 2
r1: 1 != 2
r2: 1 != 2
r3: 1 != 2
r4: 1 != 2
r5: 1 != 2
r6: 1 != 2
r7: 1 != 2
== FPU check routines: OK.
== Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4 rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10 rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16 rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2 rtk_fp1-3 rtk_fp1-4 rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8 rtup_ufpp1-9 rtup_ufpp1-10 rtus1-11 rtus1-12 rtus_ufps1-13 rtus_ufps1-14 rtuo1-15 rtuo1-16 rtuo_ufpp1-17 rtuo_ufpp1-18 rtuo_ufps1-19 rtuo_ufps1-20 rtuo_ufpp_ufps1-21 rtuo_ufpp_ufps1-22
RTT|  00:00:01
RTH|---------cpu|ctx switches|-------total
RTD|           1|       11500|       11500
RTD|           0|       11500|       11500
RTD|           1|       11523|       23023
RTD|           0|       11523|       23023
RTD|           1|       11523|       34546
RTD|           0|       11523|       34546
RTD|           1|       11523|       46069
RTD|           0|       11523|       46069
RTD|           1|       11523|       57592
RTD|           0|       11523|       57592
RTD|           1|       11523|       69115
RTD|           0|       11523|       69115
RTD|           1|       11523|       80638
RTD|           0|       11523|       80638
RTD|           1|       11523|       92161
RTD|           0|       11523|       92161
RTD|           1|       11523|      103684
RTD|           0|       11523|      103684
RTD|           1|       11523|      115207
RTD|           0|       11523|      115207
RTD|           1|       11523|      126730
RTT|  00:00:11
RTH|---------cpu|ctx switches|-------total
RTD|           0|       11523|      126730
RTD|           1|       11523|      138253
RTD|           0|       11523|      138253
RTD|           1|       11523|      149776
RTD|           0|       11523|      149776
RTD|           1|       11523|      161299
RTD|           0|       11523|      161299
RTD|           1|       11523|      172822
RTD|           0|       11523|      172822
RTD|           1|       11523|      184345
RTD|           0|       11523|      184345
RTD|           1|       11523|      195868
RTD|           0|       11523|      195868
RTD|           1|       11523|      207391
RTD|           0|       11523|      207391
RTD|           1|       11523|      218914
RTD|           0|       11523|      218914
RTD|           1|       11523|      230437
RTD|           0|       11523|      230437
RTD|           1|       11523|      241960
RTD|           0|       11523|      241960
RTT|  00:00:22
RTH|---------cpu|ctx switches|-------total
RTD|           1|       11523|      253483
RTD|           0|       11523|      253483
RTD|           1|       11523|      265006
RTD|           0|       11523|      265006
RTD|           1|       11523|      276529
RTD|           0|       11523|      276529
RTD|           1|       11523|      288052
RTD|           0|       11523|      288052
RTD|           1|       11523|      299575
RTD|           0|       11523|      299575
RTD|           1|       11523|      311098
RTD|           0|       11523|      311098
RTD|           1|       11523|      322621
RTD|           0|       11523|      322621
RTD|           1|        7820|      330441
RTD|           0|        7820|      330441
RTD|           0|        7682|      338123
RTD|           1|        7682|      338123
RTD|           1|        7682|      345805
RTD|           0|        7682|      345805
RTD|           1|        7682|      353487
RTT|  00:00:32
RTH|---------cpu|ctx switches|-------total
RTD|           0|        7682|      353487
RTD|           1|        7682|      361169
RTD|           0|        7682|      361169
RTD|           1|        7682|      368851
RTD|           0|        7682|      368851
RTD|           1|        7682|      376533
RTD|           0|        7682|      376533
RTD|           0|        7682|      384215
RTD|           1|        7682|      384215
RTD|           1|        7682|      391897
RTD|           0|        7682|      391897
RTD|           1|        7682|      399579
RTD|           0|        7682|      399579
RTD|           0|        7682|      407261
RTD|           1|        7682|      407261
RTD|           1|        7682|      414943
RTD|           0|        7682|      414943
RTD|           1|        7682|      422625
RTD|           0|        7682|      422625
RTD|           1|        7682|      430307
RTD|           0|        7682|      430307
RTT|  00:00:43
RTH|---------cpu|ctx switches|-------total
RTD|           0|        7682|      437989
RTD|           1|        7682|      437989
RTD|           1|        9016|      447005
RTD|           0|        9016|      447005
RTD|           0|        9959|      456964
RTD|           1|        9982|      456987
RTD|           1|       10925|      467912
RTD|           0|       10948|      467912
RTD|           1|       11523|      479435
RTD|           0|       11523|      479435
RTD|           1|       11523|      490958
RTD|           0|       11523|      490958
RTD|           1|       11523|      502481
RTD|           0|       11523|      502481
RTD|           1|       11523|      514004
RTD|           0|       11523|      514004
RTD|           1|       11523|      525527
RTD|           0|       11523|      525527
RTD|           1|       11523|      537050
RTD|           0|       11523|      537050
RTD|           1|       11523|      548573
RTT|  00:00:53
RTH|---------cpu|ctx switches|-------total
RTD|           0|       11523|      548573
RTD|           1|       11523|      560096
RTD|           0|       11523|      560096
RTD|           1|       11523|      571619
RTD|           0|       11523|      571619
RTD|           1|       11523|      583142
RTD|           0|       11523|      583142
RTD|           1|       11523|      594665
RTD|           0|       11523|      594665
RTD|           1|       11523|      606188
RTD|           0|       11523|      606188
RTD|           1|       11523|      617711
RTD|           0|       11523|      617711
RTD|           1|       11523|      629234
RTD|           0|       11523|      629234
RTD|           1|       11523|      640757
RTD|           0|       11523|      640757
RTD|           1|       11523|      652280
RTD|           0|       11523|      652280
RTD|           1|       11523|      663803
RTD|           0|       11523|      663803
RTT|  00:01:04
RTH|---------cpu|ctx switches|-------total
RTD|           1|       11523|      675326
RTD|           0|       11523|      675326
RTD|           1|       11523|      686849
RTD|           0|       11523|      686849
RTD|           1|       11523|      698372
RTD|           0|       11523|      698372
RTD|           1|       11523|      709895
RTD|           0|       11523|      709895
RTD|           1|       11523|      721418
RTD|           0|       11523|      721418
RTD|           1|       11523|      732941
RTD|           0|       11523|      732941
RTD|           1|       11523|      744464
RTD|           0|       11523|      744464
RTD|           1|       11523|      755987
RTD|           0|       11523|      755987
RTD|           1|       11523|      767510
RTD|           0|       11523|      767510
RTD|           1|       11523|      779033
RTD|           0|       11523|      779033
RTD|           1|       11523|      790556
RTT|  00:01:14
RTH|---------cpu|ctx switches|-------total
RTD|           0|       11523|      790556
RTD|           1|       11523|      802079
RTD|           0|       11523|      802079
RTD|           1|       11523|      813602
RTD|           0|       11523|      813602
RTD|           1|       11523|      825125
RTD|           0|       11523|      825125
RTD|           1|       11523|      836648
RTD|           0|       11523|      836648
RTD|           1|       11523|      848171
RTD|           0|       11523|      848171
RTD|           1|       11523|      859694
RTD|           0|       11523|      859694
RTD|           1|       11523|      871217
RTD|           0|       11523|      871217
RTD|           1|       11523|      882740
RTD|           0|       11523|      882740
RTD|           1|       11523|      894263
RTD|           0|       11523|      894263
RTD|           1|       11523|      905786
RTD|           0|       11523|      905786
RTT|  00:01:25
RTH|---------cpu|ctx switches|-------total
RTD|           1|       11523|      917309
RTD|           0|       11523|      917309
RTD|           1|       11523|      928832
RTD|           0|       11523|      928832
RTD|           1|       11523|      940355
RTD|           0|       11523|      940355
RTD|           1|       11523|      951878
RTD|           0|       11523|      951878
RTD|           1|       11523|      963401
RTD|           0|       11523|      963401
RTD|           1|       11523|      974924
RTD|           0|       11523|      974924
RTD|           1|       11523|      986447
RTD|           0|       11523|      986447
RTD|           1|       11523|      997970
RTD|           0|       11523|      997970
RTD|           1|       11523|     1009493
RTD|           0|       11523|     1009493
RTD|           1|        9591|     1019084
RTD|           0|        9591|     1019084
RTD|           1|        7682|     1026766
RTT|  00:01:35
RTH|---------cpu|ctx switches|-------total
RTD|           0|        7682|     1026766
RTD|           1|        7682|     1034448
RTD|           0|        7682|     1034448
RTD|           1|        7682|     1042130
RTD|           0|        7682|     1042130
RTD|           1|        7682|     1049812
RTD|           0|        7682|     1049812
RTD|           1|        7682|     1057494
RTD|           0|        7682|     1057494
RTD|           1|        7682|     1065176
RTD|           0|        7682|     1065176
RTD|           1|        7682|     1072858
RTD|           0|        7682|     1072858
RTD|           1|        7682|     1080540
RTD|           0|        7682|     1080540
RTD|           1|        7682|     1088222
RTD|           0|        7682|     1088222
RTD|           1|        7682|     1095904
RTD|           0|        7682|     1095904
RTD|           1|        7682|     1103586
RTD|           0|        7682|     1103586
RTT|  00:01:46
RTH|---------cpu|ctx switches|-------total
RTD|           1|        7682|     1111268
RTD|           0|        7682|     1111268
RTD|           1|        7682|     1118950
RTD|           0|        7682|     1118950
RTD|           1|        7682|     1126632
RTD|           0|        7682|     1126632
RTD|           1|        8211|     1134843
RTD|           0|        8211|     1134843
RTD|           1|        9890|     1144733
RTD|           0|        9890|     1144733
RTD|           1|       10327|     1155060
RTD|           0|       10350|     1155083
RTD|           1|       11454|     1166514
RTD|           0|       11454|     1166537
RTD|           1|       11523|     1178037
RTD|           0|       11523|     1178060
RTD|           1|       11109|     1189146
RTD|           0|       11086|     1189146
RTD|           1|       11523|     1200669
RTD|           0|       11523|     1200669
RTD|           1|       11523|     1212192
RTT|  00:01:56
RTH|---------cpu|ctx switches|-------total
RTD|           0|       11523|     1212192
RTD|           1|       11523|     1223715
RTD|           0|       11523|     1223715
RTD|           1|       11523|     1235238
RTD|           0|       11523|     1235238
RTD|           1|       11523|     1246761
RTD|           0|       11523|     1246761
RTD|           0|        9033|     1255794
RTD|           1|        9039|     1255800

Fr 11. Mai 14:04:56 CEST 2007
running: ./run -- -h # switchbench
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|       5.090|       6.016|       6.692|           0
---|---range-|---samples
HSD| 5 - 6 |       6143
HSD| 6 - 7 |      93853
HSS|     99996|      5.939|      0.240

Fr 11. Mai 14:05:06 CEST 2007
running: ./run -- -p 10 -n -l 1000 # cyclictest
*
*
* Type ^C to stop this application.
*
*
0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:      12 Min:     660 Act:     660 Avg:    6144 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:      23 Min:       1 Act:      21 Avg:    3215 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:      34 Min:       1 Act:      11 Avg:    2180 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:      45 Min:       1 Act:      32 Avg:    1652 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:      56 Min:       1 Act:      11 Avg:    1332 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:      67 Min:       1 Act:      31 Avg:    1117 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:      78 Min:       1 Act:      11 Avg:     962 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:      89 Min:       1 Act:      11 Avg:     845 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     100 Min:       1 Act:      11 Avg:     754 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     111 Min:       1 Act:      22 Avg:     681 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     122 Min:       1 Act:      21 Avg:     622 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     133 Min:       1 Act:      21 Avg:     572 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     144 Min:       1 Act:      21 Avg:     530 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     155 Min:       1 Act:      21 Avg:     494 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     166 Min:       1 Act:      21 Avg:     462 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     177 Min:       1 Act:      21 Avg:     435 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     188 Min:       1 Act:      11 Avg:     411 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     199 Min:       1 Act:      32 Avg:     389 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     210 Min:       1 Act:      11 Avg:     370 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     221 Min:       1 Act:      31 Avg:     352 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     232 Min:       1 Act:      11 Avg:     337 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     243 Min:       1 Act:      32 Avg:     322 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     254 Min:       1 Act:      21 Avg:     309 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     265 Min:       1 Act:      21 Avg:     297 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     276 Min:       1 Act:      21 Avg:     286 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     287 Min:       1 Act:      22 Avg:     276 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     298 Min:       1 Act:      21 Avg:     267 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     309 Min:       1 Act:      21 Avg:     258 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     320 Min:       1 Act:      22 Avg:     250 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     331 Min:       1 Act:      21 Avg:     242 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     342 Min:       1 Act:      21 Avg:     235 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     353 Min:       1 Act:      21 Avg:     228 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     364 Min:       1 Act:      21 Avg:     222 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     375 Min:       1 Act:      21 Avg:     216 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     386 Min:       1 Act:      21 Avg:     211 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     397 Min:       1 Act:      21 Avg:     205 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     408 Min:       1 Act:      21 Avg:     200 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     419 Min:       1 Act:      21 Avg:     196 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     430 Min:       1 Act:      21 Avg:     191 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     441 Min:       1 Act:      21 Avg:     187 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     452 Min:       1 Act:      21 Avg:     183 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     463 Min:       1 Act:      21 Avg:     179 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     474 Min:       1 Act:      22 Avg:     175 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     485 Min:       1 Act:      21 Avg:     172 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     496 Min:       1 Act:      21 Avg:     169 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     507 Min:       1 Act:      21 Avg:     165 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     518 Min:       1 Act:      21 Avg:     162 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     529 Min:       1 Act:      21 Avg:     159 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     540 Min:       1 Act:      21 Avg:     157 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     551 Min:       1 Act:      21 Avg:     154 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     562 Min:       1 Act:      21 Avg:     151 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     573 Min:       1 Act:      21 Avg:     149 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     584 Min:       1 Act:      21 Avg:     146 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     595 Min:       1 Act:      21 Avg:     144 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     606 Min:       1 Act:      21 Avg:     142 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     617 Min:       1 Act:      22 Avg:     140 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     628 Min:       1 Act:      21 Avg:     138 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     639 Min:       1 Act:      21 Avg:     136 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     650 Min:       1 Act:      21 Avg:     134 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     661 Min:       1 Act:      21 Avg:     132 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     672 Min:       1 Act:      21 Avg:     130 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     683 Min:       1 Act:      22 Avg:     128 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     694 Min:       1 Act:      21 Avg:     126 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     705 Min:       1 Act:      21 Avg:     125 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     716 Min:       1 Act:      21 Avg:     123 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     727 Min:       1 Act:      21 Avg:     122 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     738 Min:       1 Act:      21 Avg:     120 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     749 Min:       1 Act:      21 Avg:     119 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     760 Min:       1 Act:      21 Avg:     117 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     771 Min:       1 Act:      21 Avg:     116 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     782 Min:       1 Act:      21 Avg:     115 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     793 Min:       1 Act:      21 Avg:     113 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     804 Min:       1 Act:      21 Avg:     112 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     815 Min:       1 Act:      21 Avg:     111 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     826 Min:       1 Act:      21 Avg:     110 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     837 Min:       1 Act:      21 Avg:     108 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     848 Min:       1 Act:      21 Avg:     107 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     859 Min:       1 Act:      21 Avg:     106 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     870 Min:       1 Act:      21 Avg:     105 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     881 Min:       1 Act:      21 Avg:     104 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     892 Min:       1 Act:      21 Avg:     103 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     903 Min:       1 Act:      21 Avg:     102 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     914 Min:       1 Act:      21 Avg:     101 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     925 Min:       1 Act:      21 Avg:     100 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     936 Min:       1 Act:      21 Avg:      99 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     947 Min:       1 Act:      21 Avg:      98 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     958 Min:       1 Act:      21 Avg:      97 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     969 Min:       1 Act:      21 Avg:      96 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     980 Min:       1 Act:      21 Avg:      96 Max:   11626
[3A0.00 0.02 0.02 1/58 3815          

T: 0 ( 3815) P:10 I:    1000 C:     991 Min:       1 Act:      21 Avg:      95 Max:   11626
[3A0.00 0.02 0.02 1/57 3815          

T: 0 ( 3815) P:10 I:    1000 C:    1000 Min:       1 Act:      21 Avg:      94 Max:   11626

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/interrupts
           CPU0       CPU1       
  0:     564142          0  local-APIC-edge-fasteio   timer, rthal_broadcast_timer
  1:        241          0   IO-APIC-edge      i8042
  2:          0          0    XT-PIC-XT        cascade
  8:          3          0   IO-APIC-edge      rtc
 12:        132          0   IO-APIC-edge      i8042
 14:       2157          0   IO-APIC-edge      libata
 15:         21          0   IO-APIC-edge      libata
 18:          0          0   IO-APIC-fasteoi   libata
 20:         69          0   IO-APIC-fasteoi   ehci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb5
 21:        104          0   IO-APIC-fasteoi   uhci_hcd:usb4, uhci_hcd:usb6, HDA Intel
 22:         32          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb7
NMI:          0          0 
LOC:     563981     563979 
ERR:          0
MIS:          0

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/loadavg
0.00 0.02 0.02 1/53 3827

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/meminfo
MemTotal:       905564 kB
MemFree:        863540 kB
Buffers:          4416 kB
Cached:          19280 kB
SwapCached:          0 kB
Active:          19264 kB
Inactive:         8896 kB
SwapTotal:     3004112 kB
SwapFree:      3004112 kB
Dirty:              60 kB
Writeback:           0 kB
AnonPages:        4496 kB
Mapped:           2356 kB
Slab:             7512 kB
SReclaimable:     2256 kB
SUnreclaim:       5256 kB
PageTables:        276 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   3456892 kB
Committed_AS:     8276 kB
VmallocTotal:   122600 kB
VmallocUsed:      4400 kB
VmallocChunk:   117668 kB

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/apc
APC          CPU0         CPU1
  0:            0           0    (pipe_wakeup)
  1:       218694      218573    (lostage_handler)
  2:            6           0    (registry_export)
  3:            0           0    (posix_signals_handler)

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/faults
TRAP         CPU0        CPU1
  0:            0           0    (Divide error)
  1:            0           0    (Debug)
  3:            0           0    (Int3)
  4:            0           0    (Overflow)
  5:            0           0    (Bounds)
  6:            0           0    (Invalid opcode)
  7:            0           1    (FPU not available)
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

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/hal
1.7-03

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/heap
size=130560:used=64:pagesz=512

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/irq
IRQ         CPU0        CPU1
213:          10           0
216:     2533261     1211510         [timer]
217:           0           0
226:     1107518     1107283         [virtual]

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/latency
2699

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT/0
  1  0       -1      0        0          R          ROOT/1

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          1884059    0     00500080   97.1  ROOT/0
  1  0      0          1772046    0     00500080   98.1  ROOT/1
  0  0      0          2533261    0     00000000    0.6  IRQ216: [timer]
  1  0      0          1211510    0     00000000    0.4  IRQ216: [timer]

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/timer
status=oneshot+watchdog:setup=55:tickval=1:jiffies=564206093613

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/version
2.3.1

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/interfaces/native
0

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/interfaces/posix
0

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/interfaces/rtdm
0

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/interfaces/sys
0

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				Driver		/proc

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device

Fr 11. Mai 14:05:08 CEST 2007
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Fr 11. Mai 14:05:08 CEST 2007
running: top -bn1c
top - 14:05:09 up 9 min,  1 user,  load average: 0.00, 0.02, 0.02
Tasks:  55 total,   1 running,  54 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.2%us,  0.4%sy,  0.0%ni, 98.8%id,  0.6%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:    905564k total,    42148k used,   863416k free,     4416k buffers
Swap:  3004112k total,        0k used,  3004112k free,    19280k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
    1 root      19   0  2908 1844  524 S    0  0.2   0:00.73 /sbin/init         
    2 root      RT   0     0    0    0 S    0  0.0   0:00.00 [migration/0]      
    3 root      34  19     0    0    0 S    0  0.0   0:00.00 [ksoftirqd/0]      
cleanup_load: no dd_jobs found
xeno-test: finished

--========GMX282091178882662983051--

