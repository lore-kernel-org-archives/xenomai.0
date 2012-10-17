MIME-Version: 1.0
From: Amit Goradia <amit@automatasystems.com>
Date: Wed, 17 Oct 2012 12:42:16 +0530
Message-ID: <CAG_j_bA-8b-jkuaLR29bWF92aq=iD1YAfx_844mAq2w9oMhkSg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Trouble running native examples
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I have installed Ubuntu 12.04, with kernel 3.2.21 patched with xenomai-2.6.1

Xenomai installation is confirmed by output of dmesg | grep Xenomai

automata@automata-xenomai:/usr/xenomai/bin$ dmesg | grep Xenomai
[    0.614338] I-pipe: head domain Xenomai registered.
[    0.614398] Xenomai: hal/i386 started.
[    0.614438] Xenomai: scheduling class idle registered.
[    0.614444] Xenomai: scheduling class rt registered.
[    0.617750] Xenomai: real-time nucleus v2.6.1 (Light Years Away) loaded.
[    0.617758] Xenomai: debug mode enabled.
[    0.618082] Xenomai: starting native API services.
[    0.618089] Xenomai: starting POSIX services.
[    0.618148] Xenomai: starting RTDM services.

I have also compiled the xenomai libraries and binaries and they are
installed in /usr/xenomai

I can run xeno-test and latency test:


