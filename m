Message-ID: <1486369782.6133.13.camel@smigroup.net>
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Mon, 06 Feb 2017 09:29:42 +0100
In-Reply-To: <2f2b2c8e-96a2-9f12-6af1-b23a9343ab95@xenomai.org>
References: <1485939628.4068.25.camel@smigroup.net>
 <2f2b2c8e-96a2-9f12-6af1-b23a9343ab95@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting Xenomai on iMX6SX
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

On Thu, 2017-02-02 at 10:52 +0100, Philippe Gerum wrote:
> On 02/01/2017 10:00 AM, Mauro Salvini wrote:
> > Hi,
> > I'm trying to use an iMX6SX custom board with Xenomai.
> > I'm able to patch the 4.1 kernel from Freescale community (based on
> > 4.1.15_1.2.0 branch from NXP and merged with 4.1.y branch from mainline)
> > with some little rejections resolved by hand.
> > 
> > Kernel boots but Xenomai tests point out some weird behaviors (e.g.
> > minimum latencies that constantly decreases by 0.001 us every 4 seconds,
> > clocktest that reports ~10ms deltas and warps, maximum latencies that
> > increases with larger sample periods, etc), so I started to read [1] to
> > figure out what I'm missing.
> > 
> > Firstly I found that iMX6SX devicetree does not list global and twd
> > timers. Adding these to dts solves some problems related to latencies.
> > Now in my dmesg I see:
> > [    0.000033] I-pipe, 3.000 MHz clocksource, wrap in 1431655 ms
> > [    0.000046] clocksource ipipe_tsc: mask: 0xffffffffffffffff
> > max_cycles: 0x1623fa770, max_idle_ns: 881590404476 ns
> > [    0.000943] I-pipe, 396.000 MHz clocksource, wrap in 10845 ms
> > [    0.000955] clocksource ipipe_tsc: mask: 0xffffffffffffffff
> > max_cycles: 0x5b5469468b, max_idle_ns: 440795218345 ns
> > .....
> > [    0.080436] Switched to clocksource ipipe_tsc
> > 
> > Following [1] I found that hardware timer isn't actually used on my
> > board, because is used only if CONFIG_SMP is selected (I disabled SMP
> > support because I have only one core and I noticed that SMP support
> > increases real-time latencies).
> > 
> > So, SMP support is mandatory or could be avoided and a modification to
> > ipipe is required?
> >
> 
> No, SMP is not mandatory. The current I-pipe works fine on SX as well.
> However, timing services are normally obtained from the mxc timer on
> single core configurations with 4.1 kernels and earlier
> (arch/arm/mach-imx/time.c), twd are per-CPU timers only enabled with
> multi-core systems there.
> 

Thank you Philippe for your clarification.
So, if I correctly understood, arm-global-timer and arm-twd-timer are
not needed for single core, because both tsc and ipipe timer are based
on mxs_timer.

I restarted my tests from scratch: my current situation is SMP
enabled, arm-global-timer and arm-twd-timer not configured in dts.
I'm using the SabreSD board from Freescale.

On system boot I can see:

[    0.000000] mxc_clocksource_init 3000000
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000006] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps
every 715827882841ns
[    0.000021] clocksource mxc_timer1: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 637086815595 ns
[    0.000034] I-pipe, 3.000 MHz clocksource, wrap in 1431655 ms
[    0.000047] clocksource ipipe_tsc: mask: 0xffffffffffffffff
max_cycles: 0x1623fa770, max_idle_ns: 881590404476 ns
[    0.001602] Interrupt pipeline (release #4)
...
[    0.001745] Calibrating delay loop (skipped), value calculated using
timer frequency.. 6.00 BogoMIPS (lpj=30000)
...
[    0.170645] I-pipe: disabling SMP code
...
[    0.228650] Switched to clocksource ipipe_tsc
...
[    0.247029] [Xenomai] scheduling class idle registered.
[    0.247037] [Xenomai] scheduling class rt registered.
[    0.247186] I-pipe: head domain Xenomai registered.

When I run latency test I observe two strange behaviors:

- the first is that if I change the default sampling period value
(1000us) to 100us, maximum and average latencies significantly decrease
(average from ~27us to ~14us, and maximum from ~40us to ~28us). Is it
normal? I don't observe this on an old x86 machine (but that runs
xenomai 2.5). By the way, I see in configure script that ARM is the only
arch that has a default sampling period at 1000us (other archs are
100us).

- the second is that minimum latencies constantly decrease by 0.001us at
every 4 iterations (with random spurious values sometimes), instead of
changing between each iteration as usual (here an example, last two
columns are cut away for readability):

RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|
RTD|      9.667|     27.180|     39.667|       0|     0|
RTD|      9.667|     26.502|     39.333|       0|     0|
RTD|      9.666|     27.454|     39.333|       0|     0|
RTD|      9.666|     27.582|     39.333|       0|     0|
RTD|      9.666|     27.083|     39.332|       0|     0|
RTD|      9.666|     27.233|     39.666|       0|     0|
RTD|      9.665|     28.141|     38.999|       0|     0|
RTD|      9.665|     27.715|     38.665|       0|     0|
RTD|      9.665|     27.444|     38.998|       0|     0|
RTD|      9.665|     28.393|     38.665|       0|     0|
RTD|      9.331|     27.398|     38.664|       0|     0|
RTD|      9.664|     27.012|     38.331|       0|     0|
RTD|      9.664|     28.006|     39.664|       0|     0|
RTD|      9.664|     28.399|     39.997|       0|     0|
RTD|      9.663|     27.806|     39.330|       0|     0|
RTD|      9.663|     27.245|     38.997|       0|     0|
RTD|      9.663|     28.529|     39.330|       0|     0|
RTD|      9.663|     27.723|     38.663|       0|     0|
RTD|      9.662|     28.381|     39.662|       0|     0|
RTD|      9.662|     28.507|     39.996|       0|     0|
RTD|      9.662|     27.218|     39.329|       0|     0|

Seems like a weird drift.

Clocktest results:
== Testing built-in CLOCK_HOST_REALTIME (32)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  1.7           -0.022          0            0.0

Could you point me to how to investigate about these behaviors?

Thanks in advance, regards

Mauro



