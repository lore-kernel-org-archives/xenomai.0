Content-Type: multipart/mixed; boundary="========GMX307801178798978763319"
Date: Thu, 10 May 2007 14:09:38 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
Message-ID: <20070510120938.307800@domain.hid>
MIME-Version: 1.0
Subject: [Xenomai-help] high latency with Intel Core 2 Duo
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

--========GMX307801178798978763319
Content-Type: multipart/alternative;
 boundary="========GMXBoundary307801178798978763660"

--========GMXBoundary307801178798978763660
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

=A0I'm using an Intel Core 2 Duo at work and an AMD XP3000+ at home. I inst=
alled Xenomai 2.3.1 with nearly same configuration at both and run the xeno=
-test. I get 10 times higher latency with Core 2 Duo. How is it possible? M=
ay the SMP be the reason?

=A0See logs in attachment.

=A0Thanks

Karl

--========GMXBoundary307801178798978763660
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<p>Hello,</p><p>&nbsp;</p><p>I&#39;m using an Intel Core 2 Duo at work and =
an AMD XP3000+ at home. I installed Xenomai 2.3.1 with nearly same configur=
ation at both and run the xeno-test. I get 10 times higher latency with Cor=
e 2 Duo. How is it possible? May the SMP be the reason?</p><p>&nbsp;</p><p>=
See logs in attachment.</p><p>&nbsp;</p><p>Thanks</p><p>Karl</p>

--========GMXBoundary307801178798978763660--

--========GMX307801178798978763319
Content-Type: text/plain; charset="iso-8859-15"; name="[home]xeno-test.txt"
Content-Transfer-Encoding: 8bit
Content-Description: attachment

xeno-test: started 
withBusybox is 0
xeno-test: running tests

Mi 9. Mai 21:55:21 CEST 2007
running: bin/xeno-config --verbose
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

Mi 9. Mai 21:55:21 CEST 2007
running: bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux rtlinux 2.6.20-adeos-xenomai2.3.0 #5 SMP Thu Apr 26 21:44:07 CEST 2007 i686 GNU/Linux
 
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
Modules Loaded         radeon drm ppdev ipv6 capability commoncap sbs button battery dock i2c_ec container ac fan video asus_acpi backlight af_packet lp usbhid snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss b2c2_flexcop_pci b2c2_flexcop e1000 mt352 mt312 bcm3510 stv0297 nxt200x lgdt330x stv0299 dvb_core lgh06xf dvb_pll snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq ide_cd cdrom snd_timer snd_seq_device parport_pc parport xeno_irqbench snd soundcore ehci_hcd i2c_nforce2 forcedeth snd_page_alloc shpchp pci_hotplug ohci_hcd i2c_core nvidia_agp agpgart usbcore ide_disk ata_generic sata_nv pata_amd libata scsi_mod amd74xx generic evdev fbcon tileblit font bitblit softcursor

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 10
model name	: AMD Athlon(tm) XP 3000+
stepping	: 0
cpu MHz		: 2091.653
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow up ts
bogomips	: 4184.19
clflush size	: 32


Mi 9. Mai 21:55:22 CEST 2007
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
d68af3a1f5492b384a7a07cde93d2c3e  /proc/cpuinfo
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y
CONFIG_IPIPE=y
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set
# CONFIG_PM_SYSFS_DEPRECATED is not set
CONFIG_ACPI=y
# CONFIG_ACPI_SLEEP is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_DOCK=m
# CONFIG_ACPI_PROCESSOR is not set
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_IBM=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_BLACKLIST_YEAR=2000
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_CONTAINER=m
CONFIG_ACPI_SBS=m
# CONFIG_CPU_FREQ is not set
# CONFIG_IPIPE_DEBUG is not set
CONFIG_IPIPE_TRACE_ENABLE_VALUE=0
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/ipipe/Linux
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
   0:  A....
   1:  A....
   2:  A.L..
   3:  A....
   4:  A....
   5:  A.L..
   6:  A.L..
   7:  A.L..
   8:  A....
   9:  A....
  10:  A.L..
  11:  A.L..
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

Mi 9. Mai 21:55:22 CEST 2007
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

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/ipipe/version
1.7-03

Mi 9. Mai 21:55:22 CEST 2007
running: generate_loads 1
eval: 1: arith: syntax error: "jobsct-1"
cleanup_load: no dd_jobs found

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/interrupts
           CPU0       
  0:     453372   IO-APIC-edge      timer, rthal_broadcast_timer
  1:        742   IO-APIC-edge      i8042
  8:          3   IO-APIC-edge      rtc
  9:          0   IO-APIC-fasteoi   acpi
 14:      21744   IO-APIC-edge      ide0
 15:       3955   IO-APIC-edge      ide1
 16:      56860   IO-APIC-fasteoi   ohci_hcd:usb1, eth0
 17:          0   IO-APIC-fasteoi   ohci_hcd:usb2, NVidia nForce2
 18:          2   IO-APIC-fasteoi   ehci_hcd:usb3
 19:          0   IO-APIC-fasteoi   Technisat/B2C2 FlexCop II/IIb/III Digital TV PCI Driver
 20:      18188   IO-APIC-fasteoi   radeon@domain.hid
NMI:          0 
LOC:     453251 
ERR:          0
MIS:          0

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/loadavg
0.46 0.29 0.13 4/59 4408

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/meminfo
MemTotal:      1035240 kB
MemFree:        706868 kB
Buffers:         70924 kB
Cached:         182576 kB
SwapCached:          0 kB
Active:         141520 kB
Inactive:       148120 kB
HighTotal:      131008 kB
HighFree:         2768 kB
LowTotal:       904232 kB
LowFree:        704100 kB
SwapTotal:      481908 kB
SwapFree:       481908 kB
Dirty:             172 kB
Writeback:           0 kB
AnonPages:       36160 kB
Mapped:          14772 kB
Slab:            22068 kB
SReclaimable:    14220 kB
SUnreclaim:       7848 kB
PageTables:        820 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:    999528 kB
Committed_AS:    46376 kB
VmallocTotal:   114680 kB
VmallocUsed:      8060 kB
VmallocChunk:   105460 kB

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:           40    (lostage_handler)
  2:            2    (registry_export)
  3:            0    (posix_signals_handler)

Mi 9. Mai 21:55:22 CEST 2007
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

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/hal
1.7-03

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/heap
size=130560:used=64:pagesz=512

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/irq
IRQ         CPU0
213:           0
216:      364919         [timer]
217:           0
226:          79         [virtual]

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/latency
2699

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT/0

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          364093     0     00500080   98.4  ROOT/0
  0  0      0          364919     0     00000000    0.4  IRQ216: [timer]

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/timer
status=oneshot+watchdog:setup=33:tickval=1:jiffies=471668628116

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/version
2.3.1

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/interfaces/native
0

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/interfaces/posix
0

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/interfaces/rtdm
0

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/interfaces/sys
0

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				Driver		/proc
D6	rttest0                        	xeno_irqbench  	rttest0

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device

Mi 9. Mai 21:55:22 CEST 2007
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Mi 9. Mai 21:55:22 CEST 2007
running: top -bn1c
top - 21:55:22 up 7 min,  1 user,  load average: 0.46, 0.29, 0.13
Tasks:  61 total,   1 running,  60 sleeping,   0 stopped,   0 zombie
Cpu(s):  7.3%us,  2.0%sy,  0.3%ni, 71.6%id, 18.7%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   1035240k total,   328736k used,   706504k free,    70924k buffers
Swap:   481908k total,        0k used,   481908k free,   182576k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
    1 root      18   0  2912 1844  524 S  0.0  0.2   0:00.70 /sbin/init         
    2 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 [migration/0]      
    3 root      34  19     0    0    0 S  0.0  0.0   0:00.00 [ksoftirqd/0]      

