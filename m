From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Wed, 5 Dec 2007 07:41:16 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MgkVHBLyilCUjl/"
Message-Id: <200712050741.16685.niklaus.giger@domain.hid>
Subject: [Xenomai-help] Problems running xenomai on Yosemite PPC440 board
Reply-To: niklaus.giger@domain.hid
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

--Boundary-00=_MgkVHBLyilCUjl/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I built a xenomai kernel and the xenomai tools using a checkout of the trunk 
like this
cd /home/hcu/celsius/linux-2.6-xenomai
/home/hcu/celsius/xenomai-trunk/scripts/prepare-kernel.sh --linux=/home/hcu/celsius/linux-2.6-xenomai --adeos=/home/hcu/celsius/xenomai-trunk/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.23-ppc-1.6-00.patch --arch=ppc
make  ARCH=ppc CROSS_COMPILE=ppc_4xx- 
O=/home/hcu/celsius/build-linux-yosemite-ppc-DENX-v2.6.23.1 
yosemite_defconfig
make  ARCH=ppc CROSS_COMPILE=ppc_4xx- 
O=/home/hcu/celsius/build-linux-yosemite-ppc-DENX-v2.6.23.1 uImage modules
sudo make  ARCH=ppc CROSS_COMPILE=ppc_4xx- 
O=/home/hcu/celsius/build-linux-yosemite-ppc-DENX-v2.6.23.1 
PATH=$/usr/local/bin:/opt/eldk/4_1/usr/bin:/usr/bin:/bin 
INSTALL_MOD_PATH=/opt/eldk/4_1/ppc_4xxFP modules_install
sudo 
cp -v /home/hcu/celsius/build-linux-yosemite-ppc-DENX-v2.6.23.1/arch/ppc/boot/images/uImage /tftpboot/buildbot/uImage-yosemite
sudo 
cp -v /home/hcu/celsius/build-linux-yosemite-ppc-DENX-v2.6.23.1/arch/ppc/boot/images/uImage /tftpboot/yosemite/uImage
cd /home/hcu/celsius/build-linux-yosemite-ppc-DENX-v2.6.23.1
/home/hcu/celsius/xenomai-trunk/configure --build=i686-linux --host=ppc 
CC=ppc_4xx-gcc CXX=ppc_4xx-g++ LD=ppc_4xx-ld
make
sudo make  PATH=/usr/local/bin:/opt/eldk/4_1/usr/bin:/usr/bin:/bin  
DESTDIR=/opt/eldk/4_1/ppc_4xxFP install
cd /home/hcu/celsius

It booted a NFS (ELDK 4.1) rootfs with no problem. Enabled telnet and could
log in via network. Copied /bin/which from  my Debian box to the rootfs.

I spotted three points, which I could not explain with my (somehow outdated) 
know-how about Xenomai.

First: Are results like this in the latency test of xeno-test okay?

RTT|  00:01:04  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|     0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|     0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|     0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|     0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|     0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|     0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|      0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|      0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|      0.000
(whole xeno-test.log attached)

Second: cat /proc/xenomai/interfaces/vxworks returns 0 even if I have a
CONFIG_XENO_SKIN_VXWORKS=y in my .config. (attached)

Third. A custom C++-testsuite which exercises some vxWorks  calls produces a 
kernel exception:
Kernel BUG at c0042d78 [verbose debug info unavailable]
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: c0042d78 LR: c00a2784 CTR: 0fd19900
REGS: cefe9bc0 TRAP: 0700   Not tainted  (2.6.23.1-g25dc8c8a-dirty)
MSR: 00029000 <EE,ME>  CR: 44224044  XER: 20000000
TASK = cfeda420[1111] 'root' THREAD: cefe8000
GPR00: 00001560 cefe9c70 cfeda420 00000001 00000000 0000027c 00000000 00000001
GPR08: c030d300 0000155f c0562eb8 00000001 24202048 101af840 00000000 100c7238
GPR16: 00000000 c030d6c0 00000000 00020020 00000000 00000044 c037e514 00000001
GPR24: 00000000 00000001 c030b2a0 c030d2dc 00000000 00000000 c030d2f4 c0562ec0
NIP [c0042d78] __ipipe_restore_root+0x1c/0x4c
LR [c00a2784] get_page_from_freelist+0x1b8/0x3d0
Call Trace:
[cefe9c70] [c03651a4] 0xc03651a4 (unreliable)
[cefe9cc0] [c00a2a04] __alloc_pages+0x68/0x2f0
[cefe9d10] [c00bbd34] cache_alloc_refill+0x38c/0x61c
[cefe9d50] [c00bb9a0] kmem_cache_alloc+0xb0/0xb8
[cefe9d70] [c00253a8] __sigqueue_alloc+0x44/0xbc
[cefe9d80] [c0025a98] send_signal+0x108/0x194
[cefe9da0] [c0025c80] specific_send_sig_info+0x80/0xf0
[cefe9dc0] [c0027218] force_sig_info+0xb4/0x11c
[cefe9de0] [c0002a6c] _exception+0x4c/0x100
[cefe9e80] [c000afe0] do_page_fault+0xb4/0x408
[cefe9f40] [c0001f40] handle_page_fault+0xc/0x80
Instruction dump:
38210010 7c0803a6 4e800020 4bfff1e1 4bffffe8 3d60c032 800b4e70 3d20c036
392944c0 7c004a78 3120ffff 7d690110 <0f0b0000> 2f830000 3d60c031 392bb2a0

