Message-ID: <8b216e9e0812180831n6ebf4ff1gcb990864ba112eab@domain.hid>
Date: Thu, 18 Dec 2008 14:31:42 -0200
From: "=?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?=" <cavalkaf@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14791_16263985.1229617902158"
Subject: [Xenomai-help] Xenomai on Gumstix (ARM XScale PXA270)
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

------=_Part_14791_16263985.1229617902158
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I am currently trying to get Xenomai running on the gumstix plataform (
http://www.gumstix.com/), which is a *very* small linux board based on the
PXA270 ARM XScale (I am using a Verdex board). However, I did run into a fe=
w
problems during the procedure (the user space portion locks up!)

I followed the instructions on the README file, and patched the kernel with
the proper Adeos patch using the command:
./prepare-kernel.sh
--linux=3D/home/felipe/gumstix/gumstix-oe/tmp/work/gumstix-custom-verdex-an=
gstrom-linux-gnueabi/gumstix-kernel-2.6.24-r1/linux-2.6.24/
--adeos=3D/home/felipe/gumstix/adeos-ipipe-2.6.24-arm-1.9-01.patch --arch=
=3Darm

I did the standart kernel configuration procedure afterwards, and did
configure the Xenomai options. The kernel did boot fine, and I can confirm
that Adeos is running (I have /proc/xenomai and some messages during the
boot process).

My problem is with the user space portion of Xenomai. I compiled it using
the usual cross-compiling procedure:
./configure --enable-arm-mach=3Dpxa3xx --host=3Darm-linux
make
make install
However, the "make install" command runs on a fakeroot, than gets packaged
and transfered to the embedded plataform (the Gumstix). Basically, the
package contains the stuff on /dev and on /usr/xenomai.

Basically, when I try to run xeno-test, the whole systems locks up (I have
to hard-reset) when it gets to the latency test.
When I run ./latency, it also freezes up.

However, when I try ./latency -t 1 and ./latency -t 2 (testing the kernel
latency, IIRC), it runs fine. My guess is that the problems is with the
user-space instalation procedure (somehow it is not being correctly
installed?).

My other question is regarding the latencies I should be getting (they do
seem quite high.) Here is the output from my latency tests:
root@domain.hid$ ./latency -t 2
=3D=3D Sampling period: 100 us
=3D=3D Test mode: in-kernel timer handler
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel timer handler, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|       0.307|       0.925|      10.153|       0|       0.307|
10.153
RTD|       0.613|       0.988|     145.229|       1|       0.307|
145.229
RTD|      -3.695|       0.962|      78.767|       1|      -3.695|
145.229
RTD|       0.612|       0.969|      80.920|       1|      -3.695|
145.229
RTD|      -4.003|       0.962|      77.535|       1|      -4.003|
145.229
=16RTD|      -1.850|       0.970|      80.919|       1|      -4.003|
145.229
---|------------|------------|------------|--------|-----------------------=
--
RTS|      -4.003|       0.962|     145.229|       1|    00:00:08/00:00:08
root@domain.hid$ ./latency -t 1
=3D=3D Sampling period: 100 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|       4.921|       8.581|      23.383|       0|       4.921|
23.383
RTD|       4.921|       8.662|     135.998|       5|       4.921|
135.998
RTD|       4.920|       8.692|     173.228|       9|       4.920|
173.228
RTD|       4.919|       8.658|     173.843|      12|       4.919|
173.843
RTD|       4.919|       8.640|     171.689|      15|       4.919|
173.843
RTD|       4.918|       8.676|     171.380|      21|       4.918|
173.843
RTD|       4.917|       8.642|     171.379|      24|       4.917|
173.843
RTD|       4.916|       8.684|     174.763|      29|       4.916|
174.763
RTD|       4.916|       8.640|     175.070|      32|       4.916|
175.070
RTD|       4.915|       8.651|     169.839|      36|       4.915|
175.070
RTD|       4.914|       8.638|     172.915|      39|       4.914|
175.070
RTD|       4.914|       8.702|     170.145|      47|
4.914---|------------|------------|------------|--------|------------------=
-------
RTS|       4.914|       8.655|     175.070|      47|    00:00:12/00:00:12

The worst latency seem to be arround 175, which is not very good (comparing
it to an X86 processor). Is this normal or is there some kernel
configuration option which I can use to improve on this? (I am running it
with a farly custom config file, so some undeserible options might be
enabled).

BTW, for the curious, I am using this in order to control a humanoid robot
(Bioloid) - I am doing research on humanoid robots, and the idea is to use
embedded linux for the control portion of the project. I am a student at th=
e
LARA research lab in the University of Bras=EDlia, Brazil.

Thank you very much for any help,
            -Felipe B Cavalcanti
            LARA - Laboratory of Robotics and Automation
            UnB - University of Bras=EDlia, Brazil

PS: Here is the full output of xeno-test:
root@domain.hid$ ./xeno-test
xeno-test: started
withBusybox is 1
xeno-test: running tests

Thu Jan  1 00:11:36 UTC 1970
running: ./xeno-config --verbose
xeno-config --verbose
        --version=3D"2.4.6.1"
        --cc=3D"arm-angstrom-linux-gnueabi-gcc -march=3Darmv5te -mtune=3Dxs=
cale"
        --arch=3D"arm"
        --prefix=3D"/usr/xenomai"
        --xeno-cflags=3D"-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-D__XENO__"
        --xeno-ldflags=3D"-L/usr/xenomai/lib -lpthread "
        --posix-cflags=3D"-I/usr/xenomai/include -I/usr/xenomai/include/pos=
ix
-D_GNU_SOURCE -D_REENTRANT -D__XENO__"
        --posix-ldflags=3D"-Wl,@/usr/xenomai/lib/posix.wrappers
-L/usr/xenomai/lib -lpthread_rt -lpthread -lrt "
        --library-dir=3D"/usr/xenomai/lib"

Thu Jan  1 00:11:37 UTC 1970
running: ./xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

BusyBox v1.2.1 (2008.11.24-12:06+0000) multi-call binary
Linux gumstix-custom-verdex 2.6.24 #1 Tue Dec 16 16:27:25 BRST 2008 armv5te=
l
unknown

*** glibc detected *** which: free(): invalid next size (fast): 0x000c4078
***
Aborted
*** glibc detected *** which: free(): invalid next size (fast): 0x000c4078
***
Aborted
module-init-tools      3.2.2
*** glibc detected *** which: free(): invalid next size (fast): 0x000c4078
***
Aborted
Modules Loaded         i2c_dev i2c_pxa i2c_core sd_mod scsi_mod proc_gpio
ohci_hcd usbcore

Thu Jan  1 00:11:38 UTC 1970
running: cat /proc/cpuinfo
Processor    : XScale-PXA270 rev 7 (v5l)
BogoMIPS    : 622.59
Features    : swp half thumb fastmult edsp iwmmxt
CPU implementer    : 0x69
CPU architecture: 5TE
CPU variant    : 0x0
CPU part    : 0x411
CPU revision    : 7
Cache type    : undefined 5
Cache clean    : undefined 5
Cache lockdown    : undefined 5
Cache format    : Harvard
I size        : 32768
I assoc        : 32
I line length    : 32
I sets        : 32
D size        : 32768
D assoc        : 32
D line length    : 32
D sets        : 32

Hardware    : The Gumstix Platform
Revision    : 0000
Serial        : ffff0015c906b7c0

Thu Jan  1 00:11:38 UTC 1970
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
4816913f154157d105065311be5e8cc1  /proc/cpuinfo

Thu Jan  1 00:11:38 UTC 1970
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
 195:  G...V
[Domain info]
id=3D0x00000000
priority=3D100

Thu Jan  1 00:11:38 UTC 1970
running: cat /proc/ipipe/Xenomai
       +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
       |+---- Sticky
       ||+--- Locked
       |||+-- Exclusive
       ||||+- Virtual
[IRQ]  |||||
  26:  W..X.
 194:  W...V
[Domain info]
id=3D0x58454e4f
priority=3Dtopmost

Thu Jan  1 00:11:38 UTC 1970
running: cat /proc/ipipe/version
1.9-01

Thu Jan  1 00:11:38 UTC 1970
running: generate_loads 1
dd workload started, pids 618 stored in /var/lock/xeno-test.484.pids

Thu Jan  1 00:11:38 UTC 1970
running: cat /proc/interrupts
           CPU0
  3:          2          SC  ohci_hcd:usb1
  6:          0          SC  pxa_i2c-i2c.1
 18:          0          SC  pxa_i2c-i2c.0
 22:       1757          SC  FFUART
 25:          0          SC  DMA
 26:      70586          SC  ost0
Err:          0

Thu Jan  1 00:11:39 UTC 1970
running: cat /proc/loadavg
0.16 0.03 0.01 2/27 630

Thu Jan  1 00:11:39 UTC 1970
running: cat /proc/meminfo
MemTotal:       127988 kB
MemFree:        117624 kB
Buffers:             0 kB
Cached:           5916 kB
SwapCached:          0 kB
Active:           4208 kB
Inactive:         2832 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
AnonPages:        1144 kB
Mapped:           1344 kB
Slab:             1912 kB
SReclaimable:      388 kB
SUnreclaim:       1524 kB
PageTables:        148 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:     63992 kB
Committed_AS:     4776 kB
VmallocTotal:   516096 kB
VmallocUsed:     66096 kB
VmallocChunk:   442364 kB

Thu Jan  1 00:11:39 UTC 1970
running: cat /proc/xenomai/affinity
00000001

Thu Jan  1 00:11:39 UTC 1970
running: cat /proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:           22    (lostage_handler)
  2:            0    (registry_export)
  3:            0    (pse51_lostage_handler)

Thu Jan  1 00:11:39 UTC 1970
running: cat /proc/xenomai/faults
TRAP         CPU0
  0:            0    (Data or instruction access)
  1:            0    (Section fault)
  2:            0    (Generic data abort)
  3:            0    (Unknown exception)
  4:            0    (Instruction breakpoint)
  5:            0    (Floating point exception)
  6:            0    (VFP Floating point exception)
  7:            0    (Undefined instruction)
  8:            0    (Unaligned access exception)

Thu Jan  1 00:11:39 UTC 1970
running: cat /proc/xenomai/hal
1.9-01

Thu Jan  1 00:11:39 UTC 1970
running: cat /proc/xenomai/heap
size=3D129536:used=3D96:pagesz=3D512  (main heap)
size=3D32256:used=3D0:pagesz=3D512  (stack pool)

Thu Jan  1 00:11:40 UTC 1970
running: cat /proc/xenomai/irq
IRQ         CPU0
 26:      278473         [timer]
194:          27         [virtual]

Thu Jan  1 00:11:40 UTC 1970
running: cat /proc/xenomai/latency
9538

Thu Jan  1 00:11:40 UTC 1970
running: cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT

Thu Jan  1 00:11:40 UTC 1970
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          129987     0     00500080   99.4  ROOT
  0  0      0          278517     0     00000000    0.3  IRQ26: [timer]

Thu Jan  1 00:11:40 UTC 1970
running: cat /proc/xenomai/timebases
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled,set

Thu Jan  1 00:11:40 UTC 1970
running: cat /proc/xenomai/timer
status=3Don:setup=3D307:clock=3D2290928995:timerdev=3Dosmr0:clockdev=3Doscr=
0

Thu Jan  1 00:11:40 UTC 1970
running: cat /proc/xenomai/version
2.4.6

Thu Jan  1 00:11:41 UTC 1970
running: cat /proc/xenomai/interfaces/native
0

Thu Jan  1 00:11:41 UTC 1970
running: cat /proc/xenomai/interfaces/posix
0

Thu Jan  1 00:11:41 UTC 1970
running: cat /proc/xenomai/interfaces/rtai
0

Thu Jan  1 00:11:41 UTC 1970
running: cat /proc/xenomai/interfaces/rtdm
0

Thu Jan  1 00:11:41 UTC 1970
running: cat /proc/xenomai/interfaces/sys
0

Thu Jan  1 00:11:41 UTC 1970
running: cat /proc/xenomai/rtdm/fildes
total=3D128:open=3D0:free=3D128
Mem: 10608K used, 117380K free, 0K shrd, 0K buff, 5920K cached
Load average: 0.31 0.07 0.02  (Status: S=3Dsleeping R=3Drunning, W=3Dwaitin=
g)
  PID USER     STATUS   RSS  PPID %CPU %MEM COMMAND
  618 root     R        448     1 96.0  0.3 dd
  752 root     R        756   751  3.8  0.5 top
  434 root     S        940     1  0.0  0.7 ntpd
  475 root     S        940     1  0.0  0.7 sh
  484 root     S        708   475  0.0  0.5 xeno-test
  442 root     S        592     1  0.0  0.4 klogd
  425 root     S        572     1  0.0  0.4 dropbear

Thu Jan  1 00:11:43 UTC 1970
running: ./run -- -sh -T 120 -t0 # latency
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds

--=20
*=BA=A4., =B8=B8,.=A4=BA*=A8*=A4., =B8=B8,.=A4=BA*=A8*
Cavalkaf (aka Felipe) <cavalkaf@domain.hid>
AIM: Cavalkaf | MSN: cavalkaf2@domain.hid
Check out <http://www.flickr.com/photos/rbcav2003/>

------=_Part_14791_16263985.1229617902158
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br><br>I am currently trying to get Xenomai running on the gumstix plat=
aform (<a href=3D"http://www.gumstix.com/">http://www.gumstix.com/</a>), wh=
ich is a *very* small linux board based on the PXA270 ARM XScale (I am usin=
g a Verdex board). However, I did run into a few problems during the proced=
ure (the user space portion locks up!)<br>
<br>I followed the instructions on the README file, and patched the kernel =
with the proper Adeos patch using the command: <br clear=3D"all">./prepare-=
kernel.sh --linux=3D/home/felipe/gumstix/gumstix-oe/tmp/work/gumstix-custom=
-verdex-angstrom-linux-gnueabi/gumstix-kernel-2.6.24-r1/linux-2.6.24/ --ade=
os=3D/home/felipe/gumstix/adeos-ipipe-2.6.24-arm-1.9-01.patch --arch=3Darm<=
br>
<br>I did the standart kernel configuration procedure afterwards, and did c=
onfigure the Xenomai options. The kernel did boot fine, and I can confirm t=
hat Adeos is running (I have /proc/xenomai and some messages during the boo=
t process).<br>
<br>My problem is with the user space portion of Xenomai. I compiled it usi=
ng the usual cross-compiling procedure:<br>./configure --enable-arm-mach=3D=
pxa3xx --host=3Darm-linux<br>make<br>make install<br>However, the &quot;mak=
e install&quot; command runs on a fakeroot, than gets packaged and transfer=
ed to the embedded plataform (the Gumstix). Basically, the package contains=
 the stuff on /dev and on /usr/xenomai.<br>
<br>Basically, when I try to run xeno-test, the whole systems locks up (I h=
ave to hard-reset) when it gets to the latency test.<br>When I run ./latenc=
y, it also freezes up.<br><br>However, when I try ./latency -t 1 and ./late=
ncy -t 2 (testing the kernel latency, IIRC), it runs fine. My guess is that=
 the problems is with the user-space instalation procedure (somehow it is n=
ot being correctly installed?).<br>
<br>My other question is regarding the latencies I should be getting (they =
do seem quite high.) Here is the output from my latency tests:<br>root@domain.hid=
tix-custom-verdex:/usr/xenomai/bin$ ./latency -t 2<br>=3D=3D Sampling perio=
d: 100 us<br>
=3D=3D Test mode: in-kernel timer handler<br>=3D=3D All results in microsec=
onds<br>warming up...<br>RTT|&nbsp; 00:00:01&nbsp; (in-kernel timer handler=
, 100 us period, priority 99)<br>RTH|-----lat min|-----lat avg|-----lat max=
|-overrun|----lat best|---lat worst<br>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.307|&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0.925|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10.153|&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.307|&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 10.153<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.613|&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.988|&nbsp;&nbsp;&nbsp;&nbsp; 145.229|&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0.307|&nbsp;&nbsp;&nbsp;&nbsp; 145.229<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; -3.695|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.962|&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 78.767|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1|&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; -3.695|&nbsp;&nbsp;&nbsp;&nbsp; 145.229<br>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.612|&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0.969|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80.920|&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 1|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -3.695|&nbsp;&nbsp;&nbsp;&n=
bsp; 145.229<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.003|&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0.962|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 77.535|&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 1|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.003|&nbsp;&nb=
sp;&nbsp;&nbsp; 145.229<br>=16RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1.850|&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.970|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80.9=
19|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4=
.003|&nbsp;&nbsp;&nbsp;&nbsp; 145.229<br>
---|------------|------------|------------|--------|-----------------------=
--<br>RTS|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -4.003|&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0.962|&nbsp;&nbsp;&nbsp;&nbsp; 145.229|&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 1|&nbsp;&nbsp;&nbsp; 00:00:08/00:00:08<br>root@domain.hid=
rdex:/usr/xenomai/bin$ ./latency -t 1<br>
=3D=3D Sampling period: 100 us<br>=3D=3D Test mode: in-kernel periodic task=
<br>=3D=3D All results in microseconds<br>warming up...<br>RTT|&nbsp; 00:00=
:01&nbsp; (in-kernel periodic task, 100 us period, priority 99)<br>RTH|----=
-lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst<br>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.921|&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 8.581|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 23.383|&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.921|&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 23.383<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.921|&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8.662|&nbsp;&nbsp;&nbsp;&nbsp; 135.998|&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4.921|&nbsp;&nbsp;&nbsp;&nbsp; 135.998<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 4.920|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8.692|&nbsp;&nbsp;&nbsp;=
&nbsp; 173.228|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9|&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 4.920|&nbsp;&nbsp;&nbsp;&nbsp; 173.228<br>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.919|&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 8.658|&nbsp;&nbsp;&nbsp;&nbsp; 173.843|&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 12|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.919|&nbsp;&nbsp;&nbsp;&nbsp; =
173.843<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.919|&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 8.640|&nbsp;&nbsp;&nbsp;&nbsp; 171.689|&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 15|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.919|&nbsp;&nbsp;&n=
bsp;&nbsp; 173.843<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.918|&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8.676|&nbsp;&nbsp;&nbsp;&nbsp; 171.380|&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 21|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.918|&nb=
sp;&nbsp;&nbsp;&nbsp; 173.843<br>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.917|&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 8.642|&nbsp;&nbsp;&nbsp;&nbsp; 171.379|&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 24|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.917|&nbsp;&nbsp;&nbsp;&nbsp; =
173.843<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.916|&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 8.684|&nbsp;&nbsp;&nbsp;&nbsp; 174.763|&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 29|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.916|&nbsp;&nbsp;&n=
bsp;&nbsp; 174.763<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.916|&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8.640|&nbsp;&nbsp;&nbsp;&nbsp; 175.070|&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 32|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.916|&nb=
sp;&nbsp;&nbsp;&nbsp; 175.070<br>
RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.915|&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 8.651|&nbsp;&nbsp;&nbsp;&nbsp; 169.839|&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 36|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.915|&nbsp;&nbsp;&nbsp;&nbsp; =
175.070<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.914|&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 8.638|&nbsp;&nbsp;&nbsp;&nbsp; 172.915|&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 39|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.914|&nbsp;&nbsp;&n=
bsp;&nbsp; 175.070<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.914|&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8.702|&nbsp;&nbsp;&nbsp;&nbsp; 170.145|&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 47|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.914---|=
------------|------------|------------|--------|-------------------------<b=
r>
RTS|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.914|&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 8.655|&nbsp;&nbsp;&nbsp;&nbsp; 175.070|&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 47|&nbsp;&nbsp;&nbsp; 00:00:12/00:00:12<br><br>The worst latency seem t=
o be arround 175, which is not very good (comparing it to an X86 processor)=
. Is this normal or is there some kernel configuration option which I can u=
se to improve on this? (I am running it with a farly custom config file, so=
 some undeserible options might be enabled).<br>
<br>BTW, for the curious, I am using this in order to control a humanoid ro=
bot (Bioloid) - I am doing research on humanoid robots, and the idea is to =
use embedded linux for the control portion of the project. I am a student a=
t the LARA research lab in the University of Bras=EDlia, Brazil.<br>
<br>Thank you very much for any help,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -Felipe B Cavalcanti<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LARA - Laboratory of Robot=
ics and Automation<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; UnB - University of Bras=EDlia, Brazil<br><br>PS: Here is the=
 full output of xeno-test:<br>
root@domain.hid$ ./xeno-test <br>xeno-test: sta=
rted <br>withBusybox is 1<br>xeno-test: running tests<br><br>Thu Jan&nbsp; =
1 00:11:36 UTC 1970<br>running: ./xeno-config --verbose<br>xeno-config --ve=
rbose<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --version=3D&quot;2.4.6.1&quot;<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --cc=3D&quot;arm-angstrom-lin=
ux-gnueabi-gcc -march=3Darmv5te -mtune=3Dxscale&quot;<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; --arch=3D&quot;arm&quot;<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; --prefix=3D&quot;/usr/xenomai&quot;<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; --xeno-cflags=3D&quot;-I/usr/xenomai/include -D=
_GNU_SOURCE -D_REENTRANT -D__XENO__&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --xeno-ldflags=3D&quot;-L/usr/xe=
nomai/lib -lpthread &quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --=
posix-cflags=3D&quot;-I/usr/xenomai/include -I/usr/xenomai/include/posix -D=
_GNU_SOURCE -D_REENTRANT -D__XENO__&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; --posix-ldflags=3D&quot;-Wl,@/usr/xenomai/lib/posix.wrappers -=
L/usr/xenomai/lib -lpthread_rt -lpthread -lrt &quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --library-dir=3D&quot;/usr/xenom=
ai/lib&quot;<br><br>Thu Jan&nbsp; 1 00:11:37 UTC 1970<br>running: ./xeno-in=
fo<br>If some fields are empty or look unusual you may have an old version.=
<br>Compare to the current minimal requirements in Documentation/Changes.<b=
r>
&nbsp;<br>BusyBox v1.2.1 (2008.11.24-12:06+0000) multi-call binary<br>Linux=
 gumstix-custom-verdex 2.6.24 #1 Tue Dec 16 16:27:25 BRST 2008 armv5tel unk=
nown<br>&nbsp;<br>*** glibc detected *** which: free(): invalid next size (=
fast): 0x000c4078 ***<br>
Aborted<br>*** glibc detected *** which: free(): invalid next size (fast): =
0x000c4078 ***<br>Aborted<br>module-init-tools&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 3.2.2<br>*** glibc detected *** which: free(): invalid next size (fast): =
0x000c4078 ***<br>Aborted<br>
Modules Loaded&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c_dev i2c_=
pxa i2c_core sd_mod scsi_mod proc_gpio ohci_hcd usbcore<br><br>Thu Jan&nbsp=
; 1 00:11:38 UTC 1970<br>running: cat /proc/cpuinfo<br>Processor&nbsp;&nbsp=
;&nbsp; : XScale-PXA270 rev 7 (v5l)<br>BogoMIPS&nbsp;&nbsp;&nbsp; : 622.59<=
br>
Features&nbsp;&nbsp;&nbsp; : swp half thumb fastmult edsp iwmmxt <br>CPU im=
plementer&nbsp;&nbsp;&nbsp; : 0x69<br>CPU architecture: 5TE<br>CPU variant&=
nbsp;&nbsp;&nbsp; : 0x0<br>CPU part&nbsp;&nbsp;&nbsp; : 0x411<br>CPU revisi=
on&nbsp;&nbsp;&nbsp; : 7<br>Cache type&nbsp;&nbsp;&nbsp; : undefined 5<br>C=
ache clean&nbsp;&nbsp;&nbsp; : undefined 5<br>
Cache lockdown&nbsp;&nbsp;&nbsp; : undefined 5<br>Cache format&nbsp;&nbsp;&=
nbsp; : Harvard<br>I size&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : 32768<br>I=
 assoc&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : 32<br>I line length&nbsp;&nbs=
p;&nbsp; : 32<br>I sets&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : 32<br>D size=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : 32768<br>D assoc&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; : 32<br>D line length&nbsp;&nbsp;&nbsp; : 32<br>
D sets&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : 32<br><br>Hardware&nbsp;&nbsp=
;&nbsp; : The Gumstix Platform<br>Revision&nbsp;&nbsp;&nbsp; : 0000<br>Seri=
al&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : ffff0015c906b7c0<br><br>Thu Jan&n=
bsp; 1 00:11:38 UTC 1970<br>running: md5sum /proc/cpuinfo # cpuinfo fingerp=
rint<br>4816913f154157d105065311be5e8cc1&nbsp; /proc/cpuinfo<br>
<br>Thu Jan&nbsp; 1 00:11:38 UTC 1970<br>running: cat /proc/ipipe/Linux<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +----- Handling ([A]ccepted, [G]rabbed=
, [W]ired, [D]iscarded)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |+---- Stic=
ky<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||+--- Locked<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |||+-- Exclusive<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ||||+- Virtual<br>
[IRQ]&nbsp; |||||<br>&nbsp;&nbsp; 0:&nbsp; A....<br>&nbsp;&nbsp; 1:&nbsp; A=
....<br>&nbsp;&nbsp; 2:&nbsp; A....<br>&nbsp;&nbsp; 3:&nbsp; A....<br>&nbsp=
;&nbsp; 4:&nbsp; A....<br>&nbsp;&nbsp; 5:&nbsp; A....<br>&nbsp;&nbsp; 6:&nb=
sp; A....<br>&nbsp;&nbsp; 7:&nbsp; A....<br>&nbsp;&nbsp; 8:&nbsp; A....<br>=
&nbsp;&nbsp; 9:&nbsp; A....<br>&nbsp; 10:&nbsp; A....<br>&nbsp; 11:&nbsp; A=
....<br>&nbsp; 12:&nbsp; A....<br>
&nbsp; 13:&nbsp; A....<br>&nbsp; 14:&nbsp; A....<br>&nbsp; 15:&nbsp; A....<=
br>&nbsp; 16:&nbsp; A....<br>&nbsp; 17:&nbsp; A....<br>&nbsp; 18:&nbsp; A..=
..<br>&nbsp; 19:&nbsp; A....<br>&nbsp; 20:&nbsp; A....<br>&nbsp; 21:&nbsp; =
A....<br>&nbsp; 22:&nbsp; A....<br>&nbsp; 23:&nbsp; A....<br>&nbsp; 24:&nbs=
p; A....<br>&nbsp; 25:&nbsp; A....<br>&nbsp; 26:&nbsp; A....<br>
&nbsp; 27:&nbsp; A....<br>&nbsp; 28:&nbsp; A....<br>&nbsp; 29:&nbsp; A....<=
br>&nbsp; 30:&nbsp; A....<br>&nbsp; 31:&nbsp; A....<br>&nbsp; 32:&nbsp; A..=
..<br>&nbsp; 33:&nbsp; A....<br>&nbsp; 34:&nbsp; A....<br>&nbsp; 35:&nbsp; =
A....<br>&nbsp; 36:&nbsp; A....<br>&nbsp; 37:&nbsp; A....<br>&nbsp; 38:&nbs=
p; A....<br>&nbsp; 39:&nbsp; A....<br>&nbsp; 40:&nbsp; A....<br>
&nbsp; 41:&nbsp; A....<br>&nbsp; 42:&nbsp; A....<br>&nbsp; 43:&nbsp; A....<=
br>&nbsp; 44:&nbsp; A....<br>&nbsp; 45:&nbsp; A....<br>&nbsp; 46:&nbsp; A..=
..<br>&nbsp; 47:&nbsp; A....<br>&nbsp; 48:&nbsp; A....<br>&nbsp; 49:&nbsp; =
A....<br>&nbsp; 50:&nbsp; A....<br>&nbsp; 51:&nbsp; A....<br>&nbsp; 52:&nbs=
p; A....<br>&nbsp; 53:&nbsp; A....<br>&nbsp; 54:&nbsp; A....<br>
&nbsp; 55:&nbsp; A....<br>&nbsp; 56:&nbsp; A....<br>&nbsp; 57:&nbsp; A....<=
br>&nbsp; 58:&nbsp; A....<br>&nbsp; 59:&nbsp; A....<br>&nbsp; 60:&nbsp; A..=
..<br>&nbsp; 61:&nbsp; A....<br>&nbsp; 62:&nbsp; A....<br>&nbsp; 63:&nbsp; =
A....<br>&nbsp; 64:&nbsp; A....<br>&nbsp; 65:&nbsp; A....<br>&nbsp; 66:&nbs=
p; A....<br>&nbsp; 67:&nbsp; A....<br>&nbsp; 68:&nbsp; A....<br>
&nbsp; 69:&nbsp; A....<br>&nbsp; 70:&nbsp; A....<br>&nbsp; 71:&nbsp; A....<=
br>&nbsp; 72:&nbsp; A....<br>&nbsp; 73:&nbsp; A....<br>&nbsp; 74:&nbsp; A..=
..<br>&nbsp; 75:&nbsp; A....<br>&nbsp; 76:&nbsp; A....<br>&nbsp; 77:&nbsp; =
A....<br>&nbsp; 78:&nbsp; A....<br>&nbsp; 79:&nbsp; A....<br>&nbsp; 80:&nbs=
p; A....<br>&nbsp; 81:&nbsp; A....<br>&nbsp; 82:&nbsp; A....<br>
&nbsp; 83:&nbsp; A....<br>&nbsp; 84:&nbsp; A....<br>&nbsp; 85:&nbsp; A....<=
br>&nbsp; 86:&nbsp; A....<br>&nbsp; 87:&nbsp; A....<br>&nbsp; 88:&nbsp; A..=
..<br>&nbsp; 89:&nbsp; A....<br>&nbsp; 90:&nbsp; A....<br>&nbsp; 91:&nbsp; =
A....<br>&nbsp; 92:&nbsp; A....<br>&nbsp; 93:&nbsp; A....<br>&nbsp; 94:&nbs=
p; A....<br>&nbsp; 95:&nbsp; A....<br>&nbsp; 96:&nbsp; A....<br>
&nbsp; 97:&nbsp; A....<br>&nbsp; 98:&nbsp; A....<br>&nbsp; 99:&nbsp; A....<=
br>&nbsp;100:&nbsp; A....<br>&nbsp;101:&nbsp; A....<br>&nbsp;102:&nbsp; A..=
..<br>&nbsp;103:&nbsp; A....<br>&nbsp;104:&nbsp; A....<br>&nbsp;105:&nbsp; =
A....<br>&nbsp;106:&nbsp; A....<br>&nbsp;107:&nbsp; A....<br>&nbsp;108:&nbs=
p; A....<br>&nbsp;109:&nbsp; A....<br>&nbsp;110:&nbsp; A....<br>
&nbsp;111:&nbsp; A....<br>&nbsp;112:&nbsp; A....<br>&nbsp;113:&nbsp; A....<=
br>&nbsp;114:&nbsp; A....<br>&nbsp;115:&nbsp; A....<br>&nbsp;116:&nbsp; A..=
..<br>&nbsp;117:&nbsp; A....<br>&nbsp;118:&nbsp; A....<br>&nbsp;119:&nbsp; =
A....<br>&nbsp;120:&nbsp; A....<br>&nbsp;121:&nbsp; A....<br>&nbsp;122:&nbs=
p; A....<br>&nbsp;123:&nbsp; A....<br>&nbsp;124:&nbsp; A....<br>
&nbsp;125:&nbsp; A....<br>&nbsp;126:&nbsp; A....<br>&nbsp;127:&nbsp; A....<=
br>&nbsp;128:&nbsp; A....<br>&nbsp;129:&nbsp; A....<br>&nbsp;130:&nbsp; A..=
..<br>&nbsp;131:&nbsp; A....<br>&nbsp;132:&nbsp; A....<br>&nbsp;133:&nbsp; =
A....<br>&nbsp;134:&nbsp; A....<br>&nbsp;135:&nbsp; A....<br>&nbsp;136:&nbs=
p; A....<br>&nbsp;137:&nbsp; A....<br>&nbsp;138:&nbsp; A....<br>
&nbsp;139:&nbsp; A....<br>&nbsp;140:&nbsp; A....<br>&nbsp;141:&nbsp; A....<=
br>&nbsp;142:&nbsp; A....<br>&nbsp;143:&nbsp; A....<br>&nbsp;144:&nbsp; A..=
..<br>&nbsp;145:&nbsp; A....<br>&nbsp;146:&nbsp; A....<br>&nbsp;147:&nbsp; =
A....<br>&nbsp;148:&nbsp; A....<br>&nbsp;149:&nbsp; A....<br>&nbsp;150:&nbs=
p; A....<br>&nbsp;151:&nbsp; A....<br>&nbsp;152:&nbsp; A....<br>
&nbsp;153:&nbsp; A....<br>&nbsp;154:&nbsp; A....<br>&nbsp;155:&nbsp; A....<=
br>&nbsp;156:&nbsp; A....<br>&nbsp;157:&nbsp; A....<br>&nbsp;158:&nbsp; A..=
..<br>&nbsp;159:&nbsp; A....<br>&nbsp;160:&nbsp; A....<br>&nbsp;161:&nbsp; =
A....<br>&nbsp;162:&nbsp; A....<br>&nbsp;163:&nbsp; A....<br>&nbsp;164:&nbs=
p; A....<br>&nbsp;165:&nbsp; A....<br>&nbsp;166:&nbsp; A....<br>
&nbsp;167:&nbsp; A....<br>&nbsp;168:&nbsp; A....<br>&nbsp;169:&nbsp; A....<=
br>&nbsp;170:&nbsp; A....<br>&nbsp;171:&nbsp; A....<br>&nbsp;172:&nbsp; A..=
..<br>&nbsp;173:&nbsp; A....<br>&nbsp;174:&nbsp; A....<br>&nbsp;175:&nbsp; =
A....<br>&nbsp;176:&nbsp; A....<br>&nbsp;177:&nbsp; A....<br>&nbsp;178:&nbs=
p; A....<br>&nbsp;179:&nbsp; A....<br>&nbsp;180:&nbsp; A....<br>
&nbsp;181:&nbsp; A....<br>&nbsp;182:&nbsp; A....<br>&nbsp;183:&nbsp; A....<=
br>&nbsp;184:&nbsp; A....<br>&nbsp;185:&nbsp; A....<br>&nbsp;186:&nbsp; A..=
..<br>&nbsp;187:&nbsp; A....<br>&nbsp;188:&nbsp; A....<br>&nbsp;189:&nbsp; =
A....<br>&nbsp;190:&nbsp; A....<br>&nbsp;191:&nbsp; A....<br>&nbsp;192:&nbs=
p; G...V<br>&nbsp;193:&nbsp; G...V<br>&nbsp;195:&nbsp; G...V<br>
[Domain info]<br>id=3D0x00000000<br>priority=3D100<br><br>Thu Jan&nbsp; 1 0=
0:11:38 UTC 1970<br>running: cat /proc/ipipe/Xenomai<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscar=
ded)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |+---- Sticky<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ||+--- Locked<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |||+-- Exclusive<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ||||+- Virtual<br>[IRQ]&nbsp; |||||<br>&nbsp; 26:&nbsp; =
W..X.<br>&nbsp;194:&nbsp; W...V<br>[Domain info]<br>id=3D0x58454e4f<br>prio=
rity=3Dtopmost<br><br>Thu Jan&nbsp; 1 00:11:38 UTC 1970<br>running: cat /pr=
oc/ipipe/version<br>
1.9-01<br><br>Thu Jan&nbsp; 1 00:11:38 UTC 1970<br>running: generate_loads =
1<br>dd workload started, pids 618 stored in /var/lock/xeno-test.484.pids<b=
r><br>Thu Jan&nbsp; 1 00:11:38 UTC 1970<br>running: cat /proc/interrupts<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>
&nbsp; 3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SC&nbsp; ohci_hcd:usb1<br>&nbs=
p; 6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SC&nbsp; pxa_i2c-i2c.1<br>&nbsp;18=
:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SC&nbsp; pxa_i2c-i2c.0<br>&nbsp;22:&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1757&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; SC&nbsp; FFUART<br>&nbsp;25:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; SC&nbsp; DMA<br>&nbsp;26:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 70586&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SC&nbsp; ost0<br>
Err:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br><br>Thu Jan=
&nbsp; 1 00:11:39 UTC 1970<br>running: cat /proc/loadavg<br>0.16 0.03 0.01 =
2/27 630<br><br>Thu Jan&nbsp; 1 00:11:39 UTC 1970<br>running: cat /proc/mem=
info<br>MemTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 127988 kB<br>MemFree:=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 117624 kB<br>
Buffers:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0 kB<br>Cached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 5916 kB<br>SwapCached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0 kB<br>Active:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 4208 kB<br>Inactive:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 2832 kB<br>SwapTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0 kB<br>SwapFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0 kB<br>Dirty:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
Writeback:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB=
<br>AnonPages:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1144 kB<br>Mapped:=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1344 kB<br>Sla=
b:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1912 kB<br>SReclaimable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 388 kB<br>SUnreclaim=
:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1524 kB<br>PageTables:&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 148 kB<br>NFS_Unstable:&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0 kB<br>
Bounce:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0 kB<br>CommitLimit:&nbsp;&nbsp;&nbsp;&nbsp; 63992 kB<br>Committ=
ed_AS:&nbsp;&nbsp;&nbsp;&nbsp; 4776 kB<br>VmallocTotal:&nbsp;&nbsp; 516096 =
kB<br>VmallocUsed:&nbsp;&nbsp;&nbsp;&nbsp; 66096 kB<br>VmallocChunk:&nbsp;&=
nbsp; 442364 kB<br><br>Thu Jan&nbsp; 1 00:11:39 UTC 1970<br>running: cat /p=
roc/xenomai/affinity<br>
00000001<br><br>Thu Jan&nbsp; 1 00:11:39 UTC 1970<br>running: cat /proc/xen=
omai/apc<br>APC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<=
br>&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0&nbsp;&nbsp;&nbsp; (pipe_wakeup)<br>&nbsp; 1:&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22&nbsp;&nbsp;&nbsp; (lostage_handler)<=
br>&nbsp; 2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0&nbsp;&nbsp;&nbsp; (registry_export)<br>
&nbsp; 3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp; (pse51_lostage_handler)<br><br>Thu Jan&nbsp; 1 00:11:3=
9 UTC 1970<br>running: cat /proc/xenomai/faults<br>TRAP&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Data or instruct=
ion access)<br>&nbsp; 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Section fault)<br>
&nbsp; 2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp; (Generic data abort)<br>&nbsp; 3:&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Unknown =
exception)<br>&nbsp; 4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Instruction breakpoint)<br>&nbsp; 5:&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbs=
p;&nbsp; (Floating point exception)<br>&nbsp; 6:&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (VFP Floating p=
oint exception)<br>
&nbsp; 7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0&nbsp;&nbsp;&nbsp; (Undefined instruction)<br>&nbsp; 8:&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Unali=
gned access exception)<br><br>Thu Jan&nbsp; 1 00:11:39 UTC 1970<br>running:=
 cat /proc/xenomai/hal<br>1.9-01<br><br>Thu Jan&nbsp; 1 00:11:39 UTC 1970<b=
