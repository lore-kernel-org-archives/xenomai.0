From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CD6D22C.2030708@domain.hid>
References: <20101007115728.GA24500@domain.hid>
	<4CADBDC2.8080600@domain.hid> <20101008070148.GB2255@domain.hid>
	<1286530884.13186.109.camel@domain.hid>
	<20101013090353.GA6902@domain.hid>
	<1286961375.1759.71.camel@domain.hid>
	<20101013092617.GB6902@domain.hid>
	<1286981521.1759.83.camel@domain.hid>
	<1288025329.26618.132.camel@domain.hid>  <4CC5C80E.2070004@domain.hid>
	<1288033731.26618.161.camel@domain.hid>  <4CC5D742.9080307@domain.hid>
	<1288034435.26618.164.camel@domain.hid>  <4CC5D8FF.5080109@domain.hid>
	<1288041166.26618.182.camel@domain.hid>  <4CC5F525.7040206@domain.hid>
	<1288042858.26618.204.camel@domain.hid>  <4CC5FAE6.6010305@domain.hid>
	<1288068231.26618.224.camel@domain.hid> <4CC665A1.9040707@domain.hid>
	<4CC72D27.3010607@domain.hid> <1288243034.1816.14.camel@domain.hid>
	<4CC926BE.7040105@domain.hid>  <1288251968.1816.22.camel@domain.hid>
	<1289142959.1842.295.camel@domain.hid>  <4CD6D22C.2030708@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 07 Nov 2010 17:55:22 +0100
Message-ID: <1289148922.1842.299.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel oopses when killing realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2010-11-07 at 17:22 +0100, Jan Kiszka wrote:
> Am 07.11.2010 16:15, Philippe Gerum wrote:
> > On Thu, 2010-10-28 at 09:46 +0200, Philippe Gerum wrote:
> >> On Thu, 2010-10-28 at 09:31 +0200, Jan Kiszka wrote:
> >>> Am 28.10.2010 07:17, Philippe Gerum wrote:
> >>>> On Tue, 2010-10-26 at 21:33 +0200, Jan Kiszka wrote:
> >>>>> Am 26.10.2010 07:22, Jan Kiszka wrote:
> >>>>>> Will come up with two patches for stable, one for I-pipe and one for
> >>>>>> Xenomai, later today. Then we can discuss which cases I'm missing.
> >>>>>
> >>>>> While meditating over my approach (which turned out to be less trivial
> >>>>> as expected - of course), I also reconsidered your current patches. The
> >>>>> concerns I had (forwarding of spurious IRQ to Linux) turned out to be
> >>>>> harmless (Linux will ignore such few spurious events).
> >>>>>
> >>>>
> >>>> That is not even an issue if you consider the sequence to be
> >>>> xnarch_disable_irq then ipipe_control (new version, doing a critical
> >>>> entry to flip the irq mode).
> >>>
> >>> When you want to support shared IRQs, xnarch_disable_irq is tabu. I
> >>> suppose you meant some my_device_disable_irqs().
> >>
> >> No, it is perfectly valid provided you made sure that no handler
> >> remained on the shared list. There is absolutely no reason to keep a
> >> line unmasked if no device is supposed to be active on it. Hence the
> >> release sequence described earlier.
> >>
> >>>
> >>>>
> >>>>> Still, the approach to sync via shutting down the line for the current
> >>>>> domain before xnintr_irq_detach doesn't work for us. It only works if
> >>>>> xnintr_irq_detach actually detaches from the line, but it breaks if
> >>>>> there are users remaining.
> >>>>>
> >>>>> We need intrlock to check if we are the last user while removing
> >>>>> ourselves from the list. And we cannot postpone line detaching after the
> >>>>> critical section as we may otherwise race with the next registration on
> >>>>> that line. IOW, I don't see how to solve the issue without moving the
> >>>>> drain after the detach and making the detach safer instead.
> >>>>>
> >>>>> Do you agree?
> >>>>>
> >>>>
> >>>> I agree this is not trivial, for sure. To keep things simple, I would
> >>>> introduce a new "teardown" flag to freeze the descriptor, thus avoiding
> >>>> further attachments, while xnintr_detach can probe the shared list for
> >>>> lingering users, and eventually call xnarch_disable_irq
> >>>> +xnarch_ignore_irq+xnarch_release_irq in sequence with all locks
> >>>> dropped, if empty.
> >>>>
> >>>> The only adverse effect I can see ATM would be some concurrent caller of
> >>>> xnintr_detach() blocked on the teardown flag on another CPU, albeit it
> >>>> _could_ have joined the bandwagon, attaching the irq, in case the shared
> >>>> list proved to remain active (and thus xnarch_release_irq was not
> >>>> called). But this may also look like a simple way to prevent live
> >>>> locking of interrupt descriptors. YMMV.
> >>>
> >>> This sounds like it's best discussed based on patches.
> >>>
> >>
> >> Likely, yes. I'll have a look when time allows.
> > 
> > The following patches implements the teardown approach. The basic idea
> > is:
> > - neither break nor improve old setups with legacy I-pipe patches not
> > providing the revised ipipe_control_irq call.
> > - fix the SMP race when detaching interrupts.
> 
> Looks good.
> 
> > 
> > The last patch also fixes two other issues:
> > - do not alter the irq descriptor (e.g. cookie and stats) if the
> > attachment fails early
> > - do not set irq affinity before the validity checks, and set it only
> > for the first handler introduced in the shared list.
> 
> Separate commits? At least mention it in the change log.

I'm unsure this really matters. The bugs could only bite when taking the
error path (who makes mistakes these days?), and the affinity fix
depends on the race fix.

> 
> Jan
> 

-- 
Philippe.



