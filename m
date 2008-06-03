Message-ID: <4845166E.3000203@domain.hid>
Date: Tue, 03 Jun 2008 12:01:18 +0200
From: Paradoxxa <paradoxxa2001@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000901070708080505020005"
Sender: paradoxxa2001@domain.hid
Subject: [Xenomai-help] xeno-test on AT91SAM9263 irqloop and switchtest
	problem?
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
--------------000901070708080505020005
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I have here a AT91SAM9263 with a 2.6.24 kernel, Xenomai 2.4.3 and Adeos
Patch 1.9-01 and run the xeno-test. It seems there are a Problem with 
the irqloop and the switchtest applications.
In the attachment you can find the log files.


Thomas



--------------000901070708080505020005
Content-Type: text/plain;
 name="xeno-test.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno-test.log"

xeno-test: started -p 250 -T 120
withBusybox is 1
xeno-test: running tests
/usr/xenomai/bin/xeno-test: eval: line 1: -p: not found

Thu Jan  1 00:29:11 UTC 1970
running: /usr/xenomai/bin/xeno-config --verbose
xeno-config --verbose
        --version="2.4.3"
        --cc="arm-at91-linux-gnu-gcc"
        --arch="arm"
        --prefix="/usr/xenomai"
        --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
        --xeno-ldflags="-L/usr/xenomai/lib -lpthread "
        --posix-cflags="-I/usr/xenomai/include -I/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
        --posix-ldflags="-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
        --library-dir="/usr/xenomai/lib"

Thu Jan  1 00:29:11 UTC 1970
running: /usr/xenomai/bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
BusyBox v1.10.2 (2008-06-03 10:56:40 CEST) multi-call binary
Linux PM9263 2.6.24 #12 Thu May 29 11:30:45 CEST 2008 armv5tejl unknown
 
module-init-tools      found
Modules Loaded         

Thu Jan  1 00:29:12 UTC 1970
running: cat /proc/cpuinfo
Processor	: ARM926EJ-S rev 5 (v5l)
BogoMIPS	: 99.12
Features	: swp half thumb fastmult edsp java 
CPU implementer	: 0x41
CPU architecture: 5TEJ
CPU variant	: 0x0
CPU part	: 0x926
CPU revision	: 5
Cache type	: write-back
Cache clean	: cp15 c7 ops
Cache lockdown	: format C
Cache format	: Harvard
I size		: 16384
I assoc		: 4
I line length	: 32
I sets		: 128
D size		: 16384
D assoc		: 4
D line length	: 32
D sets		: 128

Hardware	: Ronetix PM9263/BB9263
Revision	: 0000
Serial		: 0000000000000000

Thu Jan  1 00:29:13 UTC 1970
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
ed334d6f3362dd75f6a47b30b005b598  /proc/cpuinfo

Thu Jan  1 00:29:13 UTC 1970
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
 192:  G...V
 193:  G...V
[Domain info]
id=0x00000000
priority=100

Thu Jan  1 00:29:13 UTC 1970
running: cat /proc/ipipe/Xenomai
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
  19:  W..X.
 194:  W...V
[Domain info]
id=0x58454e4f
priority=topmost

Thu Jan  1 00:29:13 UTC 1970
running: cat /proc/ipipe/version
1.9-01

Thu Jan  1 00:29:13 UTC 1970
running: generate_loads 1
dd workload started, pids 1500 stored in /var/lock/xeno-test.1399.pids

Thu Jan  1 00:29:13 UTC 1970
running: cat /proc/interrupts
           CPU0
  1:     748370         AIC  rtc0, atmel_serial
 14:          2         AIC  atmel_spi.0
 15:          4         AIC  atmel_spi.1
 18:          0         AIC  ac97
 19:     175287         AIC  at91_tick
 21:        321         AIC  eth0
 26:          0         AIC  atmel_lcdfb
 29:          0         AIC  ohci_hcd:usb1
 31:          0         AIC  ads7846
 56:          0        GPIO  at91_cf
 62:          1        GPIO  at91_cf