If I let it run under gdb I get
 Oops: kernel access of bad area, sig: 11 [#1]
NIP: c0000ef0 LR: 30004090 CTR: 00000000
REGS: 7ff3bee0 TRAP: 0300   Not tainted  (2.6.23.1-g25dc8c8a-dirty)
MSR: 00001000 <ME>  CR: 22000024  XER: 00000000
DEAR: 7ff3c038, ESR: 00800000
TASK = cf773810[260] 'TSysMain' THREAD: ce6ea000
GPR00: 00000001 7ff3bf90 30023fe0 3001cfe0 00000000 00000000 00000000 300121b4
GPR08: 0002f900 00000003 22000024 7ff3bf90 28000024 00000000 00000000 00000000
GPR16: 00000000 3001cfe0 00000001 00000000 00000000 7ff3b6a8 00000008 10000034
GPR24: 00000000 6fffff40 30017000 30027f54 00000000 00000000 300272e4 7ff3b620
NIP [c0000ef0] data_access+0x38/0xbc
LR [30004090] 0x30004090
Call Trace:
Instruction dump:
7c3443a6 7d400026 7d7b02a6 716b4000 41820018 7c3342a6 8021fe1c 3d600000
616b2000 7c215a14 3821ff40 7c2b0b78 <914b00a8> 918b0040 912b0034 7d5042a6
Oops: kernel access of bad area, sig: 11 [#2]
NIP: c0000ef0 LR: c00af880 CTR: c01847dc
REGS: ff102f10 TRAP: 0300   Tainted: G      D  (2.6.23.1-g25dc8c8a-dirty)
MSR: 00021000 <ME>  CR: 22004028  XER: 20000000
DEAR: ff102fa8, ESR: 00800000
TASK = cf773810[260] 'TSysMain' THREAD: ce6ea000
GPR00: c00af880 22004082 cf773810 cf1c6710 c0320000 0000003e c030d2f4 c0591b98
GPR08: 00000000 c0358bc8 22004028 ff102f00 22004082 00000000 00000000 00000000
GPR16: 00000000 3001cfe0 00000001 00000000 00000000 7ff3b6a8 00000008 10000034
GPR24: 00000000 c0310000 30017000 30027f54 c0310000 00000000 c034fba0 cf1c6710
NIP [c0000ef0] data_access+0x38/0xbc
LR [c00af880] exit_mmap+0xb4/0xec
Call Trace:
Instruction dump:
7c3443a6 7d400026 7d7b02a6 716b4000 41820018 7c3342a6 8021fe1c 3d600000
616b2000 7c215a14 3821ff40 7c2b0b78 <914b00a8> 918b0040 912b0034 7d5042a6
Fixing recursive fault but reboot is needed!

Any hints?

Best regards
-- 
Niklaus Giger

--Boundary-00=_MgkVHBLyilCUjl/
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="xeno-test.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno-test.log"

xeno-test: started 
withBusybox is 0
xeno-test: running tests

Thu Jan  1 00:01:05 UTC 1970
running: ./xeno-config --verbose
xeno-config --verbose
    --version="2.3.96"
    --cc="ppc_4xx-gcc"
    --arch="powerpc"
    --prefix="/usr/xenomai"
    --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
    --xeno-ldflags="-L/usr/xenomai/lib -lpthread "
    --posix-cflags="-I/usr/xenomai/include -I/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
    --posix-ldflags="-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
    --library-dir="/usr/xenomai/lib"

Thu Jan  1 00:01:05 UTC 1970
running: ./xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux yosemite 2.6.23.1-g25dc8c8a-dirty #2 Tue Dec 4 22:31:03 CET 2007 ppc ppc ppc GNU/Linux
 
Gnu C                  4.0.0
Gnu make               3.80
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.38
pcmcia-cs              3.2.8
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    89:
Sh-utils               5.2.1
Modules Loaded         

Thu Jan  1 00:01:06 UTC 1970
running: cat /proc/cpuinfo
processor	: 0
cpu		: 440EP Rev. C
revision	: 24.212 (pvr 4222 18d4)
bogomips	: 798.72
vendor		: AMCC
machine		: PPC440EP Yosemite

Thu Jan  1 00:01:06 UTC 1970
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
5aeb44e8d6f3422071513438cfa2410d  /proc/cpuinfo

Thu Jan  1 00:01:06 UTC 1970
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
  64:  A...V
  65:  G...V
  66:  G...V
[Domain info]
id=0x00000000
priority=100

Thu Jan  1 00:01:06 UTC 1970
running: cat /proc/ipipe/Xenomai
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
  64:  W..XV
  67:  W...V
[Domain info]
id=0x58454e4f
priority=topmost

Thu Jan  1 00:01:06 UTC 1970
running: cat /proc/ipipe/version
1.6-00

Thu Jan  1 00:01:06 UTC 1970
running: generate_loads 1
dd workload started, pids 396 stored in /var/lock/xeno-test.263.pids

Thu Jan  1 00:01:06 UTC 1970
running: cat /proc/interrupts
           CPU0       
  0:        107  UIC0 Edge      serial
 10:       7391  UIC0 Edge      MAL TX EOB
 11:      13467  UIC0 Edge      MAL RX EOB
 32:          0  UIC1 Edge      MAL SERR
 33:          0  UIC1 Edge      MAL TX DE
 34:          0  UIC1 Edge      MAL RX DE
 40:          1  UIC1 Edge      ohci_hcd:usb1
 55:          0  UIC1 Edge      musbhsfc_udc
 60:          0  UIC1 Edge      EMAC
BAD:          0

Thu Jan  1 00:01:06 UTC 1970
running: cat /proc/loadavg
0.03 0.01 0.00 2/31 402

Thu Jan  1 00:01:06 UTC 1970
running: cat /proc/meminfo
MemTotal:       256376 kB
MemFree:        236532 kB
Buffers:             0 kB
Cached:          14184 kB
SwapCached:          0 kB
Active:           7164 kB
Inactive:         9080 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               8 kB
Writeback:           0 kB
AnonPages:        2072 kB
Mapped:           2200 kB
Slab:             2216 kB
SReclaimable:      500 kB
SUnreclaim:       1716 kB
PageTables:        284 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:    128188 kB
Committed_AS:     5460 kB
VmallocTotal:   737200 kB
VmallocUsed:     65984 kB
VmallocChunk:   671148 kB

Thu Jan  1 00:01:06 UTC 1970
running: cat /proc/xenomai/affinity
00000001

Thu Jan  1 00:01:06 UTC 1970
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:            0    (lostage_handler)
  2:            2    (registry_export)
  3:            0    (posix_signals_handler)

Thu Jan  1 00:01:06 UTC 1970
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:            0    (Data or instruction access)
  1:            0    (Alignment)
  2:            0    (Altivec unavailable)
  3:            0    (Program check exception)
  4:            0    (Machine check exception)
  5:            0    (Unknown)
  6:            0    (Instruction breakpoint)
  7:            0    (Run mode exception)
  8:            0    (Single-step exception)
  9:            0    (Non-recoverable exception)
 10:            0    (Software emulation)
 11:            0    (Debug)
 12:            0    (SPE)
 13:            0    (Altivec assist)
 14:            0    (Cache-locking exception)
 15:            0    (Kernel FP unavailable)

Thu Jan  1 00:01:06 UTC 1970
running: cat /proc/xenomai/hal
1.6-00

Thu Jan  1 00:01:06 UTC 1970
running: cat /proc/xenomai/heap
size=129536:used=49952:pagesz=512

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/irq
IRQ         CPU0
 64:      276405         [virtual]
 67:           0         [virtual]

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/latency
4001

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          0          0     00500080   99.5  ROOT
  0  0      0          276775     0     00000000    0.4  IRQ64: [timer]

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/timebases
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled,set
psos          1000000       65204   disabled,unset,isolated
vrtx          1000000       65167   disabled,unset,isolated
vxworks       1000000       65131   disabled,unset,isolated
uitron        1000000       65093   disabled,unset,isolated

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/timer
status=on:setup=1:clock=35824057231:timerdev=decrementer:clockdev=timebase

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/version
2.4-rc7

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/interfaces/native
0

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/interfaces/posix
0

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/interfaces/psos
0

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/interfaces/rtai
0

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/interfaces/rtdm
0

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/interfaces/sys
0

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/interfaces/uitron
0

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/interfaces/vrtx
0

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/interfaces/vxworks
0

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				Driver		/proc

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device		Owner [PID]

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/timerstat/master
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           
0    16449       16448       1464943    4000000    NULL         [host-timer]   
0    65681       65680       696783     1000000    xntimer_tic  psos           
0    65644       65643       481228     1000000    xntimer_tic  vrtx           
0    65608       65607       212165     1000000    xntimer_tic  vxworks        
0    65570       65569       942834     1000000    xntimer_tic  uitron         

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/timerstat/psos
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/timerstat/uitron
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/timerstat/vrtx
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:01:07 UTC 1970
running: cat /proc/xenomai/timerstat/vxworks
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:01:07 UTC 1970
running: top -bn1c
top - 00:01:08 up 1 min,  1 user,  load average: 0.03, 0.01, 0.00
Tasks:  33 total,   2 running,  31 sleeping,   0 stopped,   0 zombie
Cpu(s):  3.9% us, 11.9% sy,  0.0% ni, 75.4% id,  8.4% wa,  0.0% hi,  0.3% si
Mem:    256376k total,    20580k used,   235796k free,        0k buffers
Swap:        0k total,        0k used,        0k free,    14416k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
  396 root      20   0  1640  424  344 R 92.1  0.2   0:01.02 dd if /dev/zero of 
  500 root      20   0  2648 1064  852 R  3.8  0.4   0:00.04 top -bn1c          
    1 root      20   0  1636  572  496 S  0.0  0.2   0:04.18 init [3]           

Thu Jan  1 00:01:08 UTC 1970
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
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTT|  00:00:43  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTT|  00:01:04  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|-1511828488|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTT|  00:01:25  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTT|  00:01:46  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
RTD|       0.000|       0.000|       0.000|1546188227|       0.000|       0.000
---|--param|----range-|--samples
HSD|    min|   0 -  1 |      118
HSD|    min|   1 -  2 |        1
---|--param|----range-|--samples
HSD|    avg|   0 -  1 |  1187849
HSD|    avg|   1 -  2 |     9688
HSD|    avg|   2 -  3 |      188
HSD|    avg|   3 -  4 |      132
HSD|    avg|   4 -  5 |      117
HSD|    avg|   5 -  6 |      137
HSD|    avg|   6 -  7 |      139
HSD|    avg|   7 -  8 |      150
HSD|    avg|   8 -  9 |      179
HSD|    avg|   9 - 10 |      168
HSD|    avg|  10 - 11 |      166
HSD|    avg|  11 - 12 |      164
HSD|    avg|  12 - 13 |      114
HSD|    avg|  13 - 14 |       80
HSD|    avg|  14 - 15 |       56
HSD|    avg|  15 - 16 |       39
HSD|    avg|  16 - 17 |       22
HSD|    avg|  17 - 18 |       15
HSD|    avg|  18 - 19 |        7
HSD|    avg|  19 - 20 |        6
HSD|    avg|  20 - 21 |        1
HSD|    avg|  21 - 22 |        1
HSD|    avg|  22 - 23 |        2
HSD|    avg|  25 - 26 |        1
---|--param|----range-|--samples
HSD|    max|   3 -  4 |        1
HSD|    max|  11 - 12 |        3
HSD|    max|  12 - 13 |       17
HSD|    max|  13 - 14 |       21
HSD|    max|  14 - 15 |       15
HSD|    max|  15 - 16 |       23
HSD|    max|  16 - 17 |       13
HSD|    max|  17 - 18 |       12
HSD|    max|  18 - 19 |        5
HSD|    max|  19 - 20 |        4
HSD|    max|  20 - 21 |        1
HSD|    max|  21 - 22 |        1
HSD|    max|  22 - 23 |        2
HSD|    max|  25 - 26 |        1
HSH|--param|--samples-|--average--|---stddev--
HSS|    min|       119|      0.000| 3175908651355815125599261204411294392596309645823252351904167261919002896952398285912102357387275473649507671227276729259128079242528228546532798584810548587498859790284991267172592800784805674273437621407769308790973579763654404268249102816161422417299958251338372562078714747120141390131298006018121793536.000
HSS|    avg|   1199421|      0.000| 3175908651355815125599261204411294392596309645823252351904167261919002896952398285912102357387275473649507671227276729259128079242528228546532798584810548587498859790284991267172592800784805674273437621407769308790973579763654404268249102816161422417299958251338372562078714747120141390131298006018121793536.000
HSS|    max|       119|      0.000| 3176081427626195898258940792301719156108610438228336999620438818750712974339535736661436648464996181372081444782421569853323486842452479521613968407455367576544949445758507438392805573055495535150442856508231877409687301689336824101717412312496135532168130175734110545893152791048992119179209539567390556160.000
---|------------|------------|------------|--------|-------------------------
RTS|       0.000|3176252869003385617836483234705801883852560999769531234022838527963682281452564470678872939486922391868691712644110165205752400635603069740620712032569777537177778095471311026202031331962706883843141791034889979220421929878876969098207461378607050542280132275760903672985972873047131408339303541738278223872.000|   25635.000|       0|    -1074447516:1511828488:-1075830588/-1683627180:1077518991:1546188227

Thu Jan  1 00:03:10 UTC 1970
running: ./run -- -sh -T 120 -t1 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)

Thu Jan  1 00:03:10 UTC 1970
running: ./run -- -sh -T 120 -t2 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel timer handler
== All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)