Mi 9. Mai 21:55:22 CEST 2007
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
RTD|      -0.196|       0.049|       1.746|       0|      -0.196|       1.746
RTD|      -0.196|       0.061|       1.705|       0|      -0.196|       1.746
RTD|      -0.191|       0.057|       1.808|       0|      -0.196|       1.808
RTD|      -0.203|       0.052|       1.685|       0|      -0.203|       1.808
RTD|      -0.200|       0.050|       1.803|       0|      -0.203|       1.808
RTD|      -0.218|       0.060|       1.779|       0|      -0.218|       1.808
RTD|      -0.169|       0.062|       1.847|       0|      -0.218|       1.847
RTD|      -0.195|       0.052|       1.744|       0|      -0.218|       1.847
RTD|      -0.247|       0.057|       1.734|       0|      -0.247|       1.847
RTD|      -0.214|       0.047|       1.628|       0|      -0.247|       1.847
RTD|      -0.179|       0.060|       1.836|       0|      -0.247|       1.847
RTD|      -0.273|       0.056|       1.700|       0|      -0.273|       1.847
RTD|      -0.189|       0.051|       1.853|       0|      -0.273|       1.853
RTD|      -0.193|       0.055|       1.836|       0|      -0.273|       1.853
RTD|      -0.185|       0.053|       1.880|       0|      -0.273|       1.880
RTD|      -0.176|       0.061|       2.127|       0|      -0.273|       2.127
RTD|      -0.209|       0.060|       1.827|       0|      -0.273|       2.127
RTD|      -0.227|       0.062|       1.810|       0|      -0.273|       2.127
RTD|      -0.200|       0.055|       1.795|       0|      -0.273|       2.127
RTD|      -0.178|       0.053|       1.834|       0|      -0.273|       2.127
RTD|      -0.199|       0.051|       1.703|       0|      -0.273|       2.127
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -0.220|       0.058|       1.765|       0|      -0.273|       2.127
RTD|      -0.182|       0.056|       1.798|       0|      -0.273|       2.127
RTD|      -0.217|       0.057|       1.770|       0|      -0.273|       2.127
RTD|      -0.197|       0.045|       1.830|       0|      -0.273|       2.127
RTD|      -0.206|       0.056|       1.791|       0|      -0.273|       2.127
RTD|      -0.240|       0.054|       1.742|       0|      -0.273|       2.127
RTD|      -0.207|       0.059|       1.774|       0|      -0.273|       2.127
RTD|      -0.221|       0.049|       1.782|       0|      -0.273|       2.127
RTD|      -0.251|       0.054|       1.792|       0|      -0.273|       2.127
RTD|      -0.190|       0.060|       1.843|       0|      -0.273|       2.127
RTD|      -0.169|       0.056|       1.824|       0|      -0.273|       2.127
RTD|      -0.262|       0.058|       2.055|       0|      -0.273|       2.127
RTD|      -0.205|       0.057|       1.832|       0|      -0.273|       2.127
RTD|      -0.194|       0.057|       1.855|       0|      -0.273|       2.127
RTD|      -0.257|       0.060|       1.756|       0|      -0.273|       2.127
RTD|      -0.198|       0.058|       1.841|       0|      -0.273|       2.127
RTD|      -0.165|       0.058|       1.788|       0|      -0.273|       2.127
RTD|      -0.223|       0.062|       1.823|       0|      -0.273|       2.127
RTD|      -0.211|       0.057|       1.830|       0|      -0.273|       2.127
RTD|      -0.154|       0.069|       1.804|       0|      -0.273|       2.127
RTD|      -0.284|       0.060|       1.822|       0|      -0.284|       2.127
RTT|  00:00:43  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -0.192|       0.056|       1.750|       0|      -0.284|       2.127
RTD|      -0.185|       0.053|       1.756|       0|      -0.284|       2.127
RTD|      -0.280|       0.049|       1.830|       0|      -0.284|       2.127
RTD|      -0.166|       0.052|       1.632|       0|      -0.284|       2.127
RTD|      -0.205|       0.058|       1.817|       0|      -0.284|       2.127
RTD|      -0.221|       0.056|       1.836|       0|      -0.284|       2.127
RTD|      -0.219|       0.053|       1.776|       0|      -0.284|       2.127
RTD|      -0.186|       0.059|       1.750|       0|      -0.284|       2.127
RTD|      -0.237|       0.052|       1.837|       0|      -0.284|       2.127
RTD|      -0.198|       0.054|       1.523|       0|      -0.284|       2.127
RTD|      -0.197|       0.061|       1.757|       0|      -0.284|       2.127
RTD|      -0.206|       0.060|       1.824|       0|      -0.284|       2.127
RTD|      -0.217|       0.057|       1.634|       0|      -0.284|       2.127
RTD|      -0.203|       0.054|       1.808|       0|      -0.284|       2.127
RTD|      -0.237|       0.054|       1.837|       0|      -0.284|       2.127
RTD|      -0.202|       0.050|       1.834|       0|      -0.284|       2.127
RTD|      -0.202|       0.061|       1.802|       0|      -0.284|       2.127
RTD|      -0.284|       0.049|       1.655|       0|      -0.284|       2.127
RTD|      -0.190|       0.061|       1.647|       0|      -0.284|       2.127
RTD|      -0.193|       0.061|       1.821|       0|      -0.284|       2.127
RTD|      -0.262|       0.054|       1.631|       0|      -0.284|       2.127
RTT|  00:01:04  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -0.186|       0.054|       1.799|       0|      -0.284|       2.127
RTD|      -0.199|       0.052|       1.853|       0|      -0.284|       2.127
RTD|      -0.221|       0.054|       1.815|       0|      -0.284|       2.127
RTD|      -0.210|       0.050|       1.846|       0|      -0.284|       2.127
RTD|      -0.206|       0.062|       1.854|       0|      -0.284|       2.127
RTD|      -0.216|       0.054|       1.841|       0|      -0.284|       2.127
RTD|      -0.184|       0.053|       1.819|       0|      -0.284|       2.127
RTD|      -0.204|       0.053|       1.683|       0|      -0.284|       2.127
RTD|      -0.279|       0.057|       1.721|       0|      -0.284|       2.127
RTD|      -0.201|       0.053|       1.821|       0|      -0.284|       2.127
RTD|      -0.189|       0.048|       1.618|       0|      -0.284|       2.127
RTD|      -0.246|       0.053|       1.791|       0|      -0.284|       2.127
RTD|      -0.198|       0.053|       1.791|       0|      -0.284|       2.127
RTD|      -0.186|       0.048|       1.761|       0|      -0.284|       2.127
RTD|      -0.222|       0.059|       1.773|       0|      -0.284|       2.127
RTD|      -0.185|       0.050|       1.822|       0|      -0.284|       2.127
RTD|      -0.416|       0.057|       1.859|       0|      -0.416|       2.127
RTD|      -0.188|       0.052|       1.780|       0|      -0.416|       2.127
RTD|      -0.209|       0.050|       1.777|       0|      -0.416|       2.127
RTD|      -0.195|       0.056|       1.742|       0|      -0.416|       2.127
RTD|      -0.247|       0.055|       1.771|       0|      -0.416|       2.127
RTT|  00:01:25  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -0.171|       0.059|       1.843|       0|      -0.416|       2.127
RTD|      -0.201|       0.054|       1.774|       0|      -0.416|       2.127
RTD|      -0.195|       0.055|       1.818|       0|      -0.416|       2.127
RTD|      -0.181|       0.055|       1.621|       0|      -0.416|       2.127
RTD|      -0.209|       0.055|       1.613|       0|      -0.416|       2.127
RTD|      -0.228|       0.060|       1.787|       0|      -0.416|       2.127
RTD|      -0.206|       0.045|       1.642|       0|      -0.416|       2.127
RTD|      -0.182|       0.053|       1.846|       0|      -0.416|       2.127
RTD|      -0.255|       0.052|       1.800|       0|      -0.416|       2.127
RTD|      -0.196|       0.056|       1.789|       0|      -0.416|       2.127
RTD|      -0.182|       0.050|       1.730|       0|      -0.416|       2.127
RTD|      -0.269|       0.052|       1.673|       0|      -0.416|       2.127
RTD|      -0.218|       0.049|       1.857|       0|      -0.416|       2.127
RTD|      -0.208|       0.051|       1.816|       0|      -0.416|       2.127
RTD|      -0.269|       0.053|       1.690|       0|      -0.416|       2.127
RTD|      -0.190|       0.051|       1.762|       0|      -0.416|       2.127
RTD|      -0.206|       0.047|       1.844|       0|      -0.416|       2.127
RTD|      -0.246|       0.048|       1.856|       0|      -0.416|       2.127
RTD|      -0.208|       0.054|       1.817|       0|      -0.416|       2.127
RTD|      -0.185|       0.057|       1.770|       0|      -0.416|       2.127
RTD|      -0.266|       0.050|       1.850|       0|      -0.416|       2.127
RTT|  00:01:46  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -0.205|       0.051|       1.833|       0|      -0.416|       2.127
RTD|      -0.205|       0.059|       1.857|       0|      -0.416|       2.127
RTD|      -0.269|       0.057|       1.668|       0|      -0.416|       2.127
RTD|      -0.204|       0.055|       1.767|       0|      -0.416|       2.127
RTD|      -0.190|       0.053|       1.740|       0|      -0.416|       2.127
RTD|      -0.213|       0.047|       1.836|       0|      -0.416|       2.127
RTD|      -0.218|       0.059|       1.843|       0|      -0.416|       2.127
RTD|      -0.193|       0.042|       1.588|       0|      -0.416|       2.127
RTD|      -0.262|       0.049|       1.823|       0|      -0.416|       2.127
RTD|      -0.188|       0.049|       1.773|       0|      -0.416|       2.127
RTD|      -0.193|       0.052|       1.751|       0|      -0.416|       2.127
RTD|      -0.280|       0.054|       1.855|       0|      -0.416|       2.127
RTD|      -0.205|       0.057|       1.758|       0|      -0.416|       2.127
RTD|      -0.187|       0.049|       1.711|       0|      -0.416|       2.127
RTD|      -0.239|       0.053|       1.793|       0|      -0.416|       2.127
---|--param|----range-|--samples
HSD|    min|   0 -  1 |      120
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |  1199413
HSD|    avg|   1 -  2 |     1158
HSD|    avg|   2 -  3 |        2
---|--param|----range-|--samples
HSD|    max|   1 -  2 |      118
HSD|    max|   2 -  3 |        2
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       120|      0.000|      0.000
HSS|    avg|   1200573|      0.001|      0.031
HSS|    max|       120|      1.017|      0.129
---|------------|------------|------------|--------|-------------------------
RTS|      -0.416|       0.054|       2.127|       0|    00:02:00/00:02:00

Mi 9. Mai 21:57:23 CEST 2007
running: ./run -- -sh -T 120 -t1 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
latency: failed to start in-kernel timer benchmark, code -25
---|--param|----range-|--samples
---|--param|----range-|--samples
---|--param|----range-|--samples
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|         0|        nan|     -0.000
HSS|    avg|         0|        nan|     -0.000
HSS|    max|         0|        nan|     -0.000
---|------------|------------|------------|--------|-------------------------
RTS|  134529.672|       0.036|-1208793.560|-1080489212|    00:02:00/00:02:00

Mi 9. Mai 21:59:25 CEST 2007
running: ./run -- -sh -T 120 -t2 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel timer handler
== All results in microseconds
latency: failed to start in-kernel timer benchmark, code -25
---|--param|----range-|--samples
---|--param|----range-|--samples
---|--param|----range-|--samples
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|         0|        nan|     -0.000
HSS|    avg|         0|        nan|     -0.000
HSS|    max|         0|        nan|     -0.000
---|------------|------------|------------|--------|-------------------------
RTS|  134529.672|       0.036|-1209092.568|-1075261452|    00:02:00/00:02:00