automata@automata-xenomai:/usr/xenomai/bin$ sudo xeno-test
[sudo] password for automata:
sudo: xeno-test: command not found
automata@automata-xenomai:/usr/xenomai/bin$ sudo ./xeno-test
Started child 19191: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper
./xeno-test
++ echo 0
++ /usr/xenomai/bin/arith
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 24.552 ns, rejected 8/10000
inlined llimd: 0x79364d9364d9362f: 84.518 ns, rejected 2/10000
inlined llmulshft: 0x79364d92ffffffe1: 29.296 ns, rejected 1/10000
inlined nodiv_llimd: 0x79364d9364d9362f: 49.936 ns, rejected 4/10000
out of line calibration: 0x0000000000000000: 30.676 ns, rejected 2/10000
out of line llimd: 0x79364d9364d9362f: 98.387 ns, rejected 1/10000
out of line llmulshft: 0x79364d92ffffffe1: 31.840 ns, rejected 1/10000
out of line nodiv_llimd: 0x79364d9364d9362f: 64.135 ns, rejected 3/10000

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 24.324 ns, rejected 34/10000
inlined llimd: 0x86c9b26c9b26c9d1: 97.735 ns, rejected 1/10000
inlined llmulshft: 0x86c9b26d0000001e: 29.303 ns, rejected 0/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 60.508 ns, rejected 3/10000
out of line calibration: 0x0000000000000000: 30.666 ns, rejected 0/10000
out of line llimd: 0x86c9b26c9b26c9d1: 106.155 ns, rejected 1/10000
out of line llmulshft: 0x86c9b26d0000001e: 34.611 ns, rejected 1/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 71.221 ns, rejected 4/10000

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 24.546 ns, rejected 8/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 49.761 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 30.513 ns, rejected 1/10000
out of line nodiv_ullimd: 0x79364d9364d9362f: 59.564 ns, rejected 1/10000
++ /usr/xenomai/bin/clocktest -C 42 -T 30
== Tested clock: 42 (CLOCK_HOST_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  1.1           -0.000          0            0.0
  1                  1.0            0.013          0            0.0
++ /usr/xenomai/bin/switchtest -T 30
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
== Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10
rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16
rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21
rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2 rtk_fp1-3 rtk_fp1-4
rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8 rtup_ufpp1-9 rtup_ufpp1-10
rtus1-11 rtus1-12 rtus_ufps1-13 rtus_ufps1-14 rtuo1-15 rtuo1-16
rtuo_ufpp1-17 rtuo_ufpp1-18 rtuo_ufps1-19 rtuo_ufps1-20 rtuo_ufpp_ufps1-21
rtuo_ufpp_ufps1-22
RTT|  00:00:01
RTH|---------cpu|ctx switches|-------total
RTD|           1|       23975|       23975
RTD|           0|       24544|       24544
RTD|           0|       24529|       49073
RTD|           1|       23710|       47685
RTD|           1|       23654|       71339
RTD|           0|       23960|       73033
RTD|           1|       24667|       96006
RTD|           0|       25501|       98534
RTD|           1|       23564|      119570
RTD|           0|       24544|      123078
RTD|           1|       23299|      142869
RTD|           0|       24276|      147354
RTD|           1|       23857|      166726
RTD|           0|       24317|      171671
RTD|           1|       23395|      190121
RTD|           0|       24469|      196140
RTD|           1|       23556|      213677
RTD|           0|       24032|      220172
RTD|           1|       23686|      237363
RTD|           0|       24138|      244310
RTD|           1|       24376|      261739
RTT|  00:00:11
RTH|---------cpu|ctx switches|-------total
RTD|           0|       24581|      268891
RTD|           1|       24092|      285831
RTD|           0|       24527|      293418
RTD|           1|       24173|      310004
RTD|           0|       25045|      318463
RTD|           1|       24170|      334174
RTD|           0|       24444|      342907
RTD|           1|       23736|      357910
RTD|           0|       24445|      367352
RTD|           1|       23236|      381146
RTD|           0|       24721|      392073
RTD|           1|       23578|      404724
RTD|           0|       24246|      416319
^CRTD|           0|        9981|      426300
RTD|           1|        9539|      414263


latency test also runs fine:
automata@automata-xenomai:/usr/xenomai/bin$ sudo ./latency -t1 -p25
== Sampling period: 25 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 25 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
worst
RTD|      1.517|      3.143|     17.557|       0|     0|      1.517|
17.557
RTD|      1.670|      3.075|     16.978|       0|     0|      1.517|
17.557
RTD|      1.521|      3.070|      6.853|       0|     0|      1.517|
17.557
RTD|      1.588|      3.056|      6.250|       0|     0|      1.517|
17.557
RTD|      1.668|      3.056|      5.917|       0|     0|      1.517|
17.55


Now For my problem... I cannot compile the examples in
xenomai-2.6.1/examples/native

running make in examples/native directory gives following:
automata@automata-xenomai:~/xenomai-2.6.1/examples/native$ make
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__   -lnative
-L/usr/xenomai/lib -lxenomai -lpthread -lrt  -Xlinker -rpath -Xlinker
/usr/xenomai/lib  trivial-periodic.c   -o trivial-periodic
/tmp/ccJuIj7p.o: In function `demo':
trivial-periodic.c:(.text+0x2f): undefined reference to
`rt_task_set_periodic'
trivial-periodic.c:(.text+0x34): undefined reference to `rt_timer_read'
trivial-periodic.c:(.text+0x46): undefined reference to
`rt_task_wait_period'
trivial-periodic.c:(.text+0x4b): undefined reference to `rt_timer_read'
/tmp/ccJuIj7p.o: In function `main':
trivial-periodic.c:(.text+0x133): undefined reference to `rt_task_create'
trivial-periodic.c:(.text+0x14f): undefined reference to `rt_task_start'
trivial-periodic.c:(.text+0x160): undefined reference to `rt_task_delete'
collect2: ld returned 1 exit status
make: *** [trivial-periodic] Error 1

xeno-config is installed properly: output of xeno-config

<xenomai@xenomai.org>automata@automata-xenomai:~/xenomai-2.6.1/examples/native$
/usr/xenomai/bin/xeno-config --v
xeno-config --verbose
        --version="2.6.1"
        --cc="gcc"
        --arch="x86"
        --prefix="/usr/xenomai"
        --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-D__XENO__"
        --xeno-ldflags="-L/usr/xenomai/lib -lxenomai -lpthread -lrt "
        --posix-cflags=""
        --posix-ldflags="-Wl,@/usr/xenomai/lib/posix.wrappers
-L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt "
        --library-dir="/usr/xenomai/lib"

So what am I doing wrong?

Any clues?

-amit
