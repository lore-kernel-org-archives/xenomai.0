From: Philippe Gerum <rpm@xenomai.org>
References: <ff4b8c3a-c8ca-09b5-d3ac-f1d6e127a4e5@sferapro.com>
 <CALLqZ8SuY4K=PFP6LeCHXU9PXoXnmDv4UCLnqHmnz-8xc3CacA@mail.gmail.com>
 <CALLqZ8Q3uZm8jTmtJLHR=Yz3Cw5g+CGTrXaj-oUFPT=1Rh0JbA@mail.gmail.com>
 <c2d2a625-011c-1c79-0bcc-4830c1d30674@sferapro.com>
 <091bff54-d806-97ce-f418-9148af9bccb1@xenomai.org>
Message-ID: <e23ed199-64ec-2863-7e9d-127c409e7d79@xenomai.org>
Date: Sun, 8 Jul 2018 15:45:17 +0200
MIME-Version: 1.0
In-Reply-To: <091bff54-d806-97ce-f418-9148af9bccb1@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Xenomai]  i.MX6q memory write causes high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Federico Sbalchiero <f.sbalchiero@sferapro.com>, xenomai@xenomai.org

On 07/06/2018 10:32 AM, Philippe Gerum wrote:
> On 07/06/2018 10:07 AM, Federico Sbalchiero wrote:
>> adding a break at line 837 in file /arch/arm/mm/cache-l2x0.c enables L2
>> write allocate:
>>
>> [    0.000000] L2C-310 errata 752271 769419 enabled
>> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
>> [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
>> [    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
>> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
>> [    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
>> [    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
>>
>>
>> latency under load (four memwrite instances) is better but still high.
>>
>> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
>> best|--lat worst
>> RTD|     42.667|     58.521|     87.667|       0|     0| 42.667|     87.667
>> RTD|     42.000|     58.935|     89.000|       0|     0| 42.000|     89.000
>> RTD|     36.666|     58.707|     90.333|       0|     0| 36.666|     90.333
>> RTD|     38.333|     58.439|     92.666|       0|     0| 36.666|     92.666
>> RTD|     41.666|     58.595|     84.999|       0|     0| 36.666|     92.666
>> RTD|     42.666|     58.698|     89.666|       0|     0| 36.666|     92.666
>> RTD|     40.999|     58.999|     95.665|       0|     0| 36.666|     95.665
>> RTD|     42.665|     58.823|     88.665|       0|     0| 36.666|     95.665
>> RTD|     42.665|     58.570|     84.665|       0|     0| 36.666|     95.665
>> RTD|     41.331|     58.599|     86.998|       0|     0| 36.666|     95.665
>> RTD|     37.664|     58.596|     92.331|       0|     0| 36.666|     95.665
>> RTD|     35.331|     58.893|     85.997|       0|     0| 35.331|     95.665
>> RTD|     41.997|     58.704|     86.997|       0|     0| 35.331|     95.665
>> RTD|     40.997|     58.723|     94.997|       0|     0| 35.331|     95.665
>> RTD|     41.330|     58.710|     88.997|       0|     0| 35.331|     95.665
>> RTD|     41.330|     59.080|     92.663|       0|     0| 35.331|     95.665
>> RTD|     38.330|     58.733|     85.996|       0|     0| 35.331|     95.665
>> RTD|     39.996|     59.095|     90.663|       0|     0| 35.331|     95.665
>> RTD|     41.662|     58.967|     86.662|       0|     0| 35.331|     95.665
>> RTD|     42.662|     58.884|     86.995|       0|     0| 35.331|     95.665
>> RTD|     42.662|     58.852|     88.329|       0|     0| 35.331|     95.665
>>
> 
> According to my latest tests, waiting for operations to complete in the
> cache unit induces most of the delay. I'm under the impression that the
> way we deal with the outer L2 cache is obsolete, based on past
> assumptions which may not be valid anymore. Typically, some of them
> would involve events that might occur with VIVT caches, which we don't
> support in 4.14.
> 
> The whole logic requires a fresh review. I'll follow up on this.
> 

I ran extensive tests on two SoCs equipped with PL310 l2 caches,
i.MX6QP (sabresd) and a VIA pico-ITX which is also a quad-core i.MX6Q
(much older though).

Background stress load while sampling latencies:

- while :; do dd if=/dev/zero of=/dev/null bs=16M; done&
- switchtest -s 200
- ethernet bandwidth testing with iperf to and from the SoC, only for
the purpose of hammering the system with lots of DMA transfers via the
FEC driver, which in turn causes a continuous flow of l2 cache
maintenance operations for cleaning / invalidating ranges of DMA-ed
cachelines.

With the very same Xenomai 3.0.7 over kernel 4.14.36 configuration
(I-pipe/4.14 commit [1]), SMP, all debug switches and tracers disabled,
only toggling l2x0_write_allocate on/off, the results were:

==========================================================
VIA (996 Mhz, L2 cache rev: L310_CACHE_ID_RTL_R3P1_50REL0)
==========================================================

* kernel 4.14.36, WA=0, ipipe-core-4.14.36-arm-1

L2C: I-pipe: l2x0_write_allocate= not specified, defaults to 0 (disabled).
L2C: DT/platform modifies aux control register: 0x32070000 -> 0x32c70000
L2C-310 errata 752271 769419 enabled
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 ID prefetch enabled, offset 16 lines
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 16 ways, 1024 kB
L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76c70001

RTH|----lat min|----lat avg|----lat max|-overrun|---msw|
RTD|      4.212|      9.852|     57.243|       0|     0|
07:07:43/07:07:43

-----------------------------------------------------------------------------

* kernel 4.14.36, WA=1, ipipe-core-4.14.36-arm-1

L2C: I-pipe: write-allocate enabled, induces high latencies.
L2C: DT/platform modifies aux control register: 0x32070000 -> 0x32470000
L2C-310 errata 752271 769419 enabled
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 ID prefetch enabled, offset 16 lines
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 16 ways, 1024 kB
L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001

RTH|----lat min|----lat avg|----lat max|-overrun|---msw|
RTS|      0.996|     16.472|     93.579|       0|     0|
03:12:12/03:12:12

=====================================================
IMX6QP (996Mhz, L2 cache rev: L310_CACHE_ID_RTL_R3P2)
=====================================================

* kernel 4.14.36, WA=1, ipipe-core-4.14.36-arm-1

L2C: I-pipe: revision >= L310-r3p2 detected, forcing WA.
L2C: I-pipe: write-allocate enabled, induces high latencies.
L2C: DT/platform modifies aux control register: 0x32070000 -> 0x32470000
L2C-310 erratum 769419 enabled
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 ID prefetch enabled, offset 16 lines
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 16 ways, 1024 kB
L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x76470001

RTH|----lat min|----lat avg|----lat max|-overrun|---msw|
RTS|      2.516|     14.070|     71.581|       0|     0|
03:28:03/03:28:03

-----------------------------------------------------------------------------

* kernel 4.14.36, WA=0, ipipe-core-4.14.36-arm-1

L2C: DT/platform modifies aux control register: 0x32070000 -> 0x32c70000
L2C-310 erratum 769419 enabled
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 ID prefetch enabled, offset 16 lines
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 16 ways, 1024 kB
L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x76c70001

RTH|----lat min|----lat avg|----lat max|-overrun|---msw|
RTS|      2.332|     14.991|     77.969|       0|     0|
09:55:24/09:55:24

Some (partial) conclusions drawn from what I have been seeing here:

1. The penalty with enabling write-allocate on PL310 caches with respect
to latency seems to have decreased since R3P2. Conversely, R3P1_50REL0
and earlier have better latency figures when write-allocate is disabled
(I seem to remember than early sabrelite boards would even have
pathological figures, in the 300 us range with WA=1). However, disabling
WA for PL310 cache revs >= R3P2 seems actually counter-productive since
it slows down memory accesses uselessly with no upside. This might even
cause cache coherency issues on SMP as observed with some SoCs which
died at booting the kernel in this configuration.

2. The spinlock defined in the PL2xx/3xx L2 cache driver serializes
non-atomic maintenance operation requests on the cache unit. Converting
it to a hard lock is not required, as we cannot run any outer cache
maintenance operation from primary mode, all callers belong to the root
stage (including handle_pte_fault()). There is no issue in being
preempted by out-of-band code while performing such operation, virtually
disabling interrupt has to be enough. Conversely, hard locking increases
latency since it hard disables IRQs. Contexts that would be involved by
hard locking are infrequently seen these days though:

- all operations on PL220 caches
- PL310 with errata 588369 && id < R2P0
- PL310 with errata 727915 && id >= R2P0 && id < R3P1

>> [    0.000000] L2C-310 errata 752271 769419 enabled

According to the errata advertised by your hardware, you should not be
affected by such locking issue.

All other combinations of cache types, revisions and errata do run
locklessly already, so they can't be affected by such hard locking. The
change introducing the hard lock in arch/arm/mm/cache-l2x0.c should be
reverted. As a consequence of this, limiting the bulk operations to 512
cache lines at a time would not be needed anymore either, since those
potentially lengthy operations could still be preempted by real-time
activities.

Tip #1: care for CPU frequency when comparing tests on similar hardware.
If CPU_FREQ is off, some processors may be left running at a lower speed
by the bootloader than they are capable of. CONFIG_ARM_IMX6Q_CPUFREQ can
be enabled with the "performance" CPU_FREQ governor to make sure the
highest speed is picked, and remain stable over time not to confuse
Xenomai timings. Disabling CPU_FREQ entirely has been an ancient mantra
for configuring Xenomai in the past, maybe the message should evolve
because things may not be that clear-cut depending on the SoC.

Tip #2: any test which does not run for hours under significant load is
unlikely to deliver any meaningful figure, at least not on my SoCs. In a
couple of occasions, the worst-case latency was reached after 2h+ of
runtime.

So, I would assume that ~70 us worst-case should be achievable under
high load on a typical i.MX6Q with WA=1 on l2 cache revision >= R3P2,
running at 1Ghz. For earlier revisions, WA=0 may be required for
reaching this target, possibly even less/better, but there is no
guarantee that the results seen on the VIA SoC with such settings could
be generalized though.

If anyone has different or similar results/conclusions about the impact
of l2 with the i.MX6Q series, please let us know.

Thanks,

[1]
https://git.xenomai.org/ipipe-arm/commit/a1bd0cc70391df28ad6678a86c77ce0bf275b5cd

-- 
Philippe.

