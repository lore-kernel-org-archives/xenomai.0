MIME-Version: 1.0
From: Siva kumar Balasubramanian <sivakumar.bs@domain.hid>
Date: Fri, 7 Oct 2011 20:22:22 +0530
Message-ID: <CACFV95JranppM+ZDoqsgjO5nJ-Th2fFAD0HowBSkL-t_wQ-t4w@domain.hid>
Content-Type: multipart/alternative; boundary=20cf30434f54e9f4ec04aeb69741
Subject: [Xenomai-help] Xenomai: /dev/rtheap is missing (chardev,
	major=10 minor=254) in mini2440
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--20cf30434f54e9f4ec04aeb69741
Content-Type: text/plain; charset=ISO-8859-1

Hi Experts,

I compiled and ported linux kernel-2.6.37.6, adeos-ipipe-patch-2.6.37.6 and
xenomai 2.5.6 in mini2440.
After porting when i run xeno-test,

I am getting following error

Xenomai: /dev/rtheap is missing

(chardev, major=10 minor=254)


The complete log is

 root@domain.hid# xeno-test

xeno-test: started

withBusybox is 0

xeno-test: running tests

Sat Jan 1 00:33:45 UTC 2000

running: /xenomai/bin/xeno-config --verbose

xeno-config --verbose

--version="2.5.6"

--cc="arm-linux-gcc"

--arch="arm"

--prefix="/usr/xenomai"

--xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-D__XENO__"

--xeno-ldflags="-L/usr/xenomai/lib -lxenomai -lpthread "

--posix-cflags=""

--posix-ldflags="-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib
-lpthread_rt -lxenomai -lpthread -lrt "

--library-dir="/usr/xenomai/lib"

Sat Jan 1 00:33:46 UTC 2000

running: /xenomai/bin/xeno-info

If some fields are empty or look unusual you may have an old version.

Compare to the current minimal requirements in Documentation/Changes.

 Linux (none) 2.6.37.6-ipipe #2 Fri Oct 7 15:44:06 IST 2011 armv4tl
GNU/Linux

 util-linux ng 2.13.1.1)

mount ng 2.13.1.1)

module-init-tools 3.4

e2fsprogs 1.41.3

Linux C Library > libc.2.7

Dynamic linker (ldd) 2.7

Procps 3.2.7

Net-tools 1.60

Kbd 89:

Sh-utils 6.10

Modules Loaded

Sat Jan 1 00:33:49 UTC 2000

running: cat /proc/cpuinfo

Processor\0x09: ARM920T rev 0 (v4l)

BogoMIPS\0x09: 201.93

Features\0x09: swp half thumb

CPU implementer\0x09: 0x41

CPU architecture: 4T

CPU variant\0x09: 0x1

CPU part\0x09: 0x920

CPU revision\0x09: 0

Hardware\0x09: MINI2440

Revision\0x09: 0000

Serial\0x09\0x09: 0000000000000000

Sat Jan 1 00:33:49 UTC 2000

running: md5sum /proc/cpuinfo # cpuinfo fingerprint

72f59e533ef85a8821c3dfae14294205 /proc/cpuinfo

Sat Jan 1 00:33:49 UTC 2000

running: cat /proc/ipipe/Linux

+----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)

|+---- Sticky

||+--- Locked

|||+-- Exclusive

||||+- Virtual

[IRQ] |||||

0: A....

1: A....

2: A....

3: A....

4: A....

5: A....

6: A....

7: A....

8: A....

9: A....

10: A....

11: A....

12: A....

13: A....

14: A....

15: A....

16: A....

17: A....

18: A....

19: A....

20: A....

21: A....

22: A....

23: A....

24: A....

25: A....

26: A....

27: A....

28: A....

29: A....

30: A....

31: A....

32: A....

33: A....

34: A....

35: A....

36: A....

37: A....

38: A....

39: A....

40: A....

41: A....

42: A....

43: A....

44: A....

45: A....

46: A....

47: A....

48: A....

49: A....

50: A....

51: A....

52: A....

53: A....

54: A....

55: A....

56: A....

57: A....

58: A....

59: A....

60: A....

61: A....

62: A....

63: A....

64: A....

65: A....

66: A....

67: A....

68: A....

