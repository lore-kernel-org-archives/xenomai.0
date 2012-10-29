MIME-Version: 1.0
Date: Mon, 29 Oct 2012 10:42:04 -0300
Message-ID: <CANzNmi-kXK=iTb5z+4Uk0Er=noAWuHK32_vLFMfto4uEHjbuLQ@mail.gmail.com>
From: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Executing latency test and xeno-test, doubts.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi everyone.

I finally boot the kernel 3.2.32 with xenomai-2.6.1 on ubuntu 12.04. Based
on the "Testing the installation" item of Installing Xenomai documentation,
I got this.

Kernel boot log:
Oct 26 14:53:30 labcontrol kernel: [    2.541649] I-pipe: head domain
Xenomai registered.
Oct 26 14:53:30 labcontrol kernel: [    2.541725] Xenomai: hal/i386 started=
.
Oct 26 14:53:30 labcontrol kernel: [    2.541741] Xenomai: scheduling class
idle registered.
Oct 26 14:53:30 labcontrol kernel: [    2.541743] Xenomai: scheduling class
rt registered.
Oct 26 14:53:30 labcontrol kernel: [    2.542578] Xenomai: real-time
nucleus v2.6.1 (Light Years Away) loaded.
Oct 26 14:53:30 labcontrol kernel: [    2.542581] Xenomai: debug mode
enabled.
Oct 26 14:53:30 labcontrol kernel: [    2.542703] Xenomai: starting native
API services.
Oct 26 14:53:30 labcontrol kernel: [    2.542706] Xenomai: starting POSIX
services.
Oct 26 14:53:30 labcontrol kernel: [    2.542722] Xenomai: starting RTDM
services.

Latency Test:
root@labcontrol:~# /usr/xenomai/bin/latency
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
worst
RTD|      1.354|      2.616|      4.097|       0|     0|      1.354|
4.097
RTD|      1.069|      2.553|     12.015|       0|     0|      1.069|
12.015
RTD|      1.063|      2.617|      4.512|       0|     0|      1.063|
12.015
RTD|      1.132|      2.546|     13.290|       0|     0|      1.063|
13.290
RTD|      1.063|      2.524|     12.825|       0|     0|      1.063|
13.290
RTD|      1.094|      2.601|     13.092|       0|     0|      1.063|
13.290
RTD|      1.097|      2.587|     11.524|       0|     0|      1.063|
13.290
RTD|      1.203|      2.615|     13.426|       0|     0|      1.063|
13.426
RTD|      1.166|      2.607|     12.328|       0|     0|      1.063|
13.426
RTD|      1.146|      2.613|     13.158|       0|     0|      1.063|
13.426
RTD|      1.139|      2.606|      5.602|       0|     0|      1.063|
13.426
RTD|      1.213|      2.607|     12.114|       0|     0|      1.063|
13.426
RTD|      1.082|      2.545|     11.071|       0|     0|      1.063|
13.426
RTD|      1.130|      2.609|     10.698|       0|     0|      1.063|
13.426
RTD|      1.102|      2.537|     10.324|       0|     0|      1.063|
13.426
RTD|      1.105|      2.574|     10.293|       0|     0|      1.063|
13.426
RTD|      1.239|      2.617|     12.573|       0|     0|      1.063|
13.426
RTD|      1.153|      2.611|     11.077|       0|     0|      1.063|
13.426
RTD|      1.208|      2.627|     13.032|       0|     0|      1.063|
13.426
RTD|      1.215|      2.659|     12.527|       0|     0|      1.063|
13.426
RTD|      1.299|      2.609|      4.786|       0|     0|      1.063|
13.426
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
worst
RTD|      1.062|      2.541|     11.934|       0|     0|      1.062|
13.426
RTD|      1.060|      2.534|      7.809|       0|     0|      1.060|
13.426
RTD|      1.064|      2.540|     13.680|       0|     0|      1.060|
13.680
RTD|      1.209|      2.608|      6.630|       0|     0|      1.060|
13.680
RTD|      1.063|      2.559|     13.341|       0|     0|      1.060|
13.680
RTD|      1.216|      2.654|     12.642|       0|     0|      1.060|
13.680
RTD|      1.221|      2.612|     12.053|       0|     0|      1.060|
13.680
RTD|      1.070|      2.603|     10.301|       0|     0|      1.060|
13.680
RTD|      1.225|      2.625|     11.803|       0|     0|      1.060|
13.680
RTD|      1.210|      2.611|     12.360|       0|     0|      1.060|
13.680
RTD|      1.213|      2.621|     12.197|       0|     0|      1.060|
13.680
RTD|      1.174|      2.574|     10.280|       0|     0|      1.060|
13.680
RTD|      1.056|      2.629|     11.961|       0|     0|      1.056|
13.680
RTD|      1.073|      2.629|     11.125|       0|     0|      1.056|
13.680
RTD|      1.130|      2.626|     11.132|       0|     0|      1.056|
13.680
RTD|      1.214|      2.622|     11.310|       0|     0|      1.056|
13.680
RTD|      1.053|      2.652|     13.693|       0|     0|      1.053|
13.693
RTD|      1.069|      2.686|     12.551|       0|     0|      1.053|
13.693
RTD|      1.097|      2.615|     13.125|       0|     0|      1.053|
13.693
RTD|      1.081|      2.628|     12.627|       0|     0|      1.053|
13.693
RTD|      1.157|      2.653|     12.888|       0|     0|      1.053|
13.693

