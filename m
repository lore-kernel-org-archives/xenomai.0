References: <1485939628.4068.25.camel@smigroup.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2f2b2c8e-96a2-9f12-6af1-b23a9343ab95@xenomai.org>
Date: Thu, 2 Feb 2017 10:52:01 +0100
MIME-Version: 1.0
In-Reply-To: <1485939628.4068.25.camel@smigroup.net>
Content-Type: text/plain; charset=windows-1252
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
To: Mauro Salvini <mauro.salvini@smigroup.net>, xenomai <xenomai@xenomai.org>

On 02/01/2017 10:00 AM, Mauro Salvini wrote:
> Hi,
> I'm trying to use an iMX6SX custom board with Xenomai.
> I'm able to patch the 4.1 kernel from Freescale community (based on
> 4.1.15_1.2.0 branch from NXP and merged with 4.1.y branch from mainline)
> with some little rejections resolved by hand.
> 
> Kernel boots but Xenomai tests point out some weird behaviors (e.g.
> minimum latencies that constantly decreases by 0.001 us every 4 seconds,
> clocktest that reports ~10ms deltas and warps, maximum latencies that
> increases with larger sample periods, etc), so I started to read [1] to
> figure out what I'm missing.
> 
> Firstly I found that iMX6SX devicetree does not list global and twd
> timers. Adding these to dts solves some problems related to latencies.
> Now in my dmesg I see:
> [    0.000033] I-pipe, 3.000 MHz clocksource, wrap in 1431655 ms
> [    0.000046] clocksource ipipe_tsc: mask: 0xffffffffffffffff
> max_cycles: 0x1623fa770, max_idle_ns: 881590404476 ns
> [    0.000943] I-pipe, 396.000 MHz clocksource, wrap in 10845 ms
> [    0.000955] clocksource ipipe_tsc: mask: 0xffffffffffffffff
> max_cycles: 0x5b5469468b, max_idle_ns: 440795218345 ns
> .....
> [    0.080436] Switched to clocksource ipipe_tsc
> 
> Following [1] I found that hardware timer isn't actually used on my
> board, because is used only if CONFIG_SMP is selected (I disabled SMP
> support because I have only one core and I noticed that SMP support
> increases real-time latencies).
> 
> So, SMP support is mandatory or could be avoided and a modification to
> ipipe is required?
>

No, SMP is not mandatory. The current I-pipe works fine on SX as well.
However, timing services are normally obtained from the mxc timer on
single core configurations with 4.1 kernels and earlier
(arch/arm/mach-imx/time.c), twd are per-CPU timers only enabled with
multi-core systems there.

-- 
Philippe.