69: A....

70: A....

71: A....

72: A....

73: A....

74: A....

75: A....

76: A....

77: A....

78: A....

79: A....

80: A....

81: A....

82: A....

83: A....

84: A....

96: G...V

[Domain info]

id=0x00000000

priority=100

Sat Jan 1 00:33:49 UTC 2000

running: cat /proc/ipipe/version

1.18-03

Sat Jan 1 00:33:49 UTC 2000

running: generate_loads 1

dd workload started, pids 1300 stored in /var/lock/xeno-test.1179.pids

Sat Jan 1 00:33:49 UTC 2000

running: cat /proc/interrupts

CPU0

30: 406280 s3c S3C2410 Timer Tick

37: 785631 s3c s3c-mci

41: 1 s3c s3c2410_udc

43: 8 s3c s3c2440-i2c

52: 0 s3c-ext Button 1

55: 0 s3c-ext Button 2

57: 0 s3c-ext Button 3

58: 0 s3c-ext Power

59: 0 s3c-ext Button 5

60: 0 s3c-ext s3c-mci

70: 3264 s3c-uart0 s3c2440-uart

71: 2552 s3c-uart0 s3c2440-uart

83: 0 - s3c2410-wdt

Err: 0

Sat Jan 1 00:33:49 UTC 2000

running: cat /proc/loadavg

0.15 0.09 0.07 2/39 1306

Sat Jan 1 00:33:50 UTC 2000

running: cat /proc/meminfo

MemTotal: 60472 kB

MemFree: 3812 kB

Buffers: 2628 kB

Cached: 47168 kB

SwapCached: 0 kB

Active: 5780 kB

Inactive: 45432 kB

Active(anon): 1416 kB

Inactive(anon): 0 kB

Active(file): 4364 kB

Inactive(file): 45432 kB

Unevictable: 0 kB

Mlocked: 0 kB

SwapTotal: 0 kB

SwapFree: 0 kB

Dirty: 128 kB

Writeback: 0 kB

AnonPages: 1432 kB

Mapped: 1424 kB

Shmem: 0 kB

Slab: 4384 kB

SReclaimable: 2832 kB

SUnreclaim: 1552 kB

KernelStack: 312 kB

PageTables: 160 kB

NFS_Unstable: 0 kB

Bounce: 0 kB

WritebackTmp: 0 kB

CommitLimit: 30236 kB

Committed_AS: 3200 kB

VmallocTotal: 811008 kB

VmallocUsed: 3500 kB

VmallocChunk: 803836 kB

Sat Jan 1 00:33:50 UTC 2000

running: top -bn1c

top - 00:33:51 up 33 min, 0 users, load average: 0.46, 0.16, 0.09

Tasks: 41 total, 2 running, 39 sleeping, 0 stopped, 0 zombie

Cpu(s): 0.4%us, 1.4%sy, 0.0%ni, 97.1%id, 0.6%wa, 0.0%hi, 0.5%si, 0.0%st

Mem: 60472k total, 57292k used, 3180k free, 2636k buffers

Swap: 0k total, 0k used, 0k free, 47268k cached

 PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND

1300 root 20 0 1892 524 428 R 78.9 0.9 0:01.04 dd if /dev/zero of

1314 root 20 0 2532 996 812 R 9.5 1.6 0:00.22 top -bn1c

1 root 20 0 2996 1492 1168 S 0.0 2.5 0:01.73 /bin/sh

Sat Jan 1 00:33:51 UTC 2000

running: ./run -- -sh -T 120 -t0 # latency

*

*

* Type ^C to stop this application.

*

*

Xenomai: /dev/rtheap is missing

(chardev, major=10 minor=254)

Sat Jan 1 00:33:57 UTC 2000

running: ./run -- -sh -T 120 -t1 # latency

*

*

* Type ^C to stop this application.

*

*

Xenomai: /dev/rtheap is missing

(chardev, major=10 minor=254)

Sat Jan 1 00:34:03 UTC 2000

running: ./run -- -sh -T 120 -t2 # latency

*

*

* Type ^C to stop this application.

*

*

Xenomai: /dev/rtheap is missing

(chardev, major=10 minor=254)

Sat Jan 1 00:34:08 UTC 2000