xeno-test:
root@labcontrol:~# xeno-test
Started child 3133: /bin/bash /usr/lib/xenomai/xeno-test-run-wrapper
/usr/bin/xeno-test
++ echo 0
++ /usr/lib/xenomai/arith
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 7.942 ns, rejected 0/10000
inlined llimd: 0x79364d9364d9362f: 1.584 ns, rejected 0/10000
inlined llmulshft: 0x79364d92ffffffe1: 1.175 ns, rejected 0/10000
inlined nodiv_llimd: 0x79364d9364d9362f: 1.377 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 8.236 ns, rejected 0/10000
out of line llimd: 0x79364d9364d9362f: 4.253 ns, rejected 0/10000
out of line llmulshft: 0x79364d92ffffffe1: 3.123 ns, rejected 0/10000
out of line nodiv_llimd: 0x79364d9364d9362f: 5.297 ns, rejected 0/10000

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 7.999 ns, rejected 0/10000
inlined llimd: 0x86c9b26c9b26c9d1: 3.706 ns, rejected 0/10000
inlined llmulshft: 0x86c9b26d0000001e: 2.000 ns, rejected 0/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 3.389 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 7.942 ns, rejected 0/10000
out of line llimd: 0x86c9b26c9b26c9d1: 6.916 ns, rejected 0/10000
out of line llmulshft: 0x86c9b26d0000001e: 3.822 ns, rejected 0/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 5.888 ns, rejected 0/10000

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 7.923 ns, rejected 0/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 1.490 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 8.235 ns, rejected 0/10000
out of line nodiv_ullimd: 0x79364d9364d9362f: 5.296 ns, rejected 0/10000
++ /usr/lib/xenomai/clocktest -C 42 -T 30
=3D=3D Tested clock: 42 (CLOCK_HOST_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  1.0            0.020          0            0.0
  1                  0.8            0.004          0            0.0
  2                  1.0            0.006          0            0.0
  3                  0.7            0.001          0            0.0
  4                  1.1            0.013          0            0.0
  5                  0.8           -0.007          0            0.0
  6                  1.1            0.022          0            0.0
  7                  1.1           -0.000          0            0.0
++ /usr/lib/xenomai/switchtest -T 30
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
=3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10
rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16
rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21
rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2 rtk_fp1-3 rtk_fp1-4
rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8 rtup_ufpp1-9 rtup_ufpp1-10
rtus1-11 rtus1-12 rtus_ufps1-13 rtus_ufps1-14 rtuo1-15 rtuo1-16
rtuo_ufpp1-17 rtuo_ufpp1-18 rtuo_ufps1-19 rtuo_ufps1-20 rtuo_ufpp_ufps1-21
rtuo_ufpp_ufps1-22 sleeper_ufps2-0 rtk2-1 rtk2-2 rtk_fp2-3 rtk_fp2-4
rtk_fp_ufpp2-5 rtk_fp_ufpp2-6 rtup2-7 rtup2-8 rtup_ufpp2-9 rtup_ufpp2-10
rtus2-11 rtus2-12 rtus_ufps2-13 rtus_ufps2-14 rtuo2-15 rtuo2-16
rtuo_ufpp2-17 rtuo_ufpp2-18 rtuo_ufps2-19 rtuo_ufps2-20 rtuo_ufpp_ufps2-21
rtuo_ufpp_ufps2-22 sleeper_ufps3-0 rtk3-1 rtk3-2 rtk_fp3-3 rtk_fp3-4
rtk_fp_ufpp3-5 rtk_fp_ufpp3-6 rtup3-7 rtup3-8 rtup_ufpp3-9 rtup_ufpp3-10
rtus3-11 rtus3-12 rtus_ufps3-13 rtus_ufps3-14
ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory
rtuo3-15 rtuo3-16 rtuo_ufpp3-17 rtuo_ufpp3-18 rtuo_ufps3-19 rtuo_ufps3-20
rtuo_ufpp_ufps3-21 rtuo_ufpp_ufps3-22 sleeper_ufps4-0 rtk4-1 rtk4-2
rtk_fp4-3 rtk_fp4-4 rtk_fp_ufpp4-5 rtk_fp_ufpp4-6 rtup4-7 rtup4-8
rtup_ufpp4-9 rtup_ufpp4-10 rtus4-11 rtus4-12 rtus_ufps4-13 rtus_ufps4-14
rtuo4-15 rtuo4-16 rtuo_ufpp4-17 rtuo_ufpp4-18 rtuo_ufps4-19 rtuo_ufps4-20
rtuo_ufpp_ufps4-21 rtuo_ufpp_ufps4-22 sleeper_ufps5-0 rtk5-1RTT|
375421:34:30
RTH|---------cpu|ctx switches|-------total
RTD|           0|           0|           0
RTD|           1|           0|           0
RTD|           2|           0|           0
RTD|           3|           0|           0
RTD|           4|           0|           0
RTD|           5|           0|           0


Before I couldnt execute the xeno-test due to a problem with the version of
xenomai-runtime. Now I don't know exactly how to interpret this results.
Also the rejected stuff I get don't know the meaning and what should I have
to do to get it ok.

For instance:
signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 7.942 ns, rejected 0/10000
inlined llimd: 0x79364d9364d9362f: 1.584 ns, rejected 0/10000

Other doubt I have, what should I have to check before I could start
programming on Xenomai?? I'm an absolutely newbie on RT stuff and Linux, so
some insights will be appreciated.

Thank you in advance.
Sebasti=E1n.