r>running: cat /proc/xenomai/heap<br>
size=3D129536:used=3D96:pagesz=3D512&nbsp; (main heap)<br>size=3D32256:used=
=3D0:pagesz=3D512&nbsp; (stack pool)<br><br>Thu Jan&nbsp; 1 00:11:40 UTC 19=
70<br>running: cat /proc/xenomai/irq<br>IRQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; CPU0<br>&nbsp;26:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 278473&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [timer]<br>194:&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 27&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; [virtual]<br>
<br>Thu Jan&nbsp; 1 00:11:40 UTC 1970<br>running: cat /proc/xenomai/latency=
<br>9538<br><br>Thu Jan&nbsp; 1 00:11:40 UTC 1970<br>running: cat /proc/xen=
omai/sched<br>CPU&nbsp; PID&nbsp;&nbsp;&nbsp; PRI&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; PERIOD&nbsp;&nbsp;&nbsp;&nbsp; TIMEOUT&nbsp;&nbsp;&nbsp; TIMEBASE&nbsp=
; STAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NAME<br>
&nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; master&nbsp;&nbsp;&nbsp; R&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ROOT<br><br>Thu Jan&n=
bsp; 1 00:11:40 UTC 1970<br>running: cat /proc/xenomai/stat<br>CPU&nbsp; PI=
D&nbsp;&nbsp;&nbsp; MSW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CSW&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PF&nbsp;&nbsp;&nbsp; STAT&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; %CPU&nbsp; NAME<br>&nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1299=
87&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 00500080&nbsp;&nbsp; 9=
9.4&nbsp; ROOT<br>
&nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 278517&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nb=
sp;&nbsp; 00000000&nbsp;&nbsp;&nbsp; 0.3&nbsp; IRQ26: [timer]<br><br>Thu Ja=
n&nbsp; 1 00:11:40 UTC 1970<br>running: cat /proc/xenomai/timebases<br>NAME=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RESOLUTION&nbsp;&nbsp;&nbsp;&nbsp; JIF=
FIES&nbsp;&nbsp; STATUS<br>master&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; n/a&nbsp;&nbsp; enabled,set<br>
<br>Thu Jan&nbsp; 1 00:11:40 UTC 1970<br>running: cat /proc/xenomai/timer<b=
r>status=3Don:setup=3D307:clock=3D2290928995:timerdev=3Dosmr0:clockdev=3Dos=
cr0<br><br>Thu Jan&nbsp; 1 00:11:40 UTC 1970<br>running: cat /proc/xenomai/=
version<br>2.4.6<br>
<br>Thu Jan&nbsp; 1 00:11:41 UTC 1970<br>running: cat /proc/xenomai/interfa=
ces/native<br>0<br><br>Thu Jan&nbsp; 1 00:11:41 UTC 1970<br>running: cat /p=
roc/xenomai/interfaces/posix<br>0<br><br>Thu Jan&nbsp; 1 00:11:41 UTC 1970<=
br>running: cat /proc/xenomai/interfaces/rtai<br>
0<br><br>Thu Jan&nbsp; 1 00:11:41 UTC 1970<br>running: cat /proc/xenomai/in=
terfaces/rtdm<br>0<br><br>Thu Jan&nbsp; 1 00:11:41 UTC 1970<br>running: cat=
 /proc/xenomai/interfaces/sys<br>0<br><br>Thu Jan&nbsp; 1 00:11:41 UTC 1970=