Thu Jan  1 00:03:11 UTC 1970
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
r8: 1 != 2
r9: 1 != 2
r10: 1 != 2
r11: 1 != 2
r12: 1 != 2
r13: 1 != 2
r14: 1 != 2
r15: 1 != 2
r16: 1 != 2
r17: 1 != 2
r18: 1 != 2
r19: 1 != 2
r20: 1 != 2
r21: 1 != 2
r22: 1 != 2
r23: 1 != 2
r24: 1 != 2
r25: 1 != 2
r26: 1 != 2
r27: 1 != 2
r28: 1 != 2
r29: 1 != 2
r30: 1 != 2
r31: 1 != 2
== FPU check routines: OK.
switchtest: Unable to open switchtest device.
(modprobe xeno_switchtest ?)
== Threads:
Thu Jan  1 00:03:12 UTC 1970
running: ./run -- -h # switchbench
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|       0.000|       0.000|       0.000|4617296377663184699
---|---range-|---samples
HSD| 4 - 5 |      96475
HSD| 5 - 6 |        641
HSD| 6 - 7 |       2841
HSD| 7 - 8 |         10
HSD| 8 - 9 |          8
HSD| 9 - 10 |          8
HSD| 10 - 11 |          3
HSD| 11 - 12 |          2
HSD| 12 - 13 |          6
HSD| 15 - 16 |          1
HSD| 19 - 20 |          1
HSS|     99996|      0.000|      0.000