Err:          0

Thu Jan  1 00:29:13 UTC 1970
running: cat /proc/loadavg
0.72 1.95 1.67 3/34 1506

Thu Jan  1 00:29:13 UTC 1970
running: cat /proc/meminfo
MemTotal:        61276 kB
MemFree:         50304 kB
Buffers:             0 kB
Cached:           5852 kB
SwapCached:          0 kB
Active:           5048 kB
Inactive:         2440 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
AnonPages:        1648 kB
Mapped:           1300 kB
Slab:             2148 kB
SReclaimable:      216 kB
SUnreclaim:       1932 kB
PageTables:        188 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:     30636 kB
Committed_AS:     7060 kB
VmallocTotal:   956416 kB
VmallocUsed:    333252 kB
VmallocChunk:   587772 kB

Thu Jan  1 00:29:13 UTC 1970
running: cat /proc/xenomai/affinity
00000001

Thu Jan  1 00:29:13 UTC 1970
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:          898    (lostage_handler)
  2:           10    (registry_export)
  3:            0    (pse51_lostage_handler)

Thu Jan  1 00:29:14 UTC 1970
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:            0    (Data or instruction access)
  1:            0    (Section fault)
  2:            0    (Generic data abort)
  3:            0    (Unknown exception)
  4:            0    (Instruction breakpoint)
  5:          844    (Floating point exception)
  6:            0    (VFP Floating point exception)
  7:            0    (Undefined instruction)
  8:            0    (Unaligned access exception)

Thu Jan  1 00:29:14 UTC 1970
running: cat /proc/xenomai/hal
1.9-01

Thu Jan  1 00:29:14 UTC 1970
running: cat /proc/xenomai/heap
size=129536:used=4160:pagesz=512  (main heap)
size=32256:used=0:pagesz=512  (stack pool)

Thu Jan  1 00:29:14 UTC 1970
running: cat /proc/xenomai/irq
IRQ         CPU0
 19:     3711248         [timer]
194:         912         [virtual]

Thu Jan  1 00:29:14 UTC 1970
running: cat /proc/xenomai/latency
9645

Thu Jan  1 00:29:14 UTC 1970
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT

Thu Jan  1 00:29:14 UTC 1970
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          3550465    0     00500080   85.5  ROOT
  0  0      0          3711280    0     00000000    3.5  IRQ19: [timer]

Thu Jan  1 00:29:14 UTC 1970
running: cat /proc/xenomai/timebases
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled,set

Thu Jan  1 00:29:14 UTC 1970
running: cat /proc/xenomai/timer
status=on:setup=321:clock=5458712893:timerdev=at91_tc0:clockdev=at91_tc0

Thu Jan  1 00:29:14 UTC 1970
running: cat /proc/xenomai/version
2.4.3

Thu Jan  1 00:29:15 UTC 1970
running: cat /proc/xenomai/interfaces/native
0

Thu Jan  1 00:29:15 UTC 1970
running: cat /proc/xenomai/interfaces/posix
0

Thu Jan  1 00:29:15 UTC 1970
running: cat /proc/xenomai/interfaces/rtdm
0

Thu Jan  1 00:29:15 UTC 1970
running: cat /proc/xenomai/interfaces/sys
0

Thu Jan  1 00:29:15 UTC 1970
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Thu Jan  1 00:29:15 UTC 1970
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				Driver		/proc

Thu Jan  1 00:29:15 UTC 1970
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device		Owner [PID]

Thu Jan  1 00:29:15 UTC 1970
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Thu Jan  1 00:29:15 UTC 1970
running: cat /proc/xenomai/timerstat/master
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           
0    175554      175553      8332368    10000000   NULL         [host-timer]   