running: ./run -- -T 120 # switchtest

*

*

* Type ^C to stop this application.

*

*

Xenomai: /dev/rtheap is missing

(chardev, major=10 minor=254)

/xenomai/bin/xeno-test: line 235: cd:
/usr/xenomai/share/xenomai/testsuite/switchbench: No such file or directory

Sat Jan 1 00:34:14 UTC 2000

running: ./run -- -h # switchbench

*

*

* Type ^C to stop this application.

*

*

Xenomai: /dev/rtheap is missing

(chardev, major=10 minor=254)

Sat Jan 1 00:34:19 UTC 2000

running: ./run -- -p 10 -n -l 1000 # cyclictest

*

*

* Type ^C to stop this application.

*

*

Xenomai: /dev/rtheap is missing

(chardev, major=10 minor=254)

Sat Jan 1 00:34:24 UTC 2000

running: cat /proc/interrupts

CPU0

30: 413186 s3c S3C2410 Timer Tick

37: 847062 s3c s3c-mci

41: 1 s3c s3c2410_udc

43: 8 s3c s3c2440-i2c

52: 0 s3c-ext Button 1

55: 0 s3c-ext Button 2

57: 0 s3c-ext Button 3

58: 0 s3c-ext Power

59: 0 s3c-ext Button 5

60: 0 s3c-ext s3c-mci

70: 3264 s3c-uart0 s3c2440-uart

71: 2750 s3c-uart0 s3c2440-uart

83: 0 - s3c2410-wdt

Err: 0

Sat Jan 1 00:34:24 UTC 2000

running: cat /proc/loadavg

1.13 0.35 0.15 2/39 1830

Sat Jan 1 00:34:24 UTC 2000

running: cat /proc/meminfo

MemTotal: 60472 kB

MemFree: 3552 kB

Buffers: 2684 kB

Cached: 47268 kB

SwapCached: 0 kB

Active: 5860 kB

Inactive: 45508 kB

Active(anon): 1416 kB

Inactive(anon): 0 kB

Active(file): 4444 kB

Inactive(file): 45508 kB

Unevictable: 0 kB

Mlocked: 0 kB

SwapTotal: 0 kB

SwapFree: 0 kB

Dirty: 4 kB

Writeback: 0 kB

AnonPages: 1432 kB

Mapped: 1424 kB

Shmem: 0 kB

Slab: 4492 kB

SReclaimable: 2912 kB

SUnreclaim: 1580 kB

KernelStack: 312 kB

PageTables: 160 kB

NFS_Unstable: 0 kB

Bounce: 0 kB

WritebackTmp: 0 kB

CommitLimit: 30236 kB

Committed_AS: 3200 kB

VmallocTotal: 811008 kB

VmallocUsed: 3500 kB

VmallocChunk: 803836 kB

Sat Jan 1 00:34:24 UTC 2000

running: top -bn1c

top - 00:34:25 up 34 min, 0 users, load average: 1.12, 0.36, 0.16

Tasks: 41 total, 2 running, 39 sleeping, 0 stopped, 0 zombie

Cpu(s): 1.0%us, 2.4%sy, 0.0%ni, 95.5%id, 0.6%wa, 0.0%hi, 0.6%si, 0.0%st

Mem: 60472k total, 57340k used, 3132k free, 2684k buffers

Swap: 0k total, 0k used, 0k free, 47272k cached

 PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND

1300 root 20 0 1892 524 428 R 81.1 0.9 0:18.05 dd if /dev/zero of

1838 root 20 0 2532 996 812 R 12.6 1.6 0:00.22 top -bn1c

1 root 20 0 2996 1492 1168 S 0.0 2.5 0:01.73 /bin/sh

1300 ? 00:00:18 dd

xeno-test: finished
-- 
Regards
sivakumar

--20cf30434f54e9f4ec04aeb69741
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font face=3D"arial,helvetica,sans-serif">Hi Experts,</font><div><font face=
=3D"arial,helvetica,sans-serif"><br></font></div><div><font face=3D"arial,h=
elvetica,sans-serif">I compiled and ported linux kernel-2.6.37.6, adeos-ipi=
pe-patch-2.6.37.6 and xenomai 2.5.6 in mini2440.</font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, helvetica, sans-serif"=
>After porting when i run xeno-test,</font></div><div><font class=3D"Apple-=
style-span" face=3D"arial, helvetica, sans-serif"><br></font></div><div><fo=
nt class=3D"Apple-style-span" face=3D"arial, helvetica, sans-serif">I am ge=
tting following error</font></div>