Mi 9. Mai 22:01:26 CEST 2007
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
== Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-5 rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12 rtus_ufps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18 rtuo_ufps-19 rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|       11477|       11477
RTD|       11523|       23000
RTD|       11523|       34523
RTD|       11523|       46046
RTD|       11523|       57569
RTD|       11523|       69092
RTD|       11523|       80615
RTD|       11523|       92138
RTD|       11523|      103661
RTD|       11523|      115184
RTD|       11523|      126707
RTD|       11523|      138230
RTD|       10833|      149063
RTD|        7682|      156745
RTD|        7682|      164427
RTD|        7682|      172109
RTD|        7682|      179791
RTD|        7682|      187473
RTD|        8487|      195960
RTD|       11086|      207046
RTD|       11523|      218569
RTT|  00:00:22
RTH|ctx switches|-------total
RTD|       11523|      230092
RTD|       11523|      241615
RTD|       11523|      253138
RTD|       11523|      264661
RTD|       11523|      276184
RTD|       11523|      287707
RTD|       11523|      299230
RTD|       11523|      310753
RTD|       11523|      322276
RTD|       11523|      333799
RTD|       11523|      345322
RTD|       11523|      356845
RTD|       11523|      368368
RTD|       11523|      379891
RTD|       11523|      391414
RTD|       11523|      402937
RTD|       11523|      414460
RTD|       11523|      425983
RTD|       11523|      437506
RTD|       11523|      449029
RTD|       11523|      460552
RTT|  00:00:43
RTH|ctx switches|-------total
RTD|       11523|      472075
RTD|       11523|      483598
RTD|       11523|      495121
RTD|       11523|      506644
RTD|       11523|      518167
RTD|       11523|      529690
RTD|       11523|      541213
RTD|       11523|      552736
RTD|       11523|      564259
RTD|       10925|      575184
RTD|        7682|      582866
RTD|        7682|      590548
RTD|        7682|      598230
RTD|        7682|      605912
RTD|        7682|      613594
RTD|        8487|      622081
RTD|       11109|      633190
RTD|       11523|      644713
RTD|       11523|      656236
RTD|       11523|      667759
RTD|       11500|      679259
RTT|  00:01:04
RTH|ctx switches|-------total
RTD|       11523|      690782
RTD|       11523|      702305
RTD|       11523|      713828
RTD|       11523|      725351
RTD|       11523|      736874
RTD|       11523|      748397
RTD|       11523|      759920
RTD|       11523|      771443
RTD|       11523|      782966
RTD|       11523|      794489
RTD|       11523|      806012
RTD|       11523|      817535
RTD|       11523|      829058
RTD|       11523|      840581
RTD|       11523|      852104
RTD|       11523|      863627
RTD|       11523|      875150
RTD|       11523|      886673
RTD|       11523|      898196
RTD|       11523|      909719
RTD|       11523|      921242
RTT|  00:01:25
RTH|ctx switches|-------total
RTD|       11523|      932765
RTD|       11523|      944288
RTD|       11523|      955811
RTD|       11523|      967334
RTD|       11523|      978857
RTD|       11523|      990380
RTD|       10948|     1001328
RTD|        7682|     1009010
RTD|        7682|     1016692
RTD|        7682|     1024374
RTD|        7682|     1032056
RTD|        7751|     1039807
RTD|        8786|     1048593
RTD|       11109|     1059702
RTD|       11523|     1071225
RTD|       11523|     1082748
RTD|       11523|     1094271
RTD|       11500|     1105771
RTD|       11523|     1117294
RTD|       11523|     1128817
RTD|       11523|     1140340
RTT|  00:01:46
RTH|ctx switches|-------total
RTD|       11523|     1151863
RTD|       11523|     1163386
RTD|       11523|     1174909
RTD|       11523|     1186432
RTD|       11523|     1197955
RTD|       11523|     1209478
RTD|       11523|     1221001
RTD|       11523|     1232524
RTD|       11523|     1244047
RTD|       11523|     1255570
RTD|       11523|     1267093
RTD|       11523|     1278616
RTD|       11523|     1290139
RTD|       11523|     1301662
RTD|        9798|     1311460

Mi 9. Mai 22:03:26 CEST 2007
running: ./run -- -h # switchbench
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|       3.502|       3.608|       4.590|           0
---|---range-|---samples
HSD| 3 - 4 |      99939
HSD| 4 - 5 |         57
HSS|     99996|      3.001|      0.024