Thu Jan  1 00:03:22 UTC 1970
running: ./run -- -p 10 -n -l 1000 # cyclictest
*
*
* Type ^C to stop this application.
*
*
0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:       0 Min: 1000000 Act:       0 Avg:       0 Max:-1000000
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:      10 Min:      -1 Act:      -1 Avg:       1 Max:      22
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:      26 Min:      -1 Act:      -1 Avg:       0 Max:      22
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:      42 Min:      -1 Act:      -1 Avg:       0 Max:      22
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:      58 Min:      -1 Act:      -1 Avg:       0 Max:      22
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:      74 Min:      -1 Act:       0 Avg:       0 Max:      22
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:      90 Min:      -1 Act:      -1 Avg:       0 Max:      22
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     106 Min:      -1 Act:      -1 Avg:       0 Max:      22
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     122 Min:      -1 Act:      -1 Avg:       0 Max:      22
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     138 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     154 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     170 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     186 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     202 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     218 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     234 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     250 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     266 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     282 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     298 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     314 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     330 Min:      -1 Act:       0 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     346 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     362 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 3/36 993          

T: 0 (  993) P:10 I:    1000 C:     378 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     394 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     410 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     426 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     442 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     458 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     474 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     490 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     506 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     522 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     538 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     554 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     570 Min:      -1 Act:       0 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     586 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     602 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     618 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     634 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     650 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     666 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     682 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     698 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     714 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     730 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     746 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     762 Min:      -1 Act:       0 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     778 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     794 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     810 Min:      -1 Act:       0 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     826 Min:      -1 Act:       0 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     842 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     858 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.89 0.37 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     874 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.90 0.38 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     890 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.90 0.38 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     906 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.90 0.38 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     922 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.90 0.38 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     938 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.90 0.38 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     954 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.90 0.38 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     970 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.90 0.38 0.13 2/36 993          

