From: Umair Ali <ali.umair@tut.fi>
Date: Thu, 12 Nov 2015 12:47:09 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A706120@mb2010-3.intra.tut.fi>
Content-Language: en-US
Content-Type: text/plain; charset="windows-1256"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Error:Xenomai: /dev/rtheap is missing & Testing of
 Xenomai 3.0.1 with kernel 3.14.39
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?windows-1256?Q?Xenomai_=FD=5Bxenomai=40xenomai=2Eorg=5D=FD?= <xenomai@xenomai.org>

Hello,

I have the following setup

"root@cpc:/home/cpc# dmesg | grep -i Xenomai
[    0.000000] Linux version 3.14.39-xenomai-3.0.1 (root@cpc) (gcc version =
4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04) ) #2 SMP PREEMPT Tue Nov 10 18:02:47 EE=
T 2015
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-3.14.39-xeno=
mai-3.0.1 root=3DUUID=3De29fa266-6a54-4815-b5bd-ea0168f18fd7 ro quiet splas=
h crashkernel=3D384M-:128M
[    0.836896] [Xenomai] scheduling class idle registered.
[    0.836901] [Xenomai] scheduling class rt registered.
[    0.836947] [Xenomai] SMI-enabled chipset found, but SMI workaround disa=
bled
[    0.836947]           (see xenomai.smi parameter). You might encounter
[    0.837074] I-pipe: head domain Xenomai registered.
[    0.837699] [Xenomai] Cobalt v3.0.1 (Exact Zero) [DEBUG]
[    1.404181] usb usb1: Manufacturer: Linux 3.14.39-xenomai-3.0.1 ehci_hcd
[    1.405407] usb usb2: Manufacturer: Linux 3.14.39-xenomai-3.0.1 uhci_hcd
[    1.406284] usb usb3: Manufacturer: Linux 3.14.39-xenomai-3.0.1 uhci_hcd
[    1.407144] usb usb4: Manufacturer: Linux 3.14.39-xenomai-3.0.1 uhci_hcd
[    1.408019] usb usb5: Manufacturer: Linux 3.14.39-xenomai-3.0.1 uhci_hcd
[   10.885284] *** RTnet for Xenomai v3.0.1 ***
[85711.336919] CPU: 0 PID: 5252 Comm: smokey Tainted: GF            3.14.39=
-xenomai-3.0.1 #2
[85763.008077] CPU: 1 PID: 5257 Comm: smokey Tainted: GF            3.14.39=
-xenomai-3.0.1 #2"

The Result of latency test is
"root@cpc:/usr/xenomai/bin# ./latency -T 25
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      4.095|      5.830|     29.859|       0|     0|      4.095|     29=
.859
RTD|      4.127|      5.765|     30.023|       0|     0|      4.095|     30=
.023
RTD|      4.119|      5.860|     25.529|       0|     0|      4.095|     30=
.023
RTD|      4.247|      5.825|     29.474|       0|     0|      4.095|     30=
.023
RTD|      4.375|      5.949|     23.356|       0|     0|      4.095|     30=
.023
RTD|      4.399|      6.095|     28.888|       0|     0|      4.095|     30=
.023
RTD|      4.571|      6.235|     29.531|       0|     0|      4.095|     30=
.023
RTD|      4.374|      6.422|     29.953|       0|     0|      4.095|     30=
.023
RTD|      4.221|      5.861|     29.573|       0|     0|      4.095|     30=
.023
RTD|      4.246|      5.657|     28.605|       0|     0|      4.095|     30=
.023
RTD|      4.255|      5.629|     25.798|       0|     0|      4.095|     30=
.023
RTD|      4.281|      6.064|     25.575|       0|     0|      4.095|     30=
.023
RTD|      4.214|      6.076|     29.372|       0|     0|      4.095|     30=
.023
RTD|      4.327|      6.046|     17.176|       0|     0|      4.095|     30=
.023
RTD|      4.264|      6.061|     14.797|       0|     0|      4.095|     30=
.023
RTD|      4.321|      5.985|     26.089|       0|     0|      4.095|     30=
.023
RTD|      4.399|      6.068|     29.883|       0|     0|      4.095|     30=
.023
RTD|      4.212|      6.031|     29.233|       0|     0|      4.095|     30=
.023
RTD|      4.119|      5.679|     29.928|       0|     0|      4.095|     30=
.023
RTD|      4.121|      5.631|     30.013|       0|     0|      4.095|     30=
.023
RTD|      4.237|      5.530|     28.323|       0|     0|      4.095|     30=
.023
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      4.170|      5.599|     19.297|       0|     0|      4.095|     30=
.023
RTD|      4.066|      5.566|     28.642|       0|     0|      4.066|     30=
.023
RTD|      4.078|      5.543|     28.341|       0|     0|      4.066|     30=
.023
---|-----------|-----------|-----------|--------|------|-------------------=
------
RTS|      4.066|      5.875|     30.023|       0|     0|    00:00:25/00:00:=
25
root@cpc:/usr/xenomai/bin# "