<div><font class=3D"Apple-style-span" face=3D"arial, helvetica, sans-serif"=
><br></font></div><div><font class=3D"Apple-style-span" face=3D"arial, helv=
etica, sans-serif">

<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Xenomai: /dev/rtheap is missi=
ng</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">(chardev, major=3D10 minor=3D=
254)</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>=
</font></div><div><div><br></div><div>The complete log is</div><div><br>

</div><div>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">root@domain.hid=
e/xenomai/testsuite/latency# xeno-test</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">xeno-test: started </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">withBusybox is 0</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">xeno-test: running tests</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:33:45 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: /xenomai/bin/xeno-co=
nfig --verbose</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">xeno-config --verbose</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">        --version=3D&quot;2.5=
.6&quot;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">        --cc=3D&quot;arm-linu=
x-gcc&quot;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">        --arch=3D&quot;arm&qu=
ot;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">        --prefix=3D&quot;/usr=
/xenomai&quot;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">        --xeno-cflags=3D&quot=
;-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__&q=
uot;</p>


<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">        --xeno-ldflags=3D&quo=
t;-L/usr/xenomai/lib -lxenomai -lpthread &quot;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">        --posix-cflags=3D&quo=
t;&quot;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">        --posix-ldflags=3D&qu=
ot;-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt -lx=
enomai -lpthread -lrt &quot;</p>


<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">        --library-dir=3D&quot=
;/usr/xenomai/lib&quot;</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:33:46 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: /xenomai/bin/xeno-in=
fo</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">If some fields are empty or l=
ook unusual you may have an old version.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Compare to the current minima=
l requirements in Documentation/Changes.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Linux (none) 2.6.37.6-ipipe #=
2 Fri Oct 7 15:44:06 IST 2011 armv4tl GNU/Linux</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">util-linux             ng 2.1=
3.1.1)</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">mount                  ng 2.1=
3.1.1)</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">module-init-tools      3.4</p=
>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">e2fsprogs              1.41.3=
</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Linux C Library        &gt; l=
ibc.2.7</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Dynamic linker (ldd)   2.7</p=
>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Procps                 3.2.7<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Net-tools              1.60</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Kbd                    89:</p=
>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sh-utils               6.10</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Modules Loaded         </p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:33:49 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: cat /proc/cpuinfo</p=
>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Processor\0x09: ARM920T rev 0=
 (v4l)</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">BogoMIPS\0x09: 201.93</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Features\0x09: swp half thumb=
 </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">CPU implementer\0x09: 0x41</p=
>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">CPU architecture: 4T</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">CPU variant\0x09: 0x1</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">CPU part\0x09: 0x920</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">CPU revision\0x09: 0</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Hardware\0x09: MINI2440</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Revision\0x09: 0000</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Serial\0x09\0x09: 00000000000=
00000</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:33:49 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: md5sum /proc/cpuinfo=
 # cpuinfo fingerprint</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">72f59e533ef85a8821c3dfae14294=