<br>running: cat /proc/xenomai/rtdm/fildes<br>
total=3D128:open=3D0:free=3D128<br>Mem: 10608K used, 117380K free, 0K shrd,=
 0K buff, 5920K cached<br>Load average: 0.31 0.07 0.02&nbsp; (Status: S=3Ds=
leeping R=3Drunning, W=3Dwaiting)<br>&nbsp; PID USER&nbsp;&nbsp;&nbsp;&nbsp=
; STATUS&nbsp;&nbsp; RSS&nbsp; PPID %CPU %MEM COMMAND<br>
&nbsp; 618 root&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 448&nbsp;&nbsp;&nbsp;&nbsp; 1 96.0&nbsp; 0.3 dd<br>&nbsp; 752 root=
&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 756&nb=
sp;&nbsp; 751&nbsp; 3.8&nbsp; 0.5 top<br>&nbsp; 434 root&nbsp;&nbsp;&nbsp;&=
nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 940&nbsp;&nbsp;&nbsp;&nbs=
p; 1&nbsp; 0.0&nbsp; 0.7 ntpd<br>&nbsp; 475 root&nbsp;&nbsp;&nbsp;&nbsp; S&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 940&nbsp;&nbsp;&nbsp;&nbsp; 1&nbs=
p; 0.0&nbsp; 0.7 sh<br>&nbsp; 484 root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 708&nbsp;&nbsp; 475&nbsp; 0.0&nbsp; 0.5 xen=
o-test<br>
&nbsp; 442 root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 592&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; 0.0&nbsp; 0.4 klogd<br>&nbsp; =
425 root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 572&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; 0.0&nbsp; 0.4 dropbear<br><br>Thu Jan=
&nbsp; 1 00:11:43 UTC 1970<br>running: ./run -- -sh -T 120 -t0 # latency<br=
>*<br>*<br>* Type ^C to stop this application.<br>
*<br>*<br>=3D=3D Sampling period: 100 us<br>=3D=3D Test mode: periodic user=
-mode task<br>=3D=3D All results in microseconds<br><br>-- <br>*=BA=A4., =
=B8=B8,.=A4=BA*=A8*=A4., =B8=B8,.=A4=BA*=A8*<br>Cavalkaf (aka Felipe) &lt;<=
a href=3D"mailto:cavalkaf@domain.hid">cavalkaf@domain.hid</a>&gt;<br>
AIM: Cavalkaf | MSN: <a href=3D"mailto:cavalkaf2@domain.hid">cavalkaf2@domain.hid=
.com</a><br>Check out &lt;<a href=3D"http://www.flickr.com/photos/rbcav2003=
/">http://www.flickr.com/photos/rbcav2003/</a>&gt;<br>

------=_Part_14791_16263985.1229617902158--