T: 0 (  993) P:10 I:    1000 C:     986 Min:      -1 Act:      -1 Avg:       0 Max:      24
[3A0.90 0.38 0.13 2/35 993          

T: 0 (  993) P:10 I:    1000 C:    1000 Min:      -1 Act:      -1 Avg:       0 Max:      24

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/interrupts
           CPU0       
  0:        107  UIC0 Edge      serial
 10:       9730  UIC0 Edge      MAL TX EOB
 11:      16114  UIC0 Edge      MAL RX EOB
 32:          0  UIC1 Edge      MAL SERR
 33:          0  UIC1 Edge      MAL TX DE
 34:          0  UIC1 Edge      MAL RX DE
 40:          1  UIC1 Edge      ohci_hcd:usb1
 55:          0  UIC1 Edge      musbhsfc_udc
 60:          0  UIC1 Edge      EMAC
BAD:          0

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/loadavg
0.90 0.38 0.13 2/31 1005

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/meminfo
MemTotal:       256376 kB
MemFree:        235508 kB
Buffers:             0 kB
Cached:          15032 kB
SwapCached:          0 kB
Active:           8416 kB
Inactive:         8692 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:              40 kB
Writeback:           0 kB
AnonPages:        2088 kB
Mapped:           2200 kB
Slab:             2284 kB
SReclaimable:      584 kB
SUnreclaim:       1700 kB
PageTables:        284 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:    128188 kB
Committed_AS:     5460 kB
VmallocTotal:   737200 kB
VmallocUsed:     65984 kB
VmallocChunk:   671148 kB

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/affinity
00000001

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:          133    (lostage_handler)
  2:            6    (registry_export)
  3:            0    (posix_signals_handler)

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:            0    (Data or instruction access)
  1:            0    (Alignment)
  2:            0    (Altivec unavailable)
  3:            0    (Program check exception)
  4:            0    (Machine check exception)
  5:            0    (Unknown)
  6:            0    (Instruction breakpoint)
  7:            0    (Run mode exception)
  8:            0    (Single-step exception)
  9:            0    (Non-recoverable exception)
 10:            0    (Software emulation)
 11:            0    (Debug)
 12:            0    (SPE)
 13:            0    (Altivec assist)
 14:            0    (Cache-locking exception)
 15:            0    (Kernel FP unavailable)

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/hal
1.6-00

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/heap
size=129536:used=54048:pagesz=512

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/irq
IRQ         CPU0
 64:     2165504         [virtual]
 67:         139         [virtual]

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/latency
4001

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          1310539    0     00500080   94.2  ROOT
  0  0      0          2165869    0     00000000    1.5  IRQ64: [timer]

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/timebases
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled,set
psos          1000000      203763   disabled,unset,isolated
vrtx          1000000      203727   disabled,unset,isolated
vxworks       1000000      203691   disabled,unset,isolated
uitron        1000000      203652   disabled,unset,isolated

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/timer
status=on:setup=1:clock=109721869419:timerdev=decrementer:clockdev=timebase

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/version
2.4-rc7

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/interfaces/native
0

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/interfaces/posix
0

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/interfaces/psos
0

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/interfaces/rtai
0

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/interfaces/rtdm
0

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/interfaces/sys
0

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/interfaces/uitron
0

Thu Jan  1 00:03:25 UTC 1970
running: cat /proc/xenomai/interfaces/vrtx
0

Thu Jan  1 00:03:26 UTC 1970
running: cat /proc/xenomai/interfaces/vxworks
0

Thu Jan  1 00:03:26 UTC 1970
running: cat /proc/xenomai/rtdm/fildes
total=128:open=0:free=128

Thu Jan  1 00:03:26 UTC 1970
running: cat /proc/xenomai/rtdm/named_devices
Hash	Name				Driver		/proc

Thu Jan  1 00:03:26 UTC 1970
running: cat /proc/xenomai/rtdm/open_fildes
Index	Locked	Device		Owner [PID]

Thu Jan  1 00:03:26 UTC 1970
running: cat /proc/xenomai/rtdm/protocol_devices
Hash	ProtocolFamily:SocketType	Driver		/proc

Thu Jan  1 00:03:26 UTC 1970
running: cat /proc/xenomai/timerstat/master
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           
0    51091       51090       1484972    4000000    NULL         [host-timer]   
0    204249      204248      651676     1000000    xntimer_tic  psos           
0    204212      204211      436100     1000000    xntimer_tic  vrtx           
0    204176      204175      166955     1000000    xntimer_tic  vxworks        
0    204138      204137      897618     1000000    xntimer_tic  uitron         

Thu Jan  1 00:03:26 UTC 1970
running: cat /proc/xenomai/timerstat/psos
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:03:26 UTC 1970
running: cat /proc/xenomai/timerstat/uitron
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:03:26 UTC 1970
running: cat /proc/xenomai/timerstat/vrtx
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:03:26 UTC 1970
running: cat /proc/xenomai/timerstat/vxworks
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME           

Thu Jan  1 00:03:26 UTC 1970
running: top -bn1c
top - 00:03:26 up 3 min,  1 user,  load average: 0.90, 0.38, 0.13
Tasks:  33 total,   2 running,  31 sleeping,   0 stopped,   0 zombie
Cpu(s): 26.2% us, 45.9% sy,  0.0% ni, 25.0% id,  2.8% wa,  0.0% hi,  0.1% si
Mem:    256376k total,    21228k used,   235148k free,        0k buffers
Swap:        0k total,        0k used,        0k free,    15040k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
  396 root      20   0  1640  424  344 R 94.1  0.2   2:16.08 dd if /dev/zero of 
 1103 root      20   0  2648 1064  852 R  3.8  0.4   0:00.04 top -bn1c          
    1 root      20   0  1636  572  496 S  0.0  0.2   0:04.20 init [3]           
  396 ttyp0    00:02:16 dd
xeno-test: finished

--Boundary-00=_MgkVHBLyilCUjl/
Content-Type: text/plain;
  charset="iso-8859-1";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.23.1
# Tue Dec  4 22:29:24 2007
#
CONFIG_MMU=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_ARCH_HAS_ILOG2_U32=y
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_GENERIC_NVRAM=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_BUG=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_USER_NS is not set
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_SYSFS_DEPRECATED=y
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_EMBEDDED=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
# CONFIG_HOTPLUG is not set
CONFIG_PRINTK=y
# CONFIG_LOGBUFFER is not set
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_ANON_INODES=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_BLOCK=y
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set
# CONFIG_BLK_DEV_BSG is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Real-time sub-system
#
CONFIG_XENOMAI=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_PRIOCPL=y
CONFIG_XENO_OPT_PIPELINE_HEAD=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_MAP=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY=y
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=128
CONFIG_XENO_OPT_STATS=y
# CONFIG_XENO_OPT_DEBUG is not set
# CONFIG_XENO_OPT_SHIRQ is not set

#
# Timing
#
CONFIG_XENO_OPT_TIMING_PERIODIC=y
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0

#
# Scalability
#
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=y
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set

#
# Machine
#
CONFIG_XENO_HW_FPU=y

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_PERIOD=0
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=1024
CONFIG_XENO_OPT_NATIVE_REGISTRY=y
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_SKIN_POSIX=y
CONFIG_XENO_OPT_POSIX_PERIOD=0
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
CONFIG_XENO_OPT_DEBUG_POSIX=y
CONFIG_XENO_SKIN_PSOS=y
CONFIG_XENO_OPT_PSOS_PERIOD=1000
CONFIG_XENO_SKIN_UITRON=y
CONFIG_XENO_OPT_UITRON_PERIOD=1000
CONFIG_XENO_SKIN_VRTX=y
CONFIG_XENO_OPT_VRTX_PERIOD=1000
CONFIG_XENO_SKIN_VXWORKS=y
CONFIG_XENO_OPT_VXWORKS_PERIOD=1000
CONFIG_XENO_SKIN_RTAI=y
CONFIG_XENO_OPT_RTAI_PERIOD=0
CONFIG_XENO_OPT_RTAI_FIFO=y
CONFIG_XENO_OPT_RTAI_SEM=y
CONFIG_XENO_OPT_RTAI_SHM=y
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_OPT_RTDM_PERIOD=0
CONFIG_XENO_OPT_RTDM_FILDES=128

#
# Drivers
#

#
# Serial drivers
#
# CONFIG_XENO_DRIVERS_16550A is not set

#
# Testing drivers
#
# CONFIG_XENO_DRIVERS_TIMERBENCH is not set
# CONFIG_XENO_DRIVERS_IRQBENCH is not set
# CONFIG_XENO_DRIVERS_SWITCHTEST is not set

#
# CAN drivers
#
# CONFIG_XENO_DRIVERS_CAN is not set

#
# Processor
#
# CONFIG_6xx is not set
# CONFIG_40x is not set
CONFIG_44x=y
# CONFIG_8xx is not set
# CONFIG_E200 is not set
# CONFIG_E500 is not set
CONFIG_PPC_FPU=y
CONFIG_PPC_DCR_NATIVE=y
CONFIG_PPC_DCR=y
CONFIG_BOOKE=y
CONFIG_PTE_64BIT=y
CONFIG_PHYS_64BIT=y
# CONFIG_MATH_EMULATION is not set
# CONFIG_KEXEC is not set
# CONFIG_CPU_FREQ is not set
CONFIG_4xx=y
CONFIG_WANT_EARLY_SERIAL=y

#
# IBM 4xx options
#
# CONFIG_ALPR is not set
# CONFIG_BAMBOO is not set
# CONFIG_EBONY is not set
# CONFIG_KATMAI is not set
# CONFIG_LUAN is not set
# CONFIG_LWMON5 is not set
# CONFIG_OCOTEA is not set
# CONFIG_P3P440 is not set
# CONFIG_RAINIER is not set
# CONFIG_SEQUOIA is not set
# CONFIG_TAISHAN is not set
# CONFIG_YELLOWSTONE is not set
CONFIG_YOSEMITE=y
# CONFIG_YUCCA is not set
CONFIG_440EP=y
CONFIG_440=y
CONFIG_IBM440EP_ERR42=y
CONFIG_IBM_OCP=y
# CONFIG_PPC4xx_DMA is not set
CONFIG_PPC_GEN550=y
CONFIG_NOT_COHERENT_CACHE=y

#
# Platform options
#
# CONFIG_PC_KEYBOARD is not set
CONFIG_IPIPE=y
CONFIG_IPIPE_DOMAINS=4
CONFIG_IPIPE_COMPAT=y
# CONFIG_HIGHMEM is not set
CONFIG_ARCH_POPULATES_NODE_MAP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="ip=on"
CONFIG_SECCOMP=y
CONFIG_PPC_PAGE_4K=y
# CONFIG_PPC_PAGE_16K is not set
# CONFIG_PPC_PAGE_64K is not set
# CONFIG_PPC_PAGE_256K is not set
CONFIG_ISA_DMA_API=y

#
# Bus options
#
CONFIG_ZONE_DMA=y
# CONFIG_PPC_I8259 is not set
CONFIG_PPC_INDIRECT_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_SYSCALL=y
# CONFIG_ARCH_SUPPORTS_MSI is not set
# CONFIG_PCI_DEBUG is not set

#
# PCCARD (PCMCIA/CardBus) support
#

#
# PCI Express support
#

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_TASK_SIZE=0x80000000
CONFIG_CONSISTENT_START=0xff100000
CONFIG_CONSISTENT_SIZE=0x00200000
CONFIG_BOOT_LOAD=0x01000000

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_NETLINK is not set
# CONFIG_NF_CONNTRACK_ENABLED is not set
# CONFIG_NF_CONNTRACK is not set
# CONFIG_NETFILTER_XTABLES is not set

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_QUEUE is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set

#
# Wireless
#
# CONFIG_CFG80211 is not set
# CONFIG_WIRELESS_EXT is not set
# CONFIG_MAC80211 is not set
# CONFIG_IEEE80211 is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_CONCAT is not set
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0x0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_ONENAND is not set

#
# UBI - Unsorted block images
#
# CONFIG_MTD_UBI is not set
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_XILINX_SYSACE is not set
CONFIG_MISC_DEVICES=y
# CONFIG_PHANTOM is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_IDE=y
CONFIG_IDE_MAX_HWIFS=4
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
CONFIG_IDEPCI_PCIBUS_ORDER=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SL82C105 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SRP is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_IEEE1394 is not set
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
# CONFIG_NETDEVICES_MULTIQUEUE is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ARCNET is not set
# CONFIG_PHYLIB is not set
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_IBM_EMAC=y
CONFIG_IBM_EMAC_RXB=64
CONFIG_IBM_EMAC_TXB=8
CONFIG_IBM_EMAC_POLL_WEIGHT=32
CONFIG_IBM_EMAC_RX_COPY_THRESHOLD=256
CONFIG_IBM_EMAC_RX_SKB_HEADROOM=0
# CONFIG_IBM_EMAC_PHY_RX_CLK_FIX is not set
# CONFIG_IBM_EMAC_DEBUG is not set
CONFIG_IBM_EMAC_ZMII=y
CONFIG_IBM_EMAC_NR_START=0
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_SC92031 is not set
CONFIG_NETDEV_1000=y
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set
# CONFIG_ATL1 is not set
CONFIG_NETDEV_10000=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_MLX4_CORE is not set
# CONFIG_TR is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
CONFIG_USB_PEGASUS=y
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET_MII is not set
# CONFIG_USB_USBNET is not set
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
# CONFIG_INPUT is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_IPMI_HANDLER is not set
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
# CONFIG_NVRAM is not set
# CONFIG_GEN_RTC is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=y
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1115 is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_SM501 is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
CONFIG_DAB=y
# CONFIG_USB_DABUSB is not set

#
# Graphics support
#
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set
# CONFIG_VGASTATE is not set
CONFIG_VIDEO_OUTPUT_CONTROL=m
# CONFIG_FB is not set
# CONFIG_FB_IBM_GXT4500 is not set

#
# Sound
#
# CONFIG_SOUND is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_DEVICE_CLASS=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PPC_SOC=y
CONFIG_USB_OHCI_BIG_ENDIAN_DESC=y
CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
# CONFIG_USB_OHCI_LITTLE_ENDIAN is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
CONFIG_USB_MON=y

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_BERRY_CHARGE is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_SELECTED=y
# CONFIG_USB_GADGET_AMD5536UDC is not set
# CONFIG_USB_GADGET_FSL_USB2 is not set
# CONFIG_USB_GADGET_NET2280 is not set
# CONFIG_USB_GADGET_PXA2XX is not set
# CONFIG_USB_GADGET_M66592 is not set
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_LH7A40X is not set
# CONFIG_USB_GADGET_PD12 is not set
# CONFIG_USB_GADGET_OMAP is not set
# CONFIG_USB_GADGET_S3C2410 is not set
# CONFIG_USB_GADGET_AT91 is not set
CONFIG_USB_GADGET_MUSBHSFC=y
CONFIG_USB_MUSBHSFC=y
# CONFIG_USB_GADGET_DWC_OTG is not set
# CONFIG_USB_GADGET_DUMMY_HCD is not set
CONFIG_USB_GADGET_DUALSPEED=y
# CONFIG_USB_ZERO is not set
CONFIG_USB_ETH=y
CONFIG_USB_ETH_RNDIS=y
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FILE_STORAGE is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_MMC is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_INFINIBAND is not set
# CONFIG_EDAC is not set
# CONFIG_RTC_CLASS is not set

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# Userspace I/O
#
# CONFIG_UIO is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4DEV_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
# CONFIG_TMPFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_YAFFS_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
CONFIG_CRAMFS=y
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_BIND34 is not set
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_PLIST=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_IPIPE_DEBUG is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_BUGVERBOSE is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
CONFIG_FORCED_INLINING=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_KGDB is not set
# CONFIG_XMON is not set
CONFIG_BDI_SWITCH=y
# CONFIG_SERIAL_TEXT_DEBUG is not set
CONFIG_PPC_OCP=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_CRYPTO is not set

--Boundary-00=_MgkVHBLyilCUjl/--