But when i run the xeno-regression-test under load i get the following erro=
r
root@cpc:/usr/lib/xenomai/testsuite# xeno-regression-test -l "dohell -s 192=
.168.0.5 -m /mnt -l /ltp" -t 2
Started child 6467: /bin/bash /usr/lib/xenomai/testsuite/xeno-test-run-wrap=
per /usr/bin/xeno-regression-test -t 2
++ echo 0
++ /usr/lib/xenomai/testsuite/arith
Xenomai: /dev/rtheap is missing
(chardev, major=3D10 minor=3D254)

What does "Xenomai: /dev/rtheap is missing" means and how i can solve the e=
rror.
Moreover i run the command

"root@cpc:/usr/xenomai/bin# ./xeno-test -l "dohell 900"
Started child 28460: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper ./xen=
o-test
++ echo 0
++ testdir=3D/usr/xenomai/bin
++ /usr/xenomai/bin/smokey --run
arith OK
bufp skipped (no kernel support)
iddp skipped (no kernel support)
leaks OK
posix_clock OK
posix_cond OK
posix_fork OK
mutex_trylock not supported
posix_mutex OK
posix_select OK
rtdm skipped (no kernel support)
sched_quota skipped (no kernel support)
sched_tp skipped (no kernel support)
sigdebug skipped (no kernel support)
timerfd OK
tsc OK
vdso_access OK
xddp skipped (no kernel support)
++ /usr/xenomai/bin/clocktest -D -T 30 -C CLOCK_HOST_REALTIME
hostrt data area is live
sequence counter : 24184576
wall_time_sec    : 1447331688
wall_time_nsec   : 776750046
wall_to_monotonic_sec    : -1447241764
wall_to_monotonic_nsec   : 930460366
cycle_last       : 287110564373409
mask             : 0xffffffffffffffff
mult             : 5256009
shift            : 24
=3D=3D Testing built-in CLOCK_HOST_REALTIME (32)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  0.9           -0.005          0            0.0
  1                  1.2            0.006          0            0.0
++ /usr/xenomai/bin/switchtest -T 30
=3D=3D Testing FPU check routines...
r0: 1 !=3D 2
r1: 1 !=3D 2
r2: 1 !=3D 2
r3: 1 !=3D 2
r4: 1 !=3D 2
r5: 1 !=3D 2
r6: 1 !=3D 2
r7: 1 !=3D 2
xmm0: 1 !=3D 2
xmm1: 1 !=3D 2
xmm2: 1 !=3D 2
xmm3: 1 !=3D 2
xmm4: 1 !=3D 2
xmm5: 1 !=3D 2
xmm6: 1 !=3D 2
xmm7: 1 !=3D 2
=3D=3D FPU check routines: OK.
..............
.
.
.
.
.
.
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      4.310|      6.006|     13.112|       0|     0|      3.529|     34=
.845
Load script terminated, terminating checked scripts
---|-----------|-----------|-----------|--------|------|-------------------=
------
RTS|      3.529|      5.872|     34.845|       0|     0|    00:15:04/00:15:=
04
pipe_in: /tmp/xeno-test-in-15239"

In the result of the test i found that "rtdm skipped (no kernel support)", =
is this a problem because i have read that xenomai uses RTDM service for th=
e drivers. I want to use the rt_8139too and if rtdm is not supported will i=
t work fine or not?

Please tell me if i have installed the Xenomai 3.0.1 with kernel 3.14.30 pa=
tch properly along with Rtnet drivers. Or tell me if i can perform any test=
 to RTnet driver or anything else.


Thanks & Regards
Ali

