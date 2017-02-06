Message-ID: <1486394012.6133.35.camel@smigroup.net>
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Mon, 06 Feb 2017 16:13:32 +0100
In-Reply-To: <5123915d-13f2-c909-acf2-d3890dfa2788@xenomai.org>
References: <1485939628.4068.25.camel@smigroup.net>
 <2f2b2c8e-96a2-9f12-6af1-b23a9343ab95@xenomai.org>
 <1486369782.6133.13.camel@smigroup.net>
 <5123915d-13f2-c909-acf2-d3890dfa2788@xenomai.org>
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

On Mon, 2017-02-06 at 15:28 +0100, Philippe Gerum wrote:
> On 02/06/2017 09:29 AM, Mauro Salvini wrote:
> > On Thu, 2017-02-02 at 10:52 +0100, Philippe Gerum wrote:
> >> On 02/01/2017 10:00 AM, Mauro Salvini wrote:
> > I restarted my tests from scratch: my current situation is SMP
> > enabled, arm-global-timer and arm-twd-timer not configured in dts.
> > I'm using the SabreSD board from Freescale.
> >
> 
> Seems weird. Why not using a !SMP kernel on your single core SoC? There
> may be assumptions in the code that such devices are available if SMP is
> enabled.

I'm using the default defconfig shipped with kernel (that is multiarch
too). I will do a try with !SMP.

> > 
> > When I run latency test I observe two strange behaviors:
> > 
> > - the first is that if I change the default sampling period value
> > (1000us) to 100us, maximum and average latencies significantly decrease
> > (average from ~27us to ~14us, and maximum from ~40us to ~28us). Is it
> > normal?
> 
> Yes, nothing strange. The more frequent the real-time cycle, the less
> time the regular Linux kernel has for evicting the cachelines used by
> the Cobalt co-kernel on the same CPU. The hotter the cachelines
> referenced by Cobalt, the shorter the latencies.

Got it.

> 
>  I don't observe this on an old x86 machine (but that runs
> 
> This is comparing apples and oranges. The cache performances are quite
> different here - especially compared to the i.MX6 series with PL3xx
> external L2 caches. Running Xenomai 3 on a properly calibrated x86 box
> should give you better numbers than 2.5 has.

Ok. Yes sorry, you are right, they are absolutely distinct worlds.

> 
> Also, make sure to calibrate the Cobalt clock before testing, e.g. using
> the autotuner.

Yes, I always do it before run xeno-test.

> 
> > xenomai 2.5). By the way, I see in configure script that ARM is the only
> > arch that has a default sampling period at 1000us (other archs are
> > 100us).
> 
> Yes, because historically, ARM v4/v5 SoCs used to be unable to sustain
> 10Khz sampling loops without locking up the machine. This is obviously
> not the case anymore with v7, but the conservative sampling period has
> stuck in the config file.

Ok, got it.

> 
> > 
> > - the second is that minimum latencies constantly decrease by 0.001us at
> > every 4 iterations (with random spurious values sometimes), instead of
> > changing between each iteration as usual (here an example, last two
> > columns are cut away for readability):
> 
> There it changed.
> 
> > Seems like a weird drift.
> >
> 
> I don't think so, you would notice the same drift in all other columns.
> There are too few samples listed above to conclude anything.

Yes, I reported only a block of samples, but the decreasing trend stills
on until the end of the test.

These values seems me strange because I usually observed slight changes
on values between every iteration, but always on x86 world.
I'm new to ARM world and I have to consider some "relocation" of my
beliefs and "experiences" :-)

> > Clocktest results:
> > == Testing built-in CLOCK_HOST_REALTIME (32)
> > CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> > --- -------------------- ---------------- ---------- --------------
> >   0                  1.7           -0.022          0            0.0
> > 
> > Could you point me to how to investigate about these behaviors?
> > 
> 
> I see no issue here, if those values are stable: the offset and drift
> given in micro-seconds are minimal compared to Linux's idea of time.
> Please note that CLOCK_HOST_REALTIME is used for timestamping based on a
> real-time compatible version of the regular CLOCK_REALTIME, this is not
> the monotonic clock source used internally by Cobalt for timing duties.
> 

My mistake in writing order, I didn't mean that clocktest was wrong (it
reports quite stable values), I put it there only to have a complete
report.

Philippe, thank you very much for your precious help.

Mauro


