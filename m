MIME-Version: 1.0
Date: Tue, 20 Mar 2012 13:19:07 +0530
Message-ID: <CAM1yFZ9Dc6d_tzBfuho+ZHx8EDjAs1TbXOjM5EMU_wwhgFWFBg@domain.hid>
From: Anisha Kaul <born.rebel.83@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] How to view the latency of my hello world program?
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

Greetings,

Distribution: OpenSuse 11.2
Kernel: 2.6.35
64bit

I have compiled the hello world program shown at the bottom of this
link: http://www.cs.ru.nl/lab/xenomai/exercises/ex01/Exercise-1.html
It has compiled successfully.

I want to see its latency.

I am aware of the program "/usr/xenomai/bin/xeno-test" but I can't
understand its output.

I ran `xeno-test` as follows:
Now, the problem is that it shows a similar kind of output when I run
it without the executable "./hello".
How should I make out that it is currently showing the latencies of
"./hello", and not of some other program which may also be running in
real time?

Is this the proper way to run the program?


anisha@domain.hid:~/> sudo /usr/xenomai/bin/xeno-test ./hello
Started child 17539: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper
/usr/xenomai/bin/xeno-test ./hello
++ echo 0
++ /usr/xenomai/bin/arith
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 13.944 ns, rejected 0/10000
inlined llimd: 0x79364d9364d9362f: 30.394 ns, rejected 1/10000
inlined llmulshft: 0x79364d92ffffffe1: 0.115 ns, rejected 0/10000
inlined nodiv_llimd: 0x79364d9364d9362f: 1.585 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 15.021 ns, rejected 1/10000
out of line llimd: 0x79364d9364d9362f: 33.964 ns, rejected 1/10000
out of line llmulshft: 0x79364d92ffffffe1: 1.069 ns, rejected 0/10000
out of line nodiv_llimd: 0x79364d9364d9362f: 1.252 ns, rejected 0/10000

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 13.947 ns, rejected 0/10000
inlined llimd: 0x86c9b26c9b26c9d1: 31.466 ns, rejected 1/10000
inlined llmulshft: 0x86c9b26d0000001e: 1.068 ns, rejected 0/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 2.161 ns, rejected 1/10000
out of line calibration: 0x0000000000000000: 15.018 ns, rejected 0/10000
out of line llimd: 0x86c9b26c9b26c9d1: 36.762 ns, rejected 1/10000
out of line llmulshft: 0x86c9b26d0000001e: 1.073 ns, rejected 0/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 1.788 ns, rejected 1/10000

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 13.945 ns, rejected 0/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 1.072 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 15.017 ns, rejected 0/10000
out of line nodiv_ullimd: 0x79364d9364d9362f: 1.074 ns, rejected 0/10000
++ /usr/xenomai/bin/clocktest -T 30
== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  0.4           -0.002          0            0.0
  1                  0.2            0.000          0            0.0
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
rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9
rtup_ufpp0-10 rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15
rtuo0-16 rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20
rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2
rtk_fp1-3 rtk_fp1-4 rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8
rtup_ufpp1-9 rtup_ufpp1-10 rtus1-11 rtus1-12 rtus_ufps1-13
rtus_ufps1-14 rtuo1-15 rtuo1-16 rtuo_ufpp1-17 rtuo_ufpp1-18
rtuo_ufps1-19 rtuo_ufps1-20 rtuo_ufpp_ufps1-21 rtuo_ufpp_ufps1-22
RTT|  00:00:01
RTH|---------cpu|ctx switches|-------total
RTD|           0|       28861|       28861
RTD|           1|       29044|       29044
RTD|           0|       29288|       58149
RTD|           1|       29105|       58149
RTD|           0|       29820|       87969
RTD|           1|       29871|       88020
RTD|           0|       29480|      117449
RTD|           1|       29679|      117699
RTD|           0|       29162|      146611
RTD|           1|       28891|      146590
RTD|           0|       28635|      175246
RTD|           1|       28925|      175515
RTD|           0|       28748|      203994
RTD|           1|       29055|      204570
RTD|           0|       28553|      232547
RTD|           1|       29071|      233641
RTD|           0|       29379|      261926
RTD|           1|       28877|      262518
RTD|           0|       28762|      290688
RTD|           1|       30448|      292966
RTD|           0|       29457|      320145
RTT|  00:00:11
RTH|---------cpu|ctx switches|-------total
RTD|           1|       30139|      323105
RTD|           0|       28492|      348637
RTD|           1|       30053|      353158
RTD|           0|       28813|      377450
RTD|           1|       29658|      382816
RTD|           0|       29002|      406452
RTD|           1|       30227|      413043
RTD|           1|       29287|      442330
RTD|           0|       28302|      434754
RTD|           1|       29357|      471687
RTD|           0|       29567|      464321
RTD|           1|       28746|      500433
RTD|           0|       29082|      493403
RTD|           1|       29400|      529833
RTD|           0|       28869|      522272
RTD|           1|       29367|      559200
RTD|           0|       30079|      552351
RTD|           1|       29375|      588575
RTD|           0|       29744|      582095
RTD|           1|       28612|      617187
RTD|           0|       28791|      610886
RTT|  00:00:22
RTH|---------cpu|ctx switches|-------total
RTD|           1|       29068|      646255
RTD|           0|       29700|      640586
RTD|           1|       29836|      676091
RTD|           0|       29569|      670155
RTD|           0|       29944|      700099
RTD|           1|       28755|      704846
RTD|           1|       29322|      734168
RTD|           0|       29737|      729836
RTD|           0|       29489|      759325
RTD|           1|       28781|      762949
RTD|           0|       28986|      788311
RTD|           1|       29337|      792286
RTD|           0|       27766|      816077
RTD|           1|       29368|      821654
RTD|           0|       29333|      845410
RTD|           1|       30778|      852432
RTD|           0|       24167|      869577
RTD|           1|       24471|      876903
++ /usr/xenomai/bin/cond-torture-native
simple_condwait
relative_condwait
absolute_condwait
sig_norestart_condwait
sig_restart_condwait
sig_norestart_condwait_mutex
sig_restart_condwait_mutex
sig_norestart_double
sig_restart_double
cond_destroy_whilewait
Test OK
++ /usr/xenomai/bin/cond-torture-posix
simple_condwait
relative_condwait
absolute_condwait
sig_norestart_condwait
sig_restart_condwait
sig_norestart_condwait_mutex
sig_restart_condwait_mutex
sig_norestart_double
Test OK
sig_restart_double
cond_destroy_whilewait
++ /usr/xenomai/bin/mutex-torture-native
simple_wait
recursive_wait
timed_mutex
mode_switch
pi_wait
lock_stealing
NOTE: lock_stealing mutex_trylock: not supported
deny_stealing
simple_condwait
recursive_condwait
Test OK
++ /usr/xenomai/bin/mutex-torture-posix
simple_wait
recursive_wait
errorcheck_wait
timed_mutex
mode_switch
pi_wait
lock_stealing
NOTE: lock_stealing mutex_trylock: not supported
deny_stealing
simple_condwait
recursive_condwait
Test OK
++ start_load
++ echo start_load
++ check_alive /usr/xenomai/bin/latency ./hello
++ echo check_alive /usr/xenomai/bin/latency ./hello
++ wait_load
++ read rc
Started child 6977: dohell 900
Started child 6980: /usr/xenomai/bin/latency ./hello
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      1.012|      1.817|      6.697|       0|     0|      1.012|      6.697
RTD|      1.332|      1.823|      8.437|       0|     0|      1.012|      8.437
RTD|      1.325|      1.778|      7.855|       0|     0|      1.012|      8.437
RTD|      1.326|      1.765|      6.118|       0|     0|      1.012|      8.437
RTD|      1.326|      1.797|      6.740|       0|     0|      1.012|      8.437
RTD|      1.326|      1.808|      6.343|       0|     0|      1.012|      8.437
RTD|      1.332|      1.817|      6.775|       0|     0|      1.012|      8.437
RTD|      1.327|      1.827|      7.348|       0|     0|      1.012|      8.437
RTD|      1.330|      1.785|      5.875|       0|     0|      1.012|      8.437
RTD|      1.333|      1.813|      6.026|       0|     0|      1.012|      8.437
RTD|      1.333|      1.808|      5.231|       0|     0|      1.012|      8.437
RTD|      1.333|      1.809|      6.117|       0|     0|      1.012|      8.437
RTD|      1.330|      1.806|      5.781|       0|     0|      1.012|      8.437
RTD|      1.331|      1.782|      6.503|       0|     0|      1.012|      8.437
RTD|      1.328|      1.832|      6.247|       0|     0|      1.012|      8.437
RTD|      1.325|      1.813|      6.526|       0|     0|      1.012|      8.437
RTD|      1.326|      1.784|      5.620|       0|     0|      1.012|      8.437
RTD|      1.326|      1.796|      5.787|       0|     0|      1.012|      8.437
RTD|      1.329|      1.812|     11.857|       0|     0|      1.012|     11.857
RTD|      1.331|      1.882|     10.116|       0|     0|      1.012|     11.857
RTD|      1.326|      1.826|      6.887|       0|     0|      1.012|     11.857
RTT|  00:00:22  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      1.327|      1.738|      8.136|       0|     0|      1.012|     11.857
RTD|      1.325|      1.780|      9.407|       0|     0|      1.012|     11.857
RTD|      1.324|      1.765|      6.428|       0|     0|      1.012|     11.857
RTD|      1.327|      1.689|      6.782|       0|     0|      1.012|     11.857
RTD|      1.328|      1.767|      8.389|       0|     0|      1.012|     11.857
RTD|      1.322|      1.701|      6.389|       0|     0|      1.012|     11.857
RTD|      1.325|      1.770|      6.007|       0|     0|      1.012|     11.857
RTD|      1.329|      1.729|      6.840|       0|     0|      1.012|     11.857
RTD|      1.330|      1.791|      6.473|       0|     0|      1.012|     11.857
RTD|      1.328|      1.779|      6.220|       0|     0|      1.012|     11.857
RTD|      1.188|      1.757|      7.541|       0|     0|      1.012|     11.857
RTD|      1.329|      1.826|      6.254|       0|     0|      1.012|     11.857
RTD|      1.061|      1.829|      8.637|       0|     0|      1.012|     11.857
RTD|      1.333|      1.935|      7.617|       0|     0|      1.012|     11.857
RTD|      1.345|      2.004|      6.537|       0|     0|      1.012|     11.857
RTD|      1.339|      1.955|      5.759|       0|     0|      1.012|     11.857
RTD|      1.327|      1.967|      5.556|       0|     0|      1.012|     11.857
^C---|-----------|-----------|-----------|--------|------|-------------------------
RTS|      1.012|      1.809|     11.857|       0|     0|    00:00:38/00:00:38



--Anisha