205  /proc/cpuinfo</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:33:49 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: cat /proc/ipipe/Linu=
x</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">       +----- Handling ([A]cc=
epted, [G]rabbed, [W]ired, [D]iscarded)</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">       |+---- Sticky</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">       ||+--- Locked</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">       |||+-- Exclusive</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">       ||||+- Virtual</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">[IRQ]  |||||</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">   0:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">   1:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">   2:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">   3:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">   4:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">   5:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">   6:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">   7:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">   8:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">   9:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  10:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  11:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  12:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  13:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  14:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  15:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  16:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  17:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  18:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  19:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  20:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  21:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  22:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  23:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  24:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  25:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  26:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  27:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  28:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  29:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  30:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  31:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  32:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  33:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  34:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  35:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  36:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  37:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  38:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  39:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  40:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  41:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  42:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  43:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  44:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  45:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  46:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  47:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  48:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  49:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  50:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  51:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  52:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  53:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  54:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  55:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  56:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  57:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  58:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  59:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  60:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  61:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  62:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  63:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  64:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  65:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  66:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  67:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  68:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  69:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  70:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  71:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  72:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  73:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  74:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  75:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  76:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  77:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  78:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  79:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  80:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  81:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  82:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  83:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  84:  A....</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  96:  G...V</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">[Domain info]</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">id=3D0x00000000</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">priority=3D100</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:33:49 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: cat /proc/ipipe/vers=
ion</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">1.18-03</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:33:49 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: generate_loads 1</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">dd workload started, pids 130=
0 stored in /var/lock/xeno-test.1179.pids</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:33:49 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: cat /proc/interrupts=
</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">           CPU0</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 30:     406280         s3c  =
S3C2410 Timer Tick</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 37:     785631         s3c  =
s3c-mci</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 41:          1         s3c  =
s3c2410_udc</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 43:          8         s3c  =
s3c2440-i2c</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 52:          0     s3c-ext  =
Button 1</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 55:          0     s3c-ext  =
Button 2</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 57:          0     s3c-ext  =
Button 3</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 58:          0     s3c-ext  =
Power</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 59:          0     s3c-ext  =
Button 5</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 60:          0     s3c-ext  =
s3c-mci</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 70:       3264   s3c-uart0  =
s3c2440-uart</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 71:       2552   s3c-uart0  =
s3c2440-uart</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 83:          0           -  =
s3c2410-wdt</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Err:          0</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:33:49 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: cat /proc/loadavg</p=
>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">0.15 0.09 0.07 2/39 1306</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:33:50 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: cat /proc/meminfo</p=
>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">MemTotal:          60472 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">MemFree:            3812 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Buffers:            2628 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Cached:            47168 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">SwapCached:            0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Active:             5780 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Inactive:          45432 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Active(anon):       1416 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Inactive(anon):        0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Active(file):       4364 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Inactive(file):    45432 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Unevictable:           0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Mlocked:               0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">SwapTotal:             0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">SwapFree:              0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Dirty:               128 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Writeback:             0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">AnonPages:          1432 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Mapped:             1424 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Shmem:                 0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Slab:               4384 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">SReclaimable:       2832 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">SUnreclaim:         1552 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">KernelStack:         312 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">PageTables:          160 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">NFS_Unstable:          0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Bounce:                0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">WritebackTmp:          0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">CommitLimit:       30236 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Committed_AS:       3200 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">VmallocTotal:     811008 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">VmallocUsed:        3500 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">VmallocChunk:     803836 kB</=
p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:33:50 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: top -bn1c</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">top - 00:33:51 up 33 min,  0 =
users,  load average: 0.46, 0.16, 0.09</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Tasks:  41 total,   2 running=
,  39 sleeping,   0 stopped,   0 zombie</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Cpu(s):  0.4%us,  1.4%sy,  0.=
0%ni, 97.1%id,  0.6%wa,  0.0%hi,  0.5%si,  0.0%st</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Mem:     60472k total,    572=
92k used,     3180k free,     2636k buffers</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Swap:        0k total,       =
 0k used,        0k free,    47268k cached</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  PID USER      PR  NI  VIRT =
 RES  SHR S %CPU %MEM    TIME+  COMMAND            </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 1300 root      20   0  1892 =
 524  428 R 78.9  0.9   0:01.04 dd if /dev/zero of </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 1314 root      20   0  2532 =
 996  812 R  9.5  1.6   0:00.22 top -bn1c          </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">    1 root      20   0  2996 =
1492 1168 S  0.0  2.5   0:01.73 /bin/sh            </p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:33:51 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: ./run -- -sh -T 120 =
-t0 # latency</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">* Type ^C to stop this applic=
ation.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Xenomai: /dev/rtheap is missi=
ng</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">(chardev, major=3D10 minor=3D=
254)</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:33:57 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: ./run -- -sh -T 120 =
-t1 # latency</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">* Type ^C to stop this applic=
ation.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Xenomai: /dev/rtheap is missi=
ng</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">(chardev, major=3D10 minor=3D=
254)</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:34:03 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: ./run -- -sh -T 120 =
-t2 # latency</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">* Type ^C to stop this applic=
ation.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Xenomai: /dev/rtheap is missi=
ng</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">(chardev, major=3D10 minor=3D=
254)</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:34:08 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: ./run -- -T 120 # sw=
itchtest</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">* Type ^C to stop this applic=
ation.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Xenomai: /dev/rtheap is missi=
ng</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">(chardev, major=3D10 minor=3D=
254)</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">/xenomai/bin/xeno-test: line =
235: cd: /usr/xenomai/share/xenomai/testsuite/switchbench: No such file or =
directory</p>