Thu Jan  1 00:29:16 UTC 1970
running: top
[H[JMem: 11360K used, 49916K free, 0K shrd, 0K buff, 5864K cached
CPU:   0% usr 100% sys   0% nice   0% idle   0% io   0% irq   0% softirq
Load average: 0.91 1.96 1.68
[7m  PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND[0m
 1234     1 root     R     2780   5%  44% dd if=/dev/zero of=/dev/null 
 1500     1 root     R     2780   5%  44% dd if=/dev/zero of=/dev/null 
 1578  1577 root     R     2852   5%  13% top 
  371     1 root     S     3708   6%   0% /usr/sbin/sshd 
  376     1 root     S     3172   5%   0% -sh 
 1576  1425 root     S     2860   5%   0% head -n 13 

Thu Jan  1 00:29:16 UTC 1970
running: ./run -- -p 250 -T 120 -t0 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 250 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 250 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      54.012|      67.193|      99.665|       0|      54.012|      99.665
RTD|      27.970|      67.193|     100.308|       0|      27.970|     100.308
RTD|      30.221|      67.193|      99.344|       0|      27.970|     100.308
RTD|      31.828|      67.193|      99.665|       0|      27.970|     100.308
RTD|      30.221|      67.193|      99.344|       0|      27.970|     100.308
RTD|      31.185|      67.193|     100.630|       0|      27.970|     100.630
RTD|      31.828|      67.193|     101.594|       0|      27.970|     101.594
RTD|      30.542|      67.193|      99.344|       0|      27.970|     101.594
RTD|      30.542|      67.193|      99.987|       0|      27.970|     101.594
RTD|      32.471|      67.193|      98.701|       0|      27.970|     101.594
RTD|      32.793|      67.193|      99.022|       0|      27.970|     101.594
RTD|      28.613|      67.193|      99.022|       0|      27.970|     101.594
RTD|      27.970|      67.193|      99.665|       0|      27.970|     101.594
RTD|      30.542|      67.193|      99.665|       0|      27.970|     101.594
RTD|      33.114|      67.193|      99.022|       0|      27.970|     101.594
RTD|      30.864|      67.193|     101.594|       0|      27.970|     101.594
RTD|      31.507|      67.193|      99.665|       0|      27.970|     101.594
RTD|      31.828|      67.193|      99.344|       0|      27.970|     101.594
RTD|      31.828|      67.193|     105.131|       0|      27.970|     105.131
RTD|      31.185|      67.193|     100.308|       0|      27.970|     105.131
RTD|      32.150|      67.193|      98.701|       0|      27.970|     105.131
RTT|  00:00:22  (periodic user-mode task, 250 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      30.864|      67.193|      99.022|       0|      27.970|     105.131
RTD|      30.221|      67.193|      98.701|       0|      27.970|     105.131
RTD|      31.507|      67.193|      99.665|       0|      27.970|     105.131
RTD|      30.542|      67.193|      99.344|       0|      27.970|     105.131
RTD|      29.899|      67.193|      99.022|       0|      27.970|     105.131
RTD|      29.578|      67.193|      99.665|       0|      27.970|     105.131
RTD|      31.185|      67.193|      99.344|       0|      27.970|     105.131
RTD|      32.150|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.185|      67.193|     103.523|       0|      27.970|     105.131
RTD|      30.864|      67.193|     105.131|       0|      27.970|     105.131
RTD|      32.150|      67.193|     103.202|       0|      27.970|     105.131
RTD|      31.185|      67.193|      99.665|       0|      27.970|     105.131
RTD|      32.471|      67.193|      99.344|       0|      27.970|     105.131
RTD|      29.578|      67.193|      99.665|       0|      27.970|     105.131
RTD|      31.185|      67.193|      99.344|       0|      27.970|     105.131
RTD|      32.793|      67.193|      99.344|       0|      27.970|     105.131
RTD|      30.221|      67.193|      99.022|       0|      27.970|     105.131
RTD|      30.542|      67.193|      99.344|       0|      27.970|     105.131
RTD|      32.150|      67.193|      99.022|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.665|       0|      27.970|     105.131
RTD|      30.221|      67.193|      99.344|       0|      27.970|     105.131
RTT|  00:00:43  (periodic user-mode task, 250 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      31.185|      67.193|     104.488|       0|      27.970|     105.131
RTD|      33.114|      67.193|      98.701|       0|      27.970|     105.131
RTD|      30.221|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.665|       0|      27.970|     105.131
RTD|      31.185|      67.193|     100.630|       0|      27.970|     105.131
RTD|      30.864|      67.193|      99.665|       0|      27.970|     105.131
RTD|      28.935|      67.193|      99.665|       0|      27.970|     105.131
RTD|      32.150|      67.193|      99.665|       0|      27.970|     105.131
RTD|      31.507|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.185|      67.193|      99.344|       0|      27.970|     105.131
RTD|      28.613|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.507|      67.193|      99.987|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.665|       0|      27.970|     105.131
RTD|      30.542|      67.193|     100.630|       0|      27.970|     105.131
RTD|      31.185|      67.193|      99.022|       0|      27.970|     105.131
RTD|      31.507|      67.193|      99.987|       0|      27.970|     105.131
RTD|      29.899|      67.193|      99.665|       0|      27.970|     105.131
RTD|      29.578|      67.193|      99.665|       0|      27.970|     105.131
RTD|      31.185|      67.193|      99.022|       0|      27.970|     105.131
RTD|      32.150|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.507|      67.193|      99.344|       0|      27.970|     105.131
RTT|  00:01:04  (periodic user-mode task, 250 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      30.542|      67.193|      99.022|       0|      27.970|     105.131
RTD|      32.150|      67.515|      99.022|       0|      27.970|     105.131
RTD|      29.899|      67.193|      99.665|       0|      27.970|     105.131
RTD|      32.150|      67.193|      99.344|       0|      27.970|     105.131
RTD|      30.864|      67.193|      99.022|       0|      27.970|     105.131
RTD|      30.542|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.507|      67.193|      99.665|       0|      27.970|     105.131
RTD|      30.542|      67.193|      99.665|       0|      27.970|     105.131
RTD|      29.578|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.344|       0|      27.970|     105.131
RTD|      32.150|      67.193|      99.665|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.344|       0|      27.970|     105.131
RTD|      30.542|      67.193|      99.665|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.665|       0|      27.970|     105.131
RTD|      32.150|      67.193|      99.022|       0|      27.970|     105.131
RTD|      33.757|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.022|       0|      27.970|     105.131
RTD|      31.507|      67.193|      99.665|       0|      27.970|     105.131
RTD|      32.793|      67.193|      99.987|       0|      27.970|     105.131
RTT|  00:01:25  (periodic user-mode task, 250 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      30.864|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.344|       0|      27.970|     105.131
RTD|      30.221|      67.193|      99.344|       0|      27.970|     105.131
RTD|      30.864|      67.193|      99.665|       0|      27.970|     105.131
RTD|      32.150|      67.193|     100.951|       0|      27.970|     105.131
RTD|      31.185|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.185|      67.193|      98.701|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.665|       0|      27.970|     105.131
RTD|      32.150|      67.193|      99.987|       0|      27.970|     105.131
RTD|      30.542|      67.193|      99.344|       0|      27.970|     105.131
RTD|      30.542|      67.193|      99.665|       0|      27.970|     105.131
RTD|      30.542|      67.193|     100.630|       0|      27.970|     105.131
RTD|      32.150|      67.193|      99.665|       0|      27.970|     105.131
RTD|      31.507|      67.193|      99.987|       0|      27.970|     105.131
RTD|      30.542|      67.193|      99.665|       0|      27.970|     105.131
RTD|      32.471|      67.193|     100.308|       0|      27.970|     105.131
RTD|      30.864|      67.193|      99.344|       0|      27.970|     105.131
RTD|      32.793|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.665|       0|      27.970|     105.131
RTD|      30.221|      67.193|      99.665|       0|      27.970|     105.131
RTD|      30.864|      67.193|      99.022|       0|      27.970|     105.131
RTT|  00:01:46  (periodic user-mode task, 250 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      30.221|      67.193|      99.665|       0|      27.970|     105.131
RTD|      31.185|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.344|       0|      27.970|     105.131
RTD|      30.221|      67.193|      99.022|       0|      27.970|     105.131
RTD|      31.507|      67.193|      99.022|       0|      27.970|     105.131
RTD|      30.864|      67.193|     101.594|       0|      27.970|     105.131
RTD|      30.864|      67.193|      99.987|       0|      27.970|     105.131
RTD|      31.507|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.344|       0|      27.970|     105.131
RTD|      29.899|      67.193|      99.665|       0|      27.970|     105.131
RTD|      31.185|      67.193|      99.022|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.665|       0|      27.970|     105.131
RTD|      31.185|      67.193|      99.344|       0|      27.970|     105.131
RTD|      31.828|      67.193|      99.665|       0|      27.970|     105.131
---|------------|------------|------------|--------|-------------------------
RTS|      27.970|      67.193|     105.131|       0|    00:02:00/00:02:00

Thu Jan  1 00:31:20 UTC 1970
running: ./run -- -p 250 -T 120 -t1 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 250 us
== Test mode: in-kernel periodic task
== All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)

Thu Jan  1 00:31:24 UTC 1970
running: ./run -- -p 250 -T 120 -t2 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 250 us
== Test mode: in-kernel timer handler
== All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)

Thu Jan  1 00:31:27 UTC 1970
running: ./run -- -T 120 # switchtest
*
*
* Type ^C to stop this application.
*
*
== Testing FPU check routines...
== FPU check routines: unimplemented, skipping FPU switches tests.
switchtest: Unable to open switchtest device.
(modprobe xeno_switchtest ?)
== Threads:
Thu Jan  1 00:31:30 UTC 1970
running: ./run -- -p 250 # switchbench
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 250 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|      51.440|      54.333|      89.377|           0

Thu Jan  1 00:31:58 UTC 1970
running: ./run -- -p 10 -n -l 1000 # cyclictest
*
*
* Type ^C to stop this application.
*
*
2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:       8 Min:      71 Act:     104 Avg:      76 Max:     104
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:      28 Min:      43 Act:     105 Avg:      77 Max:     184
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:      48 Min:      43 Act:     106 Avg:      76 Max:     184
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:      68 Min:      43 Act:     105 Avg:      75 Max:     184
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:      88 Min:      43 Act:     103 Avg:      75 Max:     184
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     108 Min:      39 Act:     105 Avg:      88 Max:     855
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     128 Min:      39 Act:     104 Avg:      86 Max:     855
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     148 Min:      39 Act:     106 Avg:      84 Max:     855
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     168 Min:      39 Act:     104 Avg:      83 Max:     855
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     188 Min:      39 Act:     106 Avg:      82 Max:     855
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     208 Min:      39 Act:     106 Avg:      81 Max:     855
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     228 Min:      39 Act:     105 Avg:      81 Max:     855
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     251 Min:      39 Act:     386 Avg:      81 Max:     855
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     268 Min:      39 Act:     103 Avg:      81 Max:     855
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     288 Min:      39 Act:     104 Avg:      80 Max:     855
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     308 Min:      39 Act:     104 Avg:      80 Max:     855
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     332 Min:      39 Act:      68 Avg:      80 Max:     855
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     349 Min:      39 Act:      51 Avg:      80 Max:     855
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     369 Min:      39 Act:      49 Avg:      80 Max:     855
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     389 Min:      39 Act:      49 Avg:      80 Max:     855
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     409 Min:      39 Act:      49 Avg:      82 Max:     942
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     429 Min:      39 Act:      58 Avg:      82 Max:     942
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     449 Min:      39 Act:      48 Avg:      82 Max:     942
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     469 Min:      39 Act:      50 Avg:      82 Max:     942
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     489 Min:      39 Act:      48 Avg:      82 Max:     942
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     509 Min:      39 Act:      49 Avg:      81 Max:     942
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     529 Min:      39 Act:      48 Avg:      81 Max:     942
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     549 Min:      39 Act:      50 Avg:      81 Max:     942
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     569 Min:      39 Act:      50 Avg:      83 Max:    1010
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     589 Min:      39 Act:      50 Avg:      83 Max:    1010
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     609 Min:      39 Act:      49 Avg:      83 Max:    1010
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     629 Min:      39 Act:      49 Avg:      83 Max:    1010
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     649 Min:      39 Act:      49 Avg:      83 Max:    1010
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     669 Min:      39 Act:      49 Avg:      83 Max:    1010
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     689 Min:      39 Act:      51 Avg:      83 Max:    1010
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     709 Min:      39 Act:      48 Avg:      82 Max:    1010
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     729 Min:      39 Act:      47 Avg:      88 Max:    1710
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     749 Min:      39 Act:      49 Avg:      88 Max:    1710
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     769 Min:      39 Act:      49 Avg:      88 Max:    1710
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     789 Min:      34 Act:      34 Avg:      87 Max:    1710
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     809 Min:      34 Act:      50 Avg:      87 Max:    1710
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     829 Min:      34 Act:      49 Avg:      87 Max:    1710
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     849 Min:      34 Act:      47 Avg:      87 Max:    1710
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     869 Min:      34 Act:      47 Avg:      87 Max:    1710
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     889 Min:      34 Act:      48 Avg:      88 Max:    1710
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     909 Min:      34 Act:      50 Avg:      88 Max:    1710
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     929 Min:      34 Act:      48 Avg:      88 Max:    1710
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     949 Min:      34 Act:      47 Avg:      88 Max:    1710
[3A2.16 2.06 1.76 3/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     969 Min:      34 Act:      49 Avg:      88 Max:    1710
[3A2.16 2.06 1.76 4/40 2046          

T: 0 ( 2046) P:10 I:    1000 C:     989 Min:      34 Act:      48 Avg:      87 Max:    1710
[3A2.16 2.06 1.76 3/39 2046          

T: 0 ( 2046) P:10 I:    1000 C:    1000 Min:      34 Act:      79 Avg:      87 Max:    1710

Thu Jan  1 00:32:02 UTC 1970
running: cat /proc/interrupts
           CPU0
  1:     776473         AIC  rtc0, atmel_serial
 14:          2         AIC  atmel_spi.0
 15:          4         AIC  atmel_spi.1
 18:          0         AIC  ac97
 19:     192226         AIC  at91_tick
 21:        321         AIC  eth0
 26:          0         AIC  atmel_lcdfb
 29:          0         AIC  ohci_hcd:usb1
 31:          0         AIC  ads7846
 56:          0        GPIO  at91_cf
 62:          1        GPIO  at91_cf
Err:          0

Thu Jan  1 00:32:02 UTC 1970
running: cat /proc/loadavg
2.16 2.06 1.76 3/35 2058

Thu Jan  1 00:32:03 UTC 1970
running: cat /proc/meminfo
MemTotal:        61276 kB
MemFree:         49776 kB
Buffers:             0 kB
Cached:           6196 kB
SwapCached:          0 kB
Active:           5284 kB
Inactive:         2632 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
AnonPages:        1732 kB
Mapped:           1300 kB
Slab:             2212 kB
SReclaimable:      252 kB
SUnreclaim:       1960 kB
PageTables:        200 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:     30636 kB
Committed_AS:     7536 kB
VmallocTotal:   956416 kB
VmallocUsed:    333252 kB
VmallocChunk:   587772 kB

Thu Jan  1 00:32:03 UTC 1970
running: cat /proc/xenomai/affinity
00000001

Thu Jan  1 00:32:03 UTC 1970
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:         2033    (lostage_handler)
  2:           14    (registry_export)
  3:            0    (pse51_lostage_handler)

Thu Jan  1 00:32:03 UTC 1970
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:            0    (Data or instruction access)
  1:            0    (Section fault)
  2:            0    (Generic data abort)
  3:            0    (Unknown exception)
  4:            0    (Instruction breakpoint)
  5:         1961    (Floating point exception)
  6:            0    (VFP Floating point exception)
  7:            0    (Undefined instruction)
  8:            0    (Unaligned access exception)

Thu Jan  1 00:32:03 UTC 1970
running: cat /proc/xenomai/hal
1.9-01

Thu Jan  1 00:32:03 UTC 1970
running: cat /proc/xenomai/heap
size=129536:used=5184:pagesz=512  (main heap)
size=32256:used=0:pagesz=512  (stack pool)

Thu Jan  1 00:32:03 UTC 1970
running: cat /proc/xenomai/irq
IRQ         CPU0
 19:     4310898         [timer]
194:        3002         [virtual]

Thu Jan  1 00:32:03 UTC 1970
running: cat /proc/xenomai/latency
9645

Thu Jan  1 00:32:03 UTC 1970
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT

Thu Jan  1 00:32:04 UTC 1970
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          4136456    0     00500080   67.8  ROOT
  0  0      0          4310930    0     00000000    7.0  IRQ19: [timer]

Thu Jan  1 00:32:04 UTC 1970
running: cat /proc/xenomai/timebases
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled,set

Thu Jan  1 00:32:04 UTC 1970
running: cat /proc/xenomai/timer
status=on:setup=321:clock=5985537718:timerdev=at91_tc0:clockdev=at91_tc0

Thu Jan  1 00:32:04 UTC 1970
running: cat /proc/xenomai/version
2.4.3

Thu Jan  1 00:32:04 UTC 1970
running: cat /proc/xenomai/interfaces/native
0

Thu Jan  1 00:32:04 UTC 1970
running: cat /proc/xenomai/interfaces/posix
0

Thu Jan  1 00:32:04 UTC 1970
running: cat /proc/xenomai/interfaces/rtdm
0

Thu Jan  1 00:32:04 UTC 1970
running: cat /proc/xenomai/interfaces/sys
0

Thu Jan  1 00:32:04 UTC 1970
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Thu Jan  1 00:32:05 UTC 1970
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				Driver		/proc

Thu Jan  1 00:32:05 UTC 1970
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device		Owner [PID]

Thu Jan  1 00:32:05 UTC 1970
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Thu Jan  1 00:32:05 UTC 1970
running: cat /proc/xenomai/timerstat/master
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           
0    192489      192488      7134452    10000000   NULL         [host-timer]   

Thu Jan  1 00:32:05 UTC 1970
running: top
[H[JMem: 11764K used, 49512K free, 0K shrd, 0K buff, 6204K cached
CPU:  33% usr  66% sys   0% nice   0% idle   0% io   0% irq   0% softirq
Load average: 2.31 2.09 1.77
[7m  PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND[0m
 1234     1 root     R     2780   5%  47% dd if=/dev/zero of=/dev/null 
 1500     1 root     R     2780   5%  40% dd if=/dev/zero of=/dev/null 
 2129  2128 root     R     2852   5%  13% top 
  371     1 root     S     3708   6%   0% /usr/sbin/sshd 
  376     1 root     S     3172   5%   0% -sh 
 2127  1425 root     S     2860   5%   0% head -n 13 
 1500 root     dd if=/dev/zero of=/dev/null 
 2133 root     grep 1500 
xeno-test: finished

--------------000901070708080505020005--