Mi 9. Mai 22:03:36 CEST 2007
running: ./run -- -p 10 -n -l 1000 # cyclictest
*
*
* Type ^C to stop this application.
*
*
0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.07 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:       2 Min:       2 Act:       2 Avg:       2 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:      13 Min:       1 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:      24 Min:       1 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:      35 Min:       1 Act:       2 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:      46 Min:       1 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:      57 Min:       1 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:      68 Min:       1 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:      79 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:      90 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     101 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     112 Min:       0 Act:       2 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     123 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     134 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     145 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     156 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     167 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     178 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     189 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     200 Min:       0 Act:       2 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     211 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     222 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     233 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     244 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     255 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     266 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     277 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     288 Min:       0 Act:       2 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     299 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     310 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     321 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     332 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     343 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     354 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     365 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     376 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     387 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     398 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     409 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     420 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     431 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     442 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     453 Min:       0 Act:       2 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     464 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     475 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     486 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     497 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     508 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     519 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     530 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     541 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     552 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     563 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     574 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     585 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     596 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     607 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     618 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     629 Min:       0 Act:       2 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     640 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     651 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     662 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     673 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     684 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     695 Min:       0 Act:       2 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     706 Min:       0 Act:       1 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     717 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     729 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     740 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     751 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     762 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     773 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     784 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     795 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     806 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     817 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     828 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     839 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     849 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     860 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     871 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     882 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     893 Min:       0 Act:       0 Avg:       1 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     904 Min:       0 Act:       0 Avg:       0 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     915 Min:       0 Act:       0 Avg:       0 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     926 Min:       0 Act:       0 Avg:       0 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     937 Min:       0 Act:       0 Avg:       0 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     948 Min:       0 Act:       0 Avg:       0 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     959 Min:       0 Act:       0 Avg:       0 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     970 Min:       0 Act:       0 Avg:       0 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     981 Min:       0 Act:       0 Avg:       0 Max:       3
[3A0.00 0.05 0.06 1/64 5012          

T: 0 ( 5012) P:10 I:    1000 C:     992 Min:       0 Act:       0 Avg:       0 Max:       3
[3A0.00 0.05 0.06 1/63 5012          

T: 0 ( 5012) P:10 I:    1000 C:    1000 Min:       0 Act:       0 Avg:       0 Max:       3

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/interrupts
           CPU0       
  0:     951354   IO-APIC-edge      timer, rthal_broadcast_timer
  1:        742   IO-APIC-edge      i8042
  8:          3   IO-APIC-edge      rtc
  9:          0   IO-APIC-fasteoi   acpi
 14:      22465   IO-APIC-edge      ide0
 15:       8390   IO-APIC-edge      ide1
 16:     107098   IO-APIC-fasteoi   ohci_hcd:usb1, eth0
 17:          0   IO-APIC-fasteoi   ohci_hcd:usb2, NVidia nForce2
 18:          2   IO-APIC-fasteoi   ehci_hcd:usb3
 19:          0   IO-APIC-fasteoi   Technisat/B2C2 FlexCop II/IIb/III Digital TV PCI Driver
 20:      18188   IO-APIC-fasteoi   radeon@domain.hid
NMI:          0 
LOC:     951233 
ERR:          0
MIS:          0

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/loadavg
0.00 0.05 0.06 4/59 5024

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/meminfo
MemTotal:      1035240 kB
MemFree:        706452 kB
Buffers:         71688 kB
Cached:         182836 kB
SwapCached:          0 kB
Active:         141764 kB
Inactive:       148904 kB
HighTotal:      131008 kB
HighFree:         2500 kB
LowTotal:       904232 kB
LowFree:        703952 kB
SwapTotal:      481908 kB
SwapFree:       481908 kB
Dirty:              88 kB
Writeback:           0 kB
AnonPages:       36168 kB
Mapped:          14780 kB
Slab:            21984 kB
SReclaimable:    14236 kB
SUnreclaim:       7748 kB
PageTables:        820 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:    999528 kB
Committed_AS:    46380 kB
VmallocTotal:   114680 kB
VmallocUsed:      8060 kB
VmallocChunk:   105460 kB

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:       228289    (lostage_handler)
  2:            6    (registry_export)
  3:            0    (posix_signals_handler)

Mi 9. Mai 22:03:38 CEST 2007
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

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/hal
1.7-03

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/heap
size=130560:used=64:pagesz=512

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/irq
IRQ         CPU0
213:           0
216:     1677361         [timer]
217:           0
226:     1156399         [virtual]

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/latency
2699

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT/0

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          2261599    0     00500080   98.4  ROOT/0
  0  0      0          1677361    0     00000000    0.2  IRQ216: [timer]

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/timer
status=oneshot+watchdog:setup=33:tickval=1:jiffies=968733138388

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/version
2.3.1

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/interfaces/native
0

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/interfaces/posix
0

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/interfaces/rtdm
0

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/interfaces/sys
0

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				Driver		/proc
D6	rttest0                        	xeno_irqbench  	rttest0

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device

Mi 9. Mai 22:03:38 CEST 2007
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Mi 9. Mai 22:03:38 CEST 2007
running: top -bn1c
top - 22:03:39 up 15 min,  1 user,  load average: 0.00, 0.05, 0.06
Tasks:  61 total,   1 running,  60 sleeping,   0 stopped,   0 zombie
Cpu(s):  3.6%us,  1.0%sy,  0.2%ni, 86.3%id,  9.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   1035240k total,   329124k used,   706116k free,    71688k buffers
Swap:   481908k total,        0k used,   481908k free,   182836k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
    1 root      18   0  2912 1844  524 S  0.0  0.2   0:00.70 /sbin/init         
    2 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 [migration/0]      
    3 root      34  19     0    0    0 S  0.0  0.0   0:00.00 [ksoftirqd/0]      
cleanup_load: no dd_jobs found
xeno-test: finished

--========GMX307801178798978763319
Content-Type: text/plain; charset="iso-8859-15"; name="[work]xeno-test.txt"
Content-Transfer-Encoding: 8bit
Content-Description: attachment

xeno-test: started 
withBusybox is 0
xeno-test: running tests

Mi 9. Mai 20:13:29 CEST 2007
running: bin/xeno-config --verbose
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

Mi 9. Mai 20:13:29 CEST 2007
running: bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux rtlinux 2.6.20.11-adeos-xenomai2.3.1 #1 SMP Wed May 9 18:51:33 CEST 2007 i686 GNU/Linux
 
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
Modules Loaded         parport_pc lp parport usb_storage libusual snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device sg psmouse sr_mod cdrom snd ehci_hcd serio_raw tg3 uhci_hcd intel_agp agpgart soundcore snd_page_alloc shpchp pci_hotplug usbcore sd_mod ata_piix ata_generic libata scsi_mod generic evdev fbcon tileblit font bitblit softcursor

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz
stepping	: 2
cpu MHz		: 1860.676
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
cpu MHz		: 1860.676
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


Mi 9. Mai 20:13:29 CEST 2007
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
e2d5f249f0d53136f16dd7de92b0851e  /proc/cpuinfo
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

Mi 9. Mai 20:13:29 CEST 2007
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

Mi 9. Mai 20:13:29 CEST 2007
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

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/ipipe/version
1.7-03

Mi 9. Mai 20:13:29 CEST 2007
running: generate_loads 1
eval: 1: arith: syntax error: "jobsct-1"
cleanup_load: no dd_jobs found

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/interrupts
           CPU0       CPU1       
  0:    2850717          0  local-APIC-edge-fasteio   timer, rthal_broadcast_timer
  1:        490          0   IO-APIC-edge      i8042
  2:          0          0    XT-PIC-XT        cascade
  8:          3          0   IO-APIC-edge      rtc
 12:        132          0   IO-APIC-edge      i8042
 14:       3524          0   IO-APIC-edge      libata
 15:         21          0   IO-APIC-edge      libata
 18:          0          0   IO-APIC-fasteoi   libata
 20:         67          0   IO-APIC-fasteoi   uhci_hcd:usb1, uhci_hcd:usb3, ehci_hcd:usb7
 21:        104          0   IO-APIC-fasteoi   uhci_hcd:usb2, uhci_hcd:usb4, HDA Intel
 22:         30          0   IO-APIC-fasteoi   uhci_hcd:usb5, ehci_hcd:usb6
NMI:          0          0 
LOC:    2850554    2850552 
ERR:          0
MIS:          0

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/loadavg
0.08 0.03 0.01 1/53 4203

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/meminfo
MemTotal:       905564 kB
MemFree:        859312 kB
Buffers:          7804 kB
Cached:          19272 kB
SwapCached:          0 kB
Active:          19696 kB
Inactive:        11880 kB
SwapTotal:     3004112 kB
SwapFree:      3004112 kB
Dirty:               0 kB
Writeback:           0 kB
AnonPages:        4484 kB
Mapped:           2412 kB
Slab:             8004 kB
SReclaimable:     2792 kB
SUnreclaim:       5212 kB
PageTables:        168 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   3456892 kB
Committed_AS:     8292 kB
VmallocTotal:   122600 kB
VmallocUsed:      4580 kB
VmallocChunk:   117812 kB

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/apc
APC          CPU0         CPU1
  0:            0           0    (pipe_wakeup)
  1:       220204        2248    (lostage_handler)
  2:            4           2    (registry_export)
  3:            0           0    (posix_signals_handler)

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/faults
TRAP         CPU0        CPU1
  0:            0           0    (Divide error)
  1:            0           0    (Debug)
  3:            0           0    (Int3)
  4:            0           0    (Overflow)
  5:            0           0    (Bounds)
  6:            0           0    (Invalid opcode)
  7:            1           0    (FPU not available)
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

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/hal
1.7-03

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/heap
size=130560:used=64:pagesz=512

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/irq
IRQ         CPU0        CPU1
213:           0          21
216:     3733794    22248954         [timer]
217:           0           0
226:     1114904        4495         [virtual]

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/latency
2699

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT/0
  1  0       -1      0        0          R          ROOT/1

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          3086072    0     00500080  100.0  ROOT/0
  1  0      0          22248581   0     00500080   95.0  ROOT/1
  0  0      0          3733794    0     00000000    0.0  IRQ216: [timer]
  1  0      0          22248954   0     00000000    1.5  IRQ216: [timer]

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/timer
status=oneshot+watchdog:setup=55:tickval=1:jiffies=2850536315033

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/version
2.3.1

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/interfaces/native
0

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/interfaces/posix
0

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/interfaces/rtdm
0

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/interfaces/sys
0

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				Driver		/proc

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device

Mi 9. Mai 20:13:29 CEST 2007
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Mi 9. Mai 20:13:29 CEST 2007
running: top -bn1c
top - 20:13:30 up 47 min,  1 user,  load average: 0.08, 0.03, 0.01
Tasks:  55 total,   1 running,  54 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0%us,  0.1%sy,  0.0%ni, 99.7%id,  0.1%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:    905564k total,    46128k used,   859436k free,     7804k buffers
Swap:  3004112k total,        0k used,  3004112k free,    19272k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
    1 root      18   0  2908 1848  524 S    0  0.2   0:00.72 /sbin/init         
    2 root      RT   0     0    0    0 S    0  0.0   0:00.00 [migration/0]      
    3 root      34  19     0    0    0 S    0  0.0   0:00.00 [ksoftirqd/0]      

Mi 9. Mai 20:13:30 CEST 2007
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
RTD|       1.016|       4.570|      21.576|       0|       1.016|      21.576
RTD|       1.245|       4.766|      21.734|       0|       1.016|      21.734
RTD|       1.215|       4.746|      21.955|       0|       1.016|      21.955
RTD|       1.219|       4.756|      21.944|       0|       1.016|      21.955
RTD|       1.170|       4.724|      21.696|       0|       1.016|      21.955
RTD|       1.193|       4.734|      21.718|       0|       1.016|      21.955
RTD|       1.200|       4.756|      21.726|       0|       1.016|      21.955
RTD|       1.204|       4.741|      22.012|       0|       1.016|      22.012
RTD|       1.193|       4.733|      21.884|       0|       1.016|      22.012
RTD|       1.204|       4.745|      21.895|       0|       1.016|      22.012
RTD|       1.178|       4.730|      21.715|       0|       1.016|      22.012
RTD|       1.185|       4.750|      21.955|       0|       1.016|      22.012
RTD|       1.193|       4.742|      21.722|       0|       1.016|      22.012
RTD|       1.230|       4.741|      21.726|       0|       1.016|      22.012
RTD|       1.163|       4.727|      21.861|       0|       1.016|      22.012
RTD|       1.196|       4.743|      21.933|       0|       1.016|      22.012
RTD|       1.234|       4.767|      21.737|       0|       1.016|      22.012
RTD|       1.211|       4.749|      21.764|       0|       1.016|      22.012
RTD|       1.185|       4.745|      21.741|       0|       1.016|      22.012
RTD|       1.200|       4.745|      21.963|       0|       1.016|      22.012
RTD|       1.178|       4.738|      21.910|       0|       1.016|      22.012
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.234|       4.762|      21.737|       0|       1.016|      22.012
RTD|       1.219|       4.747|      21.937|       0|       1.016|      22.012
RTD|       1.189|       4.735|      21.925|       0|       1.016|      22.012
RTD|       1.200|       4.733|      21.726|       0|       1.016|      22.012
RTD|       1.200|       4.739|      22.362|       0|       1.016|      22.362
RTD|       1.230|       4.769|      21.749|       0|       1.016|      22.362
RTD|       1.242|       4.754|      21.922|       0|       1.016|      22.362
RTD|       1.185|       4.752|      21.963|       0|       1.016|      22.362
RTD|       1.189|       4.738|      21.711|       0|       1.016|      22.362
RTD|       1.208|       4.755|      22.166|       0|       1.016|      22.362
RTD|       1.204|       4.746|      21.718|       0|       1.016|      22.362
RTD|       1.208|       4.760|      21.734|       0|       1.016|      22.362
RTD|       1.215|       4.754|      21.734|       0|       1.016|      22.362
RTD|       1.189|       4.736|      21.726|       0|       1.016|      22.362
RTD|       1.185|       4.742|      22.196|       0|       1.016|      22.362
RTD|       1.219|       4.755|      22.166|       0|       1.016|      22.362
RTD|       1.193|       4.744|      21.944|       0|       1.016|      22.362
RTD|       1.181|       4.732|      21.692|       0|       1.016|      22.362
RTD|       1.200|       4.730|      21.884|       0|       1.016|      22.362
RTD|       1.178|       4.740|      21.933|       0|       1.016|      22.362
RTD|       1.211|       4.748|      21.914|       0|       1.016|      22.362
RTT|  00:00:43  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.215|       4.744|      21.711|       0|       1.016|      22.362
RTD|       1.189|       4.734|      21.722|       0|       1.016|      22.362
RTD|       1.189|       4.732|      21.707|       0|       1.016|      22.362
RTD|       1.215|       4.737|      21.940|       0|       1.016|      22.362
RTD|       1.204|       4.754|      21.940|       0|       1.016|      22.362
RTD|       1.178|       4.743|      21.895|       0|       1.016|      22.362
RTD|       1.208|       4.756|      21.734|       0|       1.016|      22.362
RTD|       1.193|       4.737|      21.718|       0|       1.016|      22.362
RTD|       1.215|       4.757|      21.726|       0|       1.016|      22.362
RTD|       1.208|       4.762|      21.940|       0|       1.016|      22.362
RTD|       1.219|       4.743|      21.937|       0|       1.016|      22.362
RTD|       1.226|       4.756|      21.929|       0|       1.016|      22.362
RTD|       1.200|       4.732|      21.707|       0|       1.016|      22.362
RTD|       1.204|       4.736|      21.903|       0|       1.016|      22.362
RTD|       1.215|       4.766|      22.975|       0|       1.016|      22.975
RTD|       1.215|       4.752|      21.741|       0|       1.016|      22.975
RTD|       1.185|       4.748|      21.722|       0|       1.016|      22.975
RTD|       1.215|       4.744|      21.895|       0|       1.016|      22.975
RTD|       1.204|       4.747|      21.703|       0|       1.016|      22.975
RTD|       1.234|       4.766|      21.741|       0|       1.016|      22.975
RTD|       1.193|       4.741|      21.715|       0|       1.016|      22.975
RTT|  00:01:04  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.223|       4.747|      21.726|       0|       1.016|      22.975
RTD|       1.189|       4.746|      21.726|       0|       1.016|      22.975
RTD|       1.208|       4.744|      21.726|       0|       1.016|      22.975
RTD|       1.211|       4.764|      21.749|       0|       1.016|      22.975
RTD|       1.204|       4.749|      21.910|       0|       1.016|      22.975
RTD|       1.223|       4.733|      21.730|       0|       1.016|      22.975
RTD|       1.215|       4.739|      21.711|       0|       1.016|      22.975
RTD|       1.211|       4.746|      21.737|       0|       1.016|      22.975
RTD|       1.234|       4.762|      21.865|       0|       1.016|      22.975
RTD|       1.208|       4.736|      21.726|       0|       1.016|      22.975
RTD|       1.193|       4.750|      21.944|       0|       1.016|      22.975
RTD|       1.200|       4.748|      21.722|       0|       1.016|      22.975
RTD|       1.196|       4.736|      22.159|       0|       1.016|      22.975
RTD|       1.200|       4.755|      21.737|       0|       1.016|      22.975
RTD|       1.238|       4.738|      21.700|       0|       1.016|      22.975
RTD|       1.211|       4.748|      21.726|       0|       1.016|      22.975
RTD|       1.189|       4.739|      23.156|       0|       1.016|      23.156
RTD|       1.185|       4.740|      21.715|       0|       1.016|      23.156
RTD|       1.238|       4.769|      21.741|       0|       1.016|      23.156
RTD|       1.193|       4.745|      21.715|       0|       1.016|      23.156
RTD|       1.223|       4.755|      21.910|       0|       1.016|      23.156
RTT|  00:01:25  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.196|       4.739|      21.711|       0|       1.016|      23.156
RTD|       1.204|       4.754|      21.955|       0|       1.016|      23.156
RTD|       1.204|       4.760|      22.456|       0|       1.016|      23.156
RTD|       1.219|       4.749|      22.407|       0|       1.016|      23.156
RTD|       1.204|       4.756|      22.174|       0|       1.016|      23.156
RTD|       1.185|       4.743|      21.929|       0|       1.016|      23.156
RTD|       1.208|       4.755|      21.718|       0|       1.016|      23.156
RTD|       1.211|       4.766|      21.749|       0|       1.016|      23.156
RTD|       1.189|       4.744|      22.132|       0|       1.016|      23.156
RTD|       1.193|       4.737|      22.166|       0|       1.016|      23.156
RTD|       1.211|       4.728|      21.715|       0|       1.016|      23.156
RTD|       1.208|       4.756|      21.741|       0|       1.016|      23.156
RTD|       1.223|       4.749|      21.734|       0|       1.016|      23.156
RTD|       1.215|       4.754|      21.722|       0|       1.016|      23.156
RTD|       1.196|       4.736|      22.177|       0|       1.016|      23.156
RTD|       1.193|       4.746|      21.944|       0|       1.016|      23.156
RTD|       1.189|       4.744|      21.722|       0|       1.016|      23.156
RTD|       1.211|       4.758|      21.741|       0|       1.016|      23.156
RTD|       1.211|       4.756|      21.737|       0|       1.016|      23.156
RTD|       1.234|       4.747|      21.797|       0|       1.016|      23.156
RTD|       1.193|       4.731|      21.711|       0|       1.016|      23.156
RTT|  00:01:46  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       1.193|       4.733|      22.181|       0|       1.016|      23.156
RTD|       1.226|       4.752|      22.260|       0|       1.016|      23.156
RTD|       1.200|       4.735|      21.914|       0|       1.016|      23.156
RTD|       1.189|       4.743|      21.711|       0|       1.016|      23.156
RTD|       1.174|       4.726|      21.907|       0|       1.016|      23.156
RTD|       1.193|       4.736|      23.193|       0|       1.016|      23.193
RTD|       1.223|       4.749|      21.955|       0|       1.016|      23.193
RTD|       1.204|       4.744|      21.715|       0|       1.016|      23.193
RTD|       1.204|       4.734|      21.940|       0|       1.016|      23.193
RTD|       1.181|       4.731|      21.884|       0|       1.016|      23.193
RTD|       1.208|       4.736|      21.718|       0|       1.016|      23.193
RTD|       1.208|       4.760|      22.132|       0|       1.016|      23.193
RTD|       1.181|       4.753|      22.087|       0|       1.016|      23.193
RTD|       1.226|       4.750|      21.722|       0|       1.016|      23.193
---|--param|----range-|--samples
HSD|    min|   1 -  2 |      119
---|--param|----range-|--samples
HSD|    avg|   1 -  2 |   999868
HSD|    avg|   2 -  3 |       49
HSD|    avg|   9 - 10 |        1
HSD|    avg|  10 - 11 |       13
HSD|    avg|  11 - 12 |       28
HSD|    avg|  15 - 16 |        2
HSD|    avg|  18 - 19 |        2
HSD|    avg|  21 - 22 |   199991
HSD|    avg|  22 - 23 |       17
HSD|    avg|  23 - 24 |        2
---|--param|----range-|--samples
HSD|    max|  21 - 22 |      100
HSD|    max|  22 - 23 |       17
HSD|    max|  23 - 24 |        2
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       119|      1.000|      0.000
HSS|    avg|   1199973|      4.334|      7.454
HSS|    max|       119|     21.176|      0.425
---|------------|------------|------------|--------|-------------------------
RTS|       1.016|       4.744|      23.193|       0|    00:02:00/00:02:00

Mi 9. Mai 20:15:31 CEST 2007
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
RTD|       0.341|       3.925|      20.917|       0|       0.341|      20.917
RTD|       0.336|       3.921|      20.917|       0|       0.336|      20.917
RTD|       0.336|       3.923|      20.918|       0|       0.336|      20.918
RTD|       0.332|       3.923|      21.021|       0|       0.332|      21.021
RTD|       0.345|       3.927|      21.185|       0|       0.332|      21.185
RTD|       0.329|       3.926|      20.908|       0|       0.329|      21.185
RTD|       0.338|       3.923|      20.920|       0|       0.329|      21.185
RTD|       0.335|       3.926|      20.919|       0|       0.329|      21.185
RTD|       0.360|       3.920|      20.916|       0|       0.329|      21.185
RTD|       0.372|       3.925|      21.009|       0|       0.329|      21.185
RTD|       0.336|       3.917|      21.065|       0|       0.329|      21.185
RTD|       0.345|       3.923|      20.922|       0|       0.329|      21.185
RTD|       0.324|       3.922|      20.921|       0|       0.324|      21.185
RTD|       0.345|       3.923|      20.937|       0|       0.324|      21.185
RTD|       0.345|       3.924|      20.974|       0|       0.324|      21.185
RTD|       0.335|       3.916|      20.912|       0|       0.324|      21.185
RTD|       0.356|       3.925|      21.021|       0|       0.324|      21.185
RTD|       0.332|       3.917|      21.002|       0|       0.324|      21.185
RTD|       0.354|       3.924|      21.047|       0|       0.324|      21.185
RTD|       0.364|       3.928|      20.959|       0|       0.324|      21.185
RTD|       0.346|       3.923|      20.954|       0|       0.324|      21.185
RTT|  00:00:22  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.367|       3.923|      20.914|       0|       0.324|      21.185
RTD|       0.361|       3.919|      21.108|       0|       0.324|      21.185
RTD|       0.347|       3.925|      21.018|       0|       0.324|      21.185
RTD|       0.328|       3.922|      21.292|       0|       0.324|      21.292
RTD|       0.336|       3.923|      20.944|       0|       0.324|      21.292
RTD|       0.338|       3.927|      20.926|       0|       0.324|      21.292
RTD|       0.329|       3.927|      20.933|       0|       0.324|      21.292
RTD|       0.336|       3.921|      21.271|       0|       0.324|      21.292
RTD|       0.352|       3.923|      21.300|       0|       0.324|      21.300
RTD|       0.354|       3.926|      21.085|       0|       0.324|      21.300
RTD|       0.355|       3.921|      21.139|       0|       0.324|      21.300
RTD|       0.365|       3.926|      20.912|       0|       0.324|      21.300
RTD|       0.363|       3.927|      20.934|       0|       0.324|      21.300
RTD|       0.355|       3.925|      21.022|       0|       0.324|      21.300
RTD|       0.349|       3.924|      21.169|       0|       0.324|      21.300
RTD|       0.344|       3.924|      21.027|       0|       0.324|      21.300
RTD|       0.330|       3.925|      20.934|       0|       0.324|      21.300
RTD|       0.332|       3.917|      20.917|       0|       0.324|      21.300
RTD|       0.345|       3.928|      20.916|       0|       0.324|      21.300
RTD|       0.345|       3.920|      20.936|       0|       0.324|      21.300
RTD|       0.365|       3.922|      20.919|       0|       0.324|      21.300
RTT|  00:00:43  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.327|       3.926|      20.946|       0|       0.324|      21.300
RTD|       0.351|       3.922|      20.941|       0|       0.324|      21.300
RTD|       0.351|       3.928|      21.184|       0|       0.324|      21.300
RTD|       0.346|       3.920|      20.912|       0|       0.324|      21.300
RTD|       0.321|       3.925|      21.023|       0|       0.321|      21.300
RTD|       0.336|       3.916|      21.011|       0|       0.321|      21.300
RTD|       0.347|       3.922|      20.978|       0|       0.321|      21.300
RTD|       0.358|       3.933|      21.196|       0|       0.321|      21.300
RTD|       0.352|       3.924|      20.939|       0|       0.321|      21.300
RTD|       0.340|       3.923|      20.931|       0|       0.321|      21.300
RTD|       0.330|       3.923|      20.917|       0|       0.321|      21.300
RTD|       0.330|       3.925|      20.912|       0|       0.321|      21.300
RTD|       0.366|       3.917|      21.032|       0|       0.321|      21.300
RTD|       0.358|       3.924|      21.037|       0|       0.321|      21.300
RTD|       0.344|       3.926|      20.943|       0|       0.321|      21.300
RTD|       0.346|       3.924|      20.923|       0|       0.321|      21.300
RTD|       0.346|       3.927|      20.915|       0|       0.321|      21.300
RTD|       0.339|       3.920|      20.917|       0|       0.321|      21.300
RTD|       0.349|       3.925|      20.921|       0|       0.321|      21.300
RTD|       0.331|       3.916|      20.914|       0|       0.321|      21.300
RTD|       0.344|       3.926|      20.986|       0|       0.321|      21.300
RTT|  00:01:04  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.371|       3.925|      20.944|       0|       0.321|      21.300
RTD|       0.356|       3.925|      21.102|       0|       0.321|      21.300
RTD|       0.348|       3.927|      20.923|       0|       0.321|      21.300
RTD|       0.340|       3.924|      21.367|       0|       0.321|      21.367
RTD|       0.359|       3.927|      20.918|       0|       0.321|      21.367
RTD|       0.350|       3.923|      20.940|       0|       0.321|      21.367
RTD|       0.333|       3.927|      20.908|       0|       0.321|      21.367
RTD|       0.334|       3.917|      20.949|       0|       0.321|      21.367
RTD|       0.347|       3.922|      21.188|       0|       0.321|      21.367
RTD|       0.326|       3.925|      20.949|       0|       0.321|      21.367
RTD|       0.324|       3.921|      20.929|       0|       0.321|      21.367
RTD|       0.337|       3.925|      20.913|       0|       0.321|      21.367
RTD|       0.329|       3.920|      20.933|       0|       0.321|      21.367
RTD|       0.335|       3.927|      21.001|       0|       0.321|      21.367
RTD|       0.352|       3.916|      21.048|       0|       0.321|      21.367
RTD|       0.346|       3.925|      20.937|       0|       0.321|      21.367
RTD|       0.330|       3.925|      21.017|       0|       0.321|      21.367
RTD|       0.351|       3.921|      21.046|       0|       0.321|      21.367
RTD|       0.335|       3.925|      21.087|       0|       0.321|      21.367
RTD|       0.332|       3.921|      21.026|       0|       0.321|      21.367
RTD|       0.339|       3.921|      20.919|       0|       0.321|      21.367
RTT|  00:01:25  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.343|       3.921|      20.911|       0|       0.321|      21.367
RTD|       0.341|       3.924|      20.945|       0|       0.321|      21.367
RTD|       0.353|       3.922|      20.942|       0|       0.321|      21.367
RTD|       0.338|       3.926|      20.983|       0|       0.321|      21.367
RTD|       0.072|       3.918|      21.312|       0|       0.072|      21.367
RTD|       0.324|       3.924|      21.019|       0|       0.072|      21.367
RTD|       0.375|       3.926|      21.054|       0|       0.072|      21.367
RTD|       0.351|       3.920|      20.921|       0|       0.072|      21.367
RTD|       0.340|       3.923|      21.084|       0|       0.072|      21.367
RTD|       0.355|       3.926|      20.961|       0|       0.072|      21.367
RTD|       0.351|       3.929|      21.898|       0|       0.072|      21.898
RTD|       0.359|       3.926|      21.033|       0|       0.072|      21.898
RTD|       0.334|       3.923|      21.061|       0|       0.072|      21.898
RTD|       0.340|       3.927|      20.937|       0|       0.072|      21.898
RTD|       0.339|       3.918|      20.951|       0|       0.072|      21.898
RTD|       0.342|       3.925|      21.032|       0|       0.072|      21.898
RTD|       0.366|       3.918|      21.084|       0|       0.072|      21.898
RTD|       0.338|       3.923|      21.046|       0|       0.072|      21.898
RTD|       0.336|       3.924|      20.987|       0|       0.072|      21.898
RTD|       0.351|       3.921|      20.924|       0|       0.072|      21.898
RTD|       0.350|       3.925|      21.147|       0|       0.072|      21.898
RTT|  00:01:46  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.342|       3.917|      20.929|       0|       0.072|      21.898
RTD|       0.345|       3.926|      21.645|       0|       0.072|      21.898
RTD|       0.337|       3.923|      21.054|       0|       0.072|      21.898
RTD|       0.359|       3.924|      20.927|       0|       0.072|      21.898
RTD|       0.335|       3.926|      20.888|       0|       0.072|      21.898
RTD|       0.333|       3.930|      20.941|       0|       0.072|      21.898
RTD|       0.337|       3.927|      20.904|       0|       0.072|      21.898
RTD|       0.355|       3.922|      21.003|       0|       0.072|      21.898
RTD|       0.344|       3.925|      20.941|       0|       0.072|      21.898
RTD|       0.350|       3.921|      20.920|       0|       0.072|      21.898
RTD|       0.358|       3.922|      20.918|       0|       0.072|      21.898
RTD|       0.327|       3.925|      20.917|       0|       0.072|      21.898
RTD|       0.353|       3.928|      20.923|       0|       0.072|      21.898
RTD|       0.334|       3.922|      20.949|       0|       0.072|      21.898
---|--param|----range-|--samples
HSD|    min|   0 -  1 |      119
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |   994819
HSD|    avg|   1 -  2 |     4730
HSD|    avg|   2 -  3 |      359
HSD|    avg|  10 - 11 |       41
HSD|    avg|  11 - 12 |        5
HSD|    avg|  16 - 17 |       17
HSD|    avg|  20 - 21 |   199939
HSD|    avg|  21 - 22 |       58
---|--param|----range-|--samples
HSD|    max|  20 - 21 |       73
HSD|    max|  21 - 22 |       46
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       119|      0.000|      0.000
HSS|    avg|   1199968|      3.339|      7.452
HSS|    max|       119|     20.387|      0.489
---|------------|------------|------------|--------|-------------------------
RTS|       0.072|       3.923|      21.898|       0|    00:02:00/00:02:00

Mi 9. Mai 20:17:32 CEST 2007
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
RTD|      -1.962|       1.649|      18.610|       0|      -1.962|      18.610
RTD|      -1.980|       1.649|      18.610|       0|      -1.980|      18.610
RTD|      -1.944|       1.650|      18.609|       0|      -1.980|      18.610
RTD|      -1.991|       1.649|      18.664|       0|      -1.991|      18.664
RTD|      -1.942|       1.648|      18.628|       0|      -1.991|      18.664
RTD|      -2.009|       1.650|      18.615|       0|      -2.009|      18.664
RTD|      -2.018|       1.649|      18.657|       0|      -2.018|      18.664
RTD|      -2.031|       1.649|      18.633|       0|      -2.031|      18.664
RTD|      -1.967|       1.649|      18.609|       0|      -2.031|      18.664
RTD|      -2.016|       1.644|      18.701|       0|      -2.031|      18.701
RTD|      -2.033|       1.650|      18.653|       0|      -2.033|      18.701
RTD|      -1.934|       1.650|      18.628|       0|      -2.033|      18.701
RTD|      -1.994|       1.649|      18.623|       0|      -2.033|      18.701
RTD|      -1.984|       1.650|      18.642|       0|      -2.033|      18.701
RTD|      -2.016|       1.641|      18.678|       0|      -2.033|      18.701
RTD|      -1.941|       1.649|      18.613|       0|      -2.033|      18.701
RTD|      -1.959|       1.649|      18.608|       0|      -2.033|      18.701
RTD|      -2.024|       1.648|      18.665|       0|      -2.033|      18.701
RTD|      -1.984|       1.649|      18.672|       0|      -2.033|      18.701
RTD|      -2.009|       1.644|      18.602|       0|      -2.033|      18.701
RTD|      -1.974|       1.649|      18.625|       0|      -2.033|      18.701
RTT|  00:00:22  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -1.992|       1.649|      18.627|       0|      -2.033|      18.701
RTD|      -1.948|       1.651|      18.632|       0|      -2.033|      18.701
RTD|      -1.984|       1.646|      18.611|       0|      -2.033|      18.701
RTD|      -1.985|       1.642|      18.602|       0|      -2.033|      18.701
RTD|      -1.963|       1.650|      18.635|       0|      -2.033|      18.701
RTD|      -1.963|       1.649|      18.621|       0|      -2.033|      18.701
RTD|      -1.929|       1.649|      18.638|       0|      -2.033|      18.701
RTD|      -1.977|       1.651|      18.631|       0|      -2.033|      18.701
RTD|      -1.928|       1.642|      18.753|       0|      -2.033|      18.753
RTD|      -1.941|       1.650|      18.960|       0|      -2.033|      18.960
RTD|      -1.987|       1.650|      18.614|       0|      -2.033|      18.960
RTD|      -2.006|       1.649|      18.610|       0|      -2.033|      18.960
RTD|      -1.996|       1.648|      18.610|       0|      -2.033|      18.960
RTD|      -1.978|       1.649|      18.711|       0|      -2.033|      18.960
RTD|      -1.972|       1.651|      18.625|       0|      -2.033|      18.960
RTD|      -1.929|       1.647|      18.635|       0|      -2.033|      18.960
RTD|      -2.021|       1.651|      18.647|       0|      -2.033|      18.960
RTD|      -1.977|       1.649|      18.627|       0|      -2.033|      18.960
RTD|      -2.001|       1.644|      18.595|       0|      -2.033|      18.960
RTD|      -2.041|       1.649|      18.612|       0|      -2.041|      18.960
RTD|      -1.989|       1.649|      18.627|       0|      -2.041|      18.960
RTT|  00:00:43  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -1.945|       1.648|      18.610|       0|      -2.041|      18.960
RTD|      -1.969|       1.650|      18.760|       0|      -2.041|      18.960
RTD|      -2.025|       1.644|      18.741|       0|      -2.041|      18.960
RTD|      -2.011|       1.649|      18.610|       0|      -2.041|      18.960
RTD|      -1.966|       1.650|      18.626|       0|      -2.041|      18.960
RTD|      -1.979|       1.649|      18.611|       0|      -2.041|      18.960
RTD|      -1.963|       1.650|      18.609|       0|      -2.041|      18.960
RTD|      -1.994|       1.639|      18.697|       0|      -2.041|      18.960
RTD|      -2.010|       1.649|      18.633|       0|      -2.041|      18.960
RTD|      -1.993|       1.649|      18.613|       0|      -2.041|      18.960
RTD|      -1.913|       1.650|      18.620|       0|      -2.041|      18.960
RTD|      -2.027|       1.649|      18.661|       0|      -2.041|      18.960
RTD|      -2.017|       1.642|      18.687|       0|      -2.041|      18.960
RTD|      -2.004|       1.650|      18.611|       0|      -2.041|      18.960
RTD|      -1.997|       1.648|      18.667|       0|      -2.041|      18.960
RTD|      -1.995|       1.650|      18.625|       0|      -2.041|      18.960
RTD|      -1.986|       1.649|      18.673|       0|      -2.041|      18.960
RTD|      -1.987|       1.642|      18.721|       0|      -2.041|      18.960
RTD|      -2.027|       1.649|      18.610|       0|      -2.041|      18.960
RTD|      -2.001|       1.653|      18.611|       0|      -2.041|      18.960
RTD|      -1.937|       1.646|      18.609|       0|      -2.041|      18.960
RTT|  00:01:04  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -1.985|       1.649|      18.611|       0|      -2.041|      18.960
RTD|      -2.003|       1.649|      18.628|       0|      -2.041|      18.960
RTD|      -1.997|       1.649|      18.611|       0|      -2.041|      18.960
RTD|      -1.948|       1.650|      18.612|       0|      -2.041|      18.960
RTD|      -1.924|       1.651|      18.802|       0|      -2.041|      18.960
RTD|      -1.979|       1.649|      18.621|       0|      -2.041|      18.960
RTD|      -1.980|       1.641|      18.629|       0|      -2.041|      18.960
RTD|      -1.996|       1.649|      18.622|       0|      -2.041|      18.960
RTD|      -1.983|       1.642|      18.689|       0|      -2.041|      18.960
RTD|      -1.962|       1.641|      18.594|       0|      -2.041|      18.960
RTD|      -1.986|       1.642|      18.609|       0|      -2.041|      18.960
RTD|      -2.003|       1.642|      18.595|       0|      -2.041|      18.960
RTD|      -2.020|       1.647|      18.611|       0|      -2.041|      18.960
RTD|      -2.041|       1.649|      18.679|       0|      -2.041|      18.960
RTD|      -1.970|       1.642|      18.605|       0|      -2.041|      18.960
RTD|      -1.971|       1.641|      18.607|       0|      -2.041|      18.960
RTD|      -1.995|       1.649|      18.743|       0|      -2.041|      18.960
RTD|      -2.029|       1.644|      18.605|       0|      -2.041|      18.960
RTD|      -1.971|       1.647|      18.642|       0|      -2.041|      18.960
RTD|      -1.972|       1.649|      18.627|       0|      -2.041|      18.960
RTD|      -1.997|       1.643|      18.616|       0|      -2.041|      18.960
RTT|  00:01:25  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -1.997|       1.643|      18.600|       0|      -2.041|      18.960
RTD|      -1.920|       1.642|      18.609|       0|      -2.041|      18.960
RTD|      -1.928|       1.642|      18.602|       0|      -2.041|      18.960
RTD|      -1.933|       1.642|      18.619|       0|      -2.041|      18.960
RTD|      -2.009|       1.648|      18.623|       0|      -2.041|      18.960
RTD|      -1.996|       1.645|      18.642|       0|      -2.041|      18.960
RTD|      -2.022|       1.641|      18.599|       0|      -2.041|      18.960
RTD|      -1.926|       1.641|      18.600|       0|      -2.041|      18.960
RTD|      -1.935|       1.642|      18.603|       0|      -2.041|      18.960
RTD|      -1.986|       1.642|      18.604|       0|      -2.041|      18.960
RTD|      -1.958|       1.650|      18.688|       0|      -2.041|      18.960
RTD|      -2.005|       1.650|      18.674|       0|      -2.041|      18.960
RTD|      -1.963|       1.647|      18.624|       0|      -2.041|      18.960
RTD|      -1.947|       1.642|      18.608|       0|      -2.041|      18.960
RTD|      -1.972|       1.641|      18.606|       0|      -2.041|      18.960
RTD|      -1.990|       1.642|      18.642|       0|      -2.041|      18.960
RTD|      -2.029|       1.647|      18.610|       0|      -2.041|      18.960
RTD|      -1.968|       1.649|      18.646|       0|      -2.041|      18.960
RTD|      -1.952|       1.642|      18.604|       0|      -2.041|      18.960
RTD|      -1.964|       1.642|      18.605|       0|      -2.041|      18.960
RTD|      -1.919|       1.649|      18.624|       0|      -2.041|      18.960
RTT|  00:01:46  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -1.998|       1.650|      18.635|       0|      -2.041|      18.960
RTD|      -1.923|       1.644|      18.609|       0|      -2.041|      18.960
RTD|      -1.918|       1.639|      18.607|       0|      -2.041|      18.960
RTD|      -1.976|       1.642|      18.597|       0|      -2.041|      18.960
RTD|      -2.019|       1.652|      18.610|       0|      -2.041|      18.960
RTD|      -2.007|       1.641|      18.603|       0|      -2.041|      18.960
RTD|      -2.029|       1.641|      18.621|       0|      -2.041|      18.960
RTD|      -1.956|       1.642|      18.595|       0|      -2.041|      18.960
RTD|      -2.030|       1.648|      18.624|       0|      -2.041|      18.960
RTD|      -1.981|       1.642|      18.605|       0|      -2.041|      18.960
RTD|      -2.005|       1.642|      18.595|       0|      -2.041|      18.960
RTD|      -1.928|       1.642|      18.595|       0|      -2.041|      18.960
RTD|      -1.959|       1.642|      18.602|       0|      -2.041|      18.960
RTD|      -1.953|       1.642|      18.604|       0|      -2.041|      18.960
---|--param|----range-|--samples
HSD|    min|   1 -  2 |       85
HSD|    min|   2 -  3 |       34
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |     1222
HSD|    avg|   1 -  2 |   998648
HSD|    avg|   2 -  3 |       43
HSD|    avg|   8 -  9 |       48
HSD|    avg|  18 - 19 |   200014
---|--param|----range-|--samples
HSD|    max|  18 - 19 |      119
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       119|      1.286|      0.454
HSS|    avg|   1199975|      3.833|      6.336
HSS|    max|       119|     18.000|      0.000
---|------------|------------|------------|--------|-------------------------
RTS|      -2.041|       1.646|      18.960|       0|    00:02:00/00:02:00

Mi 9. Mai 20:19:33 CEST 2007
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
== Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-5 rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12 rtus_ufps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18 rtuo_ufps-19 rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|       11500|       11500
RTD|       11523|       23023
RTD|       11523|       34546
RTD|       11523|       46069
RTD|       11523|       57592
RTD|       11523|       69115
RTD|       11523|       80638
RTD|       11523|       92161
RTD|       11523|      103684
RTD|       11523|      115207
RTD|       11523|      126730
RTD|       11523|      138253
RTD|       11523|      149776
RTD|       11523|      161299
RTD|       11523|      172822
RTD|       11523|      184345
RTD|       10511|      194856
RTD|        7682|      202538
RTD|        7682|      210220
RTD|        7682|      217902
RTD|        7682|      225584
RTT|  00:00:22
RTH|ctx switches|-------total
RTD|        7682|      233266
RTD|        7682|      240948
RTD|        7682|      248630
RTD|        7682|      256312
RTD|        7682|      263994
RTD|        7682|      271676
RTD|        7682|      279358
RTD|        7682|      287040
RTD|        7820|      294860
RTD|        8303|      303163
RTD|        9384|      312547
RTD|        9913|      322460
RTD|       10833|      333293
RTD|       11523|      344816
RTD|       11523|      356339
RTD|       11523|      367862
RTD|       11523|      379385
RTD|       11523|      390908
RTD|       11523|      402431
RTD|       11523|      413954
RTD|       11523|      425477
RTT|  00:00:43
RTH|ctx switches|-------total
RTD|       11523|      437000
RTD|       11523|      448523
RTD|       11523|      460046
RTD|       11523|      471569
RTD|       11523|      483092
RTD|       11523|      494615
RTD|       11523|      506138
RTD|       11523|      517661
RTD|       11523|      529184
RTD|       11523|      540707
RTD|       11523|      552230
RTD|       11523|      563753
RTD|       11523|      575276
RTD|       11523|      586799
RTD|       11523|      598322
RTD|       11523|      609845
RTD|       11523|      621368
RTD|       11523|      632891
RTD|       11523|      644414
RTD|       11523|      655937
RTD|       11523|      667460
RTT|  00:01:04
RTH|ctx switches|-------total
RTD|       11523|      678983
RTD|       11523|      690506
RTD|       11523|      702029
RTD|       11523|      713552
RTD|       11523|      725075
RTD|       11523|      736598
RTD|       11523|      748121
RTD|       11523|      759644
RTD|       11523|      771167
RTD|       11523|      782690
RTD|       11523|      794213
RTD|       11523|      805736
RTD|       11523|      817259
RTD|       11523|      828782
RTD|       11523|      840305
RTD|       11523|      851828
RTD|       11362|      863190
RTD|        7682|      870872
RTD|        7682|      878554
RTD|        7682|      886236
RTD|        7682|      893918
RTT|  00:01:25
RTH|ctx switches|-------total
RTD|        7682|      901600
RTD|        7682|      909282
RTD|        7682|      916964
RTD|        7682|      924646
RTD|        7682|      932328
RTD|        7682|      940010
RTD|        7682|      947692
RTD|        7682|      955374
RTD|        7751|      963125
RTD|        8188|      971313
RTD|        9016|      980329
RTD|        9936|      990265
RTD|       10534|     1000799
RTD|       11477|     1012276
RTD|       11523|     1023799
RTD|       11523|     1035322
RTD|       11500|     1046822
RTD|       11523|     1058345
RTD|       11523|     1069868
RTD|       11523|     1081391
RTD|       11500|     1092891
RTT|  00:01:46
RTH|ctx switches|-------total
RTD|       11523|     1104414
RTD|       11523|     1115937
RTD|       11523|     1127460
RTD|       11523|     1138983
RTD|       11523|     1150506
RTD|       11523|     1162029
RTD|       11523|     1173552
RTD|       11523|     1185075
RTD|       11523|     1196598
RTD|       11523|     1208121
RTD|       11523|     1219644
RTD|       11523|     1231167
RTD|       11523|     1242690
RTD|       11523|     1254213
RTD|        9039|     1263252

Mi 9. Mai 20:21:33 CEST 2007
running: ./run -- -h # switchbench
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|       5.842|       5.922|      16.180|           0
---|---range-|---samples
HSD| 5 - 6 |      98828
HSD| 6 - 7 |       1165
HSD| 7 - 8 |          2
HSD| 16 - 17 |          1
HSS|     99996|      5.012|      0.113

Mi 9. Mai 20:21:43 CEST 2007
running: ./run -- -p 10 -n -l 1000 # cyclictest
*
*
* Type ^C to stop this application.
*
*
0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:      12 Min:      21 Act:      22 Avg:    1037 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:      23 Min:      21 Act:      22 Avg:     551 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:      34 Min:      21 Act:      21 Avg:     380 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:      45 Min:      21 Act:      21 Avg:     292 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:      56 Min:      21 Act:      21 Avg:     239 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:      67 Min:      21 Act:      21 Avg:     203 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:      78 Min:      21 Act:      21 Avg:     177 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:      89 Min:      21 Act:      21 Avg:     158 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     100 Min:      21 Act:      21 Avg:     143 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     111 Min:      21 Act:      21 Avg:     131 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     122 Min:      21 Act:      22 Avg:     121 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     133 Min:      21 Act:      21 Avg:     112 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     144 Min:      21 Act:      21 Avg:     105 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     155 Min:      21 Act:      21 Avg:      99 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     166 Min:      21 Act:      21 Avg:      94 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     177 Min:      21 Act:      21 Avg:      90 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     188 Min:      21 Act:      22 Avg:      86 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     199 Min:      21 Act:      21 Avg:      82 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     210 Min:      21 Act:      21 Avg:      79 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     221 Min:      21 Act:      21 Avg:      76 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     232 Min:      21 Act:      21 Avg:      73 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     243 Min:      21 Act:      21 Avg:      71 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     254 Min:      21 Act:      21 Avg:      69 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     265 Min:      21 Act:      21 Avg:      67 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     276 Min:      21 Act:      21 Avg:      65 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     287 Min:      21 Act:      21 Avg:      63 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     298 Min:      21 Act:      21 Avg:      62 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     309 Min:      21 Act:      21 Avg:      60 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     320 Min:      21 Act:      21 Avg:      59 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     331 Min:      21 Act:      21 Avg:      58 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     342 Min:      21 Act:      21 Avg:      56 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     353 Min:      21 Act:      21 Avg:      55 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     364 Min:      21 Act:      21 Avg:      54 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     375 Min:      21 Act:      21 Avg:      53 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     386 Min:      21 Act:      22 Avg:      52 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     397 Min:      21 Act:      21 Avg:      51 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     408 Min:      21 Act:      21 Avg:      51 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     419 Min:      21 Act:      21 Avg:      50 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     430 Min:      21 Act:      21 Avg:      49 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     441 Min:      21 Act:      21 Avg:      48 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     452 Min:      21 Act:      21 Avg:      48 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     463 Min:      21 Act:      21 Avg:      47 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     474 Min:      21 Act:      21 Avg:      46 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     485 Min:      21 Act:      21 Avg:      46 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     496 Min:      21 Act:      21 Avg:      45 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     507 Min:      21 Act:      21 Avg:      45 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     518 Min:      21 Act:      21 Avg:      44 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     529 Min:      21 Act:      21 Avg:      44 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     540 Min:      21 Act:      21 Avg:      43 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     551 Min:      21 Act:      21 Avg:      43 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     562 Min:      21 Act:      21 Avg:      42 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     573 Min:      21 Act:      21 Avg:      42 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     584 Min:      21 Act:      21 Avg:      42 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     595 Min:      21 Act:      21 Avg:      41 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     606 Min:      21 Act:      21 Avg:      41 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     617 Min:      21 Act:      21 Avg:      41 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     628 Min:      21 Act:      21 Avg:      40 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     639 Min:      21 Act:      21 Avg:      40 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     650 Min:      21 Act:      21 Avg:      40 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     661 Min:      21 Act:      21 Avg:      39 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     672 Min:      21 Act:      21 Avg:      39 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     683 Min:      21 Act:      21 Avg:      39 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     694 Min:      21 Act:      21 Avg:      38 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     705 Min:      21 Act:      21 Avg:      38 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     716 Min:      21 Act:      21 Avg:      38 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     727 Min:      21 Act:      21 Avg:      38 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     738 Min:      21 Act:      21 Avg:      37 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     749 Min:      21 Act:      21 Avg:      37 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     760 Min:      21 Act:      21 Avg:      37 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     771 Min:       1 Act:      21 Avg:      37 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     782 Min:       1 Act:      21 Avg:      36 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     793 Min:       1 Act:      21 Avg:      36 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     804 Min:       1 Act:      21 Avg:      36 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     815 Min:       1 Act:      21 Avg:      36 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     826 Min:       1 Act:      11 Avg:      35 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     837 Min:       1 Act:      32 Avg:      35 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     848 Min:       1 Act:      11 Avg:      35 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     859 Min:       1 Act:      31 Avg:      35 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     870 Min:       1 Act:      11 Avg:      35 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     881 Min:       1 Act:      11 Avg:      35 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     892 Min:       1 Act:      22 Avg:      34 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     903 Min:       1 Act:      21 Avg:      34 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     914 Min:       1 Act:      21 Avg:      34 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     925 Min:       1 Act:      21 Avg:      34 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     936 Min:       1 Act:      21 Avg:      34 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     947 Min:       1 Act:      21 Avg:      33 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     958 Min:       1 Act:      21 Avg:      33 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     969 Min:       1 Act:      21 Avg:      33 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     980 Min:       1 Act:      31 Avg:      33 Max:    4452
[3A0.02 0.02 0.00 1/58 4802          

T: 0 ( 4802) P:10 I:    1000 C:     991 Min:       1 Act:      11 Avg:      33 Max:    4452
[3A0.02 0.02 0.00 1/57 4802          

T: 0 ( 4802) P:10 I:    1000 C:    1000 Min:       1 Act:      31 Avg:      33 Max:    4452

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/interrupts
           CPU0       CPU1       
  0:    3347241          0  local-APIC-edge-fasteio   timer, rthal_broadcast_timer
  1:        490          0   IO-APIC-edge      i8042
  2:          0          0    XT-PIC-XT        cascade
  8:          3          0   IO-APIC-edge      rtc
 12:        132          0   IO-APIC-edge      i8042
 14:       4344          0   IO-APIC-edge      libata
 15:         21          0   IO-APIC-edge      libata
 18:          0          0   IO-APIC-fasteoi   libata
 20:         67          0   IO-APIC-fasteoi   uhci_hcd:usb1, uhci_hcd:usb3, ehci_hcd:usb7
 21:        104          0   IO-APIC-fasteoi   uhci_hcd:usb2, uhci_hcd:usb4, HDA Intel
 22:         30          0   IO-APIC-fasteoi   uhci_hcd:usb5, ehci_hcd:usb6
NMI:          0          0 
LOC:    3347078    3347076 
ERR:          0
MIS:          0

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/loadavg
0.02 0.02 0.00 1/53 4814

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/meminfo
MemTotal:       905564 kB
MemFree:        857988 kB
Buffers:          8900 kB
Cached:          19408 kB
SwapCached:          0 kB
Active:          19888 kB
Inactive:        12924 kB
SwapTotal:     3004112 kB
SwapFree:      3004112 kB
Dirty:              36 kB
Writeback:           0 kB
AnonPages:        4416 kB
Mapped:           2356 kB
Slab:             8164 kB
SReclaimable:     2840 kB
SUnreclaim:       5324 kB
PageTables:        276 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   3456892 kB
Committed_AS:     8288 kB
VmallocTotal:   122600 kB
VmallocUsed:      4580 kB
VmallocChunk:   117812 kB

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/apc
APC          CPU0         CPU1
  0:            0           0    (pipe_wakeup)
  1:       440176        2380    (lostage_handler)
  2:            4           6    (registry_export)
  3:            0           0    (posix_signals_handler)

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/faults
TRAP         CPU0        CPU1
  0:            0           0    (Divide error)
  1:            0           0    (Debug)
  3:            0           0    (Int3)
  4:            0           0    (Overflow)
  5:            0           0    (Bounds)
  6:            0           0    (Invalid opcode)
  7:            1           1    (FPU not available)
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

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/hal
1.7-03

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/heap
size=130560:used=64:pagesz=512

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/irq
IRQ         CPU0        CPU1
213:       34952          21
216:     6154214    23560415         [timer]
217:           0           0
226:     2193999       39712         [virtual]

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/latency
2699

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT/0
  1  0       -1      0        0          R          ROOT/1

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          4860665    0     00500080   97.9  ROOT/0
  1  0      0          23559689   0     00500080   98.3  ROOT/1
  0  0      0          6154214    0     00000000    0.6  IRQ216: [timer]
  1  0      0          23560415   0     00000000    0.4  IRQ216: [timer]

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/timer
status=oneshot+watchdog:setup=55:tickval=1:jiffies=3346976415172

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/version
2.3.1

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/interfaces/native
0

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/interfaces/posix
0

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/interfaces/rtdm
0

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/interfaces/sys
0

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				Driver		/proc

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device

Mi 9. Mai 20:21:45 CEST 2007
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Mi 9. Mai 20:21:45 CEST 2007
running: top -bn1c
top - 20:21:46 up 55 min,  1 user,  load average: 0.02, 0.02, 0.00
Tasks:  55 total,   1 running,  54 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0%us,  0.1%sy,  0.0%ni, 99.8%id,  0.1%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:    905564k total,    47552k used,   858012k free,     8900k buffers
Swap:  3004112k total,        0k used,  3004112k free,    19408k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
    1 root      19   0  2908 1848  524 S    0  0.2   0:00.72 /sbin/init         
    2 root      RT   0     0    0    0 S    0  0.0   0:00.00 [migration/0]      
    3 root      34  19     0    0    0 S    0  0.0   0:00.00 [ksoftirqd/0]      
cleanup_load: no dd_jobs found
xeno-test: finished

--========GMX307801178798978763319--

