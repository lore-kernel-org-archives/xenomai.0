From: Travis Stratman <tstratman@domain.hid>
Date: Tue, 29 Apr 2008 18:34:40 -0500
Message-Id: <1209512080.1662.311.camel@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Latency test locking AT91 system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai Help List <xenomai@xenomai.org>

Hello,

I am working on getting Xenomai running on a board using the AT91SAM9260
processor. The actual hardware on the board is very similar to the
AT91SAM9260EK.

I was able to patch and build the kernel and userspace without a
problem. However, when I run the latency test, I often see the board
lockup. I'm using 2.4.3 and the 2.6.20 adeos patch. I compiled all of
the xenomai features that I needed into the kernel rather than building
them as modules. I am using a GCC-4.1.1 EABI compiler and enabled the
arm-eabi in configure. I have configured with and without the arm-tsc
support.

If I run the xeno-test script, everything seems fine until I get to the
latency test, where it hangs, generally after printing "warming up..."
but it doesn't always get that far. When I turn debugging on in the
kernel configuration, the watchdog will kill the thread. If I run
latency on its own, with or without dd load, I can sometimes get it to
run and other times it fails before the first data is printed or after
the first few tests. Sometimes it just seems to hang and then starts
printing again after about 30 seconds or so, usually stopping later.

The klatency test only works the first time that I run it, all further
tests cause a segmentation fault. Here is the strace of the last few
calls on klatency when it does fail:
gettimeofday({1209511560, 302399}, NULL) = 0
rt_sigaction(SIGINT, {0x88c8, [INT], SA_RESTART|0x4000000}, {SIG_DFL},
8) = 0
rt_sigaction(SIGTERM, {0x88c8, [TERM], SA_RESTART|0x4000000}, {SIG_DFL},
8) = 0
rt_sigaction(SIGHUP, {0x88c8, [HUP], SA_RESTART|0x4000000}, {SIG_DFL},
8) = 0
rt_sigaction(SIGALRM, {0x88c8, [ALRM], SA_RESTART|0x4000000}, {SIG_DFL},
8) = 0
open("/proc/xenomai/registry/native/pipes/klat_pipe", O_RDONLY) = 3
read(3, "#C\0\0\0\0\0\0\220\1\0\0\321q\0\0\0\0\0\0\0\0\0\0\362\204"...,
32) = 32
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++
Process 854 detached
---

I am doing more testing running latency as a kernel task and timer irq
task. From what I've seen, these modes seem to work. However, running it
as a kernel task reports a huge number of overruns. Irq task works and
has very low latencies.

To start off, are there some other posts that I should look at that I
haven't been able to find yet? Are there some configuration options that
could cause this that I may have overlooked? If not, what would you
recommend as the next step for debugging this? I've pasted the results
of some of the other tests that work below and can provide any other
information/configs that might be helpful.

I appreciate any help that anyone can give.

Thanks,

TAS
----
# clocktest
== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0  -1209510812788028.5            8.139          0            0.0

# cyclictest
0.79 0.47 0.18 1/27 848

T: 0 (  848) P:99 I:    1000 C:    5905 Min:      70 Act:      73 Avg:
82 Max:     179

# switchtest
== Testing FPU check routines...
== FPU check routines: unimplemented, skipping FPU switches tests.
== Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7
rtuo-8
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|         885|         885
RTD|         906|        1791
RTD|         894|        2685
RTD|         915|        3600
RTD|         909|        4509
RTD|         900|        5409
RTD|         576|        5985


# switchbench
== Sampling period: 100 us
== Do not interrupt this program
RTH|     lat min|     lat avg|     lat max|        lost
RTD|    -161.082|      22.229|      67.654|       35279