<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:34:14 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: ./run -- -h # switch=
bench</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">* Type ^C to stop this applic=
ation.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Xenomai: /dev/rtheap is missi=
ng</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">(chardev, major=3D10 minor=3D=
254)</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:34:19 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: ./run -- -p 10 -n -l=
 1000 # cyclictest</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">* Type ^C to stop this applic=
ation.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">*</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Xenomai: /dev/rtheap is missi=
ng</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">(chardev, major=3D10 minor=3D=
254)</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:34:24 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: cat /proc/interrupts=
</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">           CPU0</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 30:     413186         s3c  =
S3C2410 Timer Tick</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 37:     847062         s3c  =
s3c-mci</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 41:          1         s3c  =
s3c2410_udc</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 43:          8         s3c  =
s3c2440-i2c</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 52:          0     s3c-ext  =
Button 1</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 55:          0     s3c-ext  =
Button 2</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 57:          0     s3c-ext  =
Button 3</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 58:          0     s3c-ext  =
Power</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 59:          0     s3c-ext  =
Button 5</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 60:          0     s3c-ext  =
s3c-mci</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 70:       3264   s3c-uart0  =
s3c2440-uart</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 71:       2750   s3c-uart0  =
s3c2440-uart</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 83:          0           -  =
s3c2410-wdt</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Err:          0</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:34:24 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: cat /proc/loadavg</p=
>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">1.13 0.35 0.15 2/39 1830</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:34:24 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: cat /proc/meminfo</p=
>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">MemTotal:          60472 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">MemFree:            3552 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Buffers:            2684 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Cached:            47268 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">SwapCached:            0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Active:             5860 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Inactive:          45508 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Active(anon):       1416 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Inactive(anon):        0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Active(file):       4444 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Inactive(file):    45508 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Unevictable:           0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Mlocked:               0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">SwapTotal:             0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">SwapFree:              0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Dirty:                 4 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Writeback:             0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">AnonPages:          1432 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Mapped:             1424 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Shmem:                 0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Slab:               4492 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">SReclaimable:       2912 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">SUnreclaim:         1580 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">KernelStack:         312 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">PageTables:          160 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">NFS_Unstable:          0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Bounce:                0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">WritebackTmp:          0 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">CommitLimit:       30236 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Committed_AS:       3200 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">VmallocTotal:     811008 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">VmallocUsed:        3500 kB</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">VmallocChunk:     803836 kB</=
p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Sat Jan  1 00:34:24 UTC 2000<=
/p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">running: top -bn1c</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">top - 00:34:25 up 34 min,  0 =
users,  load average: 1.12, 0.36, 0.16</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Tasks:  41 total,   2 running=
,  39 sleeping,   0 stopped,   0 zombie</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Cpu(s):  1.0%us,  2.4%sy,  0.=
0%ni, 95.5%id,  0.6%wa,  0.0%hi,  0.6%si,  0.0%st</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Mem:     60472k total,    573=
40k used,     3132k free,     2684k buffers</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">Swap:        0k total,       =
 0k used,        0k free,    47272k cached</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">  PID USER      PR  NI  VIRT =
 RES  SHR S %CPU %MEM    TIME+  COMMAND            </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 1300 root      20   0  1892 =
 524  428 R 81.1  0.9   0:18.05 dd if /dev/zero of </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 1838 root      20   0  2532 =
 996  812 R 12.6  1.6   0:00.22 top -bn1c          </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">    1 root      20   0  2996 =
1492 1168 S  0.0  2.5   0:01.73 /bin/sh            </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;"> 1300 ?        00:00:18 dd</p=
>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px;">xeno-test: finished</p></div>=
-- <br><div>Regards</div>sivakumar<br>
</div>

--20cf30434f54e9f4ec04aeb69741--

