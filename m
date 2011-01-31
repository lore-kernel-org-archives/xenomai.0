From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4D469A5A.7010904@domain.hid>
References: <AANLkTi=7M-cqps4b--i6Kud3o6-awuntk2Zpwj7JHZ8a@domain.hid>
	<1296469933.2214.35.camel@domain.hid> <4D469437.9050902@domain.hid>
	<1296471234.2214.38.camel@domain.hid>
	<AANLkTikz2UuirubwC1oRQoXBRCqWS0xf3z__3mD60rCn@domain.hid>
	<1296472361.2214.47.camel@domain.hid>  <4D469A5A.7010904@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 Jan 2011 12:22:49 +0100
Message-ID: <1296472969.2214.50.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Is xenomai OK for early boot purpose ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, 2011-01-31 at 12:17 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Mon, 2011-01-31 at 12:01 +0100, gryma biloy wrote:
> >> On Mon, Jan 31, 2011 at 11:53 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> >>> On Mon, 2011-01-31 at 11:51 +0100, Gilles Chanteperdrix wrote:
> >>>> Philippe Gerum wrote:
> >>>>> On Mon, 2011-01-31 at 09:55 +0100, gryma biloy wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>> On a project running Linux on a beagle board, I'd like to add the
> >>>>>> following capabilities to my platform :
> >>>>>>   - real time processes with periodic tasks (10ms, 100ms & 200 ms) and
> >>>>>> a low jitter (< 50 us)
> >>>>> Kernel space apps then, likely. Userland apps (the recommended way)
> >>>>> probably have a larger worst-case jitter on this hardware, albeit still
> >>>>> below 100 us. Gilles?
> >>>> Las time I checked, latency measured on a 720MHz omap3 was around 55us
> >>>> with a 1ms period and 35us with a 100us period.
> >>> Yeah, I suspect that longer periods ( >= 10 ms ) may introduce more
> >>> opportunities for cache eviction due to linux activity, and therefore
> >>> higher jittery, even if bounded.
> >> Does this mean that the main reason for jittery is due to the cache ?
> >> What would be the other reasons, if any ?
> > 
> > 
> > The main reason for more jittery with longer periods is due to the cache
> > if you compare a high frequency loop and a lower one. When the rt system
> > is idle, waiting for the next wakeup, the linux activity resumes and
> > evicts a bunch of cachelines for running its own processes. So next time
> > the rt system is resumed, a significant time will be spent refilling the
> > cache with the rt program, starting with some real-time IRQ handler
> > itself. This is why you always get better latencies when running a 10Khz
> > sampling loop, than you would get for 1Khz. This can be observed on all
> > archs Xenomai supports.
> > 
> > On ARM, the memory subsystem is often involved in jittery for different
> > reasons (ask Gilles why he implemented FCSE for instance).
> 
> Well actually, this effect can not be observed on ARMv4/v6 without FCSE,
> because the cache is flushed at each context switch.
> 

Unfortunately, we do have memory subsystem issues not directly involving
tlb flushes and FCSE over v5. Typically, the lack of hw-assisted
broadcasting of DMA operations with arm11/mpcore in SMP mode is a real
pain as well.

-- 
Philippe.