# dd if=/dev/zero of=/dev/null &
# klatency
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
warming up...
RTT|  00:00:00  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|      -2.515|      -0.778|       5.733|       0|      -2.515|
5.733
RTD|      -2.515|      -0.577|       9.018|       0|      -2.515|
9.018
RTD|      -2.323|       4.441|      15.332|       0|      -2.515|
15.332
RTD|      -2.517|       0.802|      15.202|       0|      -2.517|
15.332
RTD|      -2.324|       1.652|      24.867|       0|      -2.517|
24.867
RTD|      -2.260|       5.207|      19.841|       0|      -2.517|
24.867
RTD|      -2.261|       4.901|      20.484|       0|      -2.517|
24.867
RTD|      -1.488|       5.892|      19.775|       0|      -2.517|
24.867
RTD|      -1.231|       5.763|      19.967|       0|      -2.517|
24.867
RTD|      -0.781|       5.878|      20.160|       0|      -2.517|
24.867
RTD|       1.022|       5.959|      19.257|       0|      -2.517|
24.867
RTD|      -0.460|       5.964|      19.063|       0|      -2.517|
24.867
RTD|       0.570|       5.926|      19.836|       0|      -2.517|
24.867
RTD|      -1.879|       6.007|      20.286|       0|      -2.517|
24.867
RTD|      -2.267|       5.782|      19.834|       0|      -2.517|
24.867
RTD|      -1.043|       5.926|      19.897|       0|      -2.517|
24.867
RTD|      -0.980|       5.884|      20.863|       0|      -2.517|
24.867
RTD|      -0.980|       5.927|      20.605|       0|      -2.517|
24.867
RTD|      -0.980|       5.789|      19.573|       0|      -2.517|
24.867
RTD|      -2.206|       5.742|      25.178|       0|      -2.517|
25.178
RTD|      -2.271|       5.646|      19.959|       0|      -2.517|
25.178
RTT|  00:00:00  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|       0.692|       5.978|      18.927|       0|      -2.517|
25.178
RTD|      -1.563|       5.901|      18.733|       0|      -2.517|
25.178
RTD|      -1.822|      13.016|      24.145|       0|      -2.517|
25.178
RTD|       2.623|      17.495|      26.722|       0|      -2.517|
26.722
RTD|      -2.274|      17.400|      25.367|       0|      -2.517|
26.722
RTD|       2.042|      17.498|      23.885|       0|      -2.517|
26.722
RTD|       9.451|      17.493|      25.559|       0|      -2.517|
26.722
RTD|       2.492|      17.498|      31.229|       0|      -2.517|
31.229
RTD|      -1.440|      13.053|      29.166|       0|      -2.517|
31.229
RTD|      -2.278|       2.498|      20.338|       0|      -2.517|
31.229
RTD|      -2.279|       1.186|      13.443|       0|      -2.517|
31.229
RTD|      -2.280|       4.893|      24.203|       0|      -2.517|
31.229
RTD|      -2.087|       5.470|      19.820|       0|      -2.517|
31.229
RTD|      -2.216|       9.991|      33.930|       0|      -2.517|
33.930
RTD|       9.123|      17.493|      24.652|       0|      -2.517|
33.930
RTD|       3.710|      17.502|      23.620|       0|      -2.517|
33.930
RTD|       0.939|      17.377|      25.939|       0|      -2.517|
33.930
RTD|       0.229|      16.052|      24.328|       0|      -2.517|
33.930
RTD|       1.002|      17.430|      25.357|       0|      -2.517|
33.930
RTD|       3.708|      17.486|      26.259|       0|      -2.517|
33.930
RTD|       6.477|      17.493|      24.003|       0|      -2.517|
33.930
RTT|  00:00:00  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|       2.675|      17.478|      23.551|       0|      -2.517|
33.930
RTD|       5.509|      17.487|      25.870|       0|      -2.517|
33.930
RTD|       2.480|      17.492|      27.480|       0|      -2.517|
33.930
RTD|       5.508|      17.482|      25.289|       0|      -2.517|
33.930
RTD|       3.381|      17.474|      23.226|       0|      -2.517|
33.930
RTD|       4.540|      17.479|      24.901|       0|      -2.517|
33.930
RTD|       4.217|      17.476|      28.122|       0|      -2.517|
33.930
RTD|       7.051|      17.479|      26.575|       0|      -2.517|
33.930
RTD|       4.151|      17.473|      23.675|       0|      -2.517|
33.930
RTD|       9.627|      17.476|      25.285|       0|      -2.517|
33.930
RTD|      -0.039|      16.884|      26.573|       0|      -2.517|
33.930
RTD|       7.693|      17.484|      24.961|       0|      -2.517|
33.930
RTD|      -1.650|      16.100|      24.832|       0|      -2.517|
33.930
RTD|       4.212|      17.473|      21.223|       0|      -2.517|
33.930
RTD|       4.018|      17.465|      24.444|       0|      -2.517|
33.930
RTD|       5.306|      17.478|      23.476|       0|      -2.517|
33.930
RTD|       3.566|      17.499|      25.151|       0|      -2.517|
33.930
RTD|       5.176|      17.467|      25.601|       0|      -2.517|
33.930
RTD|       2.920|      17.474|      29.402|       0|      -2.517|
33.930
RTD|       4.079|      17.450|      30.818|       0|      -2.517|
33.930
RTD|       1.372|      16.651|      24.182|       0|      -2.517|
33.930
RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|      -2.166|       0.402|      14.651|       0|      -8.182|
64.140
RTD|      -1.780|       0.111|      15.810|       0|      -8.182|






