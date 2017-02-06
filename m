References: <1485939628.4068.25.camel@smigroup.net>
 <2f2b2c8e-96a2-9f12-6af1-b23a9343ab95@xenomai.org>
 <1486369782.6133.13.camel@smigroup.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5123915d-13f2-c909-acf2-d3890dfa2788@xenomai.org>
Date: Mon, 6 Feb 2017 15:28:02 +0100
MIME-Version: 1.0
In-Reply-To: <1486369782.6133.13.camel@smigroup.net>
Content-Type: text/plain; charset=utf-8
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
To: Mauro Salvini <mauro.salvini@smigroup.net>
Cc: xenomai <xenomai@xenomai.org>

On 02/06/2017 09:29 AM, Mauro Salvini wrote:
> On Thu, 2017-02-02 at 10:52 +0100, Philippe Gerum wrote:
>> On 02/01/2017 10:00 AM, Mauro Salvini wrote:
> I restarted my tests from scratch: my current situation is SMP
> enabled, arm-global-timer and arm-twd-timer not configured in dts.
> I'm using the SabreSD board from Freescale.
>

Seems weird. Why not using a !SMP kernel on your single core SoC? There
may be assumptions in the code that such devices are available if SMP is
enabled.

> On system boot I can see:
> 
> [    0.000000] mxc_clocksource_init 3000000
> [    0.000000] Switching to timer-based delay loop, resolution 333ns
> [    0.000006] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps
> every 715827882841ns
> [    0.000021] clocksource mxc_timer1: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 637086815595 ns
> [    0.000034] I-pipe, 3.000 MHz clocksource, wrap in 1431655 ms
> [    0.000047] clocksource ipipe_tsc: mask: 0xffffffffffffffff
> max_cycles: 0x1623fa770, max_idle_ns: 881590404476 ns
> [    0.001602] Interrupt pipeline (release #4)
> ...
> [    0.001745] Calibrating delay loop (skipped), value calculated using
> timer frequency.. 6.00 BogoMIPS (lpj=30000)
> ...
> [    0.170645] I-pipe: disabling SMP code
> ...
> [    0.228650] Switched to clocksource ipipe_tsc
> ...
> [    0.247029] [Xenomai] scheduling class idle registered.
> [    0.247037] [Xenomai] scheduling class rt registered.
> [    0.247186] I-pipe: head domain Xenomai registered.
> 
> When I run latency test I observe two strange behaviors:
> 
> - the first is that if I change the default sampling period value
> (1000us) to 100us, maximum and average latencies significantly decrease
> (average from ~27us to ~14us, and maximum from ~40us to ~28us). Is it
> normal?

Yes, nothing strange. The more frequent the real-time cycle, the less
time the regular Linux kernel has for evicting the cachelines used by
the Cobalt co-kernel on the same CPU. The hotter the cachelines
referenced by Cobalt, the shorter the latencies.

 I don't observe this on an old x86 machine (but that runs

This is comparing apples and oranges. The cache performances are quite
different here - especially compared to the i.MX6 series with PL3xx
external L2 caches. Running Xenomai 3 on a properly calibrated x86 box
should give you better numbers than 2.5 has.

Also, make sure to calibrate the Cobalt clock before testing, e.g. using
the autotuner.

> xenomai 2.5). By the way, I see in configure script that ARM is the only
> arch that has a default sampling period at 1000us (other archs are
> 100us).

Yes, because historically, ARM v4/v5 SoCs used to be unable to sustain
10Khz sampling loops without locking up the machine. This is obviously
not the case anymore with v7, but the conservative sampling period has
stuck in the config file.

> 
> - the second is that minimum latencies constantly decrease by 0.001us at
> every 4 iterations (with random spurious values sometimes), instead of
> changing between each iteration as usual (here an example, last two
> columns are cut away for readability):
> 
> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|
> RTD|      9.667|     27.180|     39.667|       0|     0|
> RTD|      9.667|     26.502|     39.333|       0|     0|
> RTD|      9.666|     27.454|     39.333|       0|     0|
> RTD|      9.666|     27.582|     39.333|       0|     0|
> RTD|      9.666|     27.083|     39.332|       0|     0|
> RTD|      9.666|     27.233|     39.666|       0|     0|
> RTD|      9.665|     28.141|     38.999|       0|     0|
> RTD|      9.665|     27.715|     38.665|       0|     0|
> RTD|      9.665|     27.444|     38.998|       0|     0|
> RTD|      9.665|     28.393|     38.665|       0|     0|
> RTD|      9.331|     27.398|     38.664|       0|     0|

There it changed.

> Seems like a weird drift.
>

I don't think so, you would notice the same drift in all other columns.
There are too few samples listed above to conclude anything.


> Clocktest results:
> == Testing built-in CLOCK_HOST_REALTIME (32)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>   0                  1.7           -0.022          0            0.0
> 
> Could you point me to how to investigate about these behaviors?
> 

I see no issue here, if those values are stable: the offset and drift
given in micro-seconds are minimal compared to Linux's idea of time.
Please note that CLOCK_HOST_REALTIME is used for timestamping based on a
real-time compatible version of the regular CLOCK_REALTIME, this is not
the monotonic clock source used internally by Cobalt for timing duties.

-- 
Philippe.

