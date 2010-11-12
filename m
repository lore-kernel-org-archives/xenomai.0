From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CD948BB.4040201@domain.hid>
References: <20101007115728.GA24500@domain.hid>
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
	<1289142959.1842.295.camel@domain.hid> <4CD6D22C.2030708@domain.hid>
	<4CD8FFC4.5040202@domain.hid> <1289291217.1957.16.camel@domain.hid shift>
	<4CD908AD.9000202@domain.hid> <1289295412.1957.32.camel@domain.hid>
	<4CD948BB.4040201@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Nov 2010 09:48:31 +0100
Message-ID: <1289551711.1937.108.camel@domain.hid>
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

On Tue, 2010-11-09 at 14:12 +0100, Jan Kiszka wrote:
> Am 09.11.2010 10:36, Philippe Gerum wrote:
> > On Tue, 2010-11-09 at 09:39 +0100, Jan Kiszka wrote:
> >> Am 09.11.2010 09:26, Philippe Gerum wrote:
> >>> On Tue, 2010-11-09 at 09:01 +0100, Jan Kiszka wrote:
> >>>> Am 07.11.2010 17:22, Jan Kiszka wrote:
> >>>>> Am 07.11.2010 16:15, Philippe Gerum wrote:
> >>>>>> The following patches implements the teardown approach. The basic idea
> >>>>>> is:
> >>>>>> - neither break nor improve old setups with legacy I-pipe patches not
> >>>>>> providing the revised ipipe_control_irq call.
> >>>>>> - fix the SMP race when detaching interrupts.
> >>>>>
> >>>>> Looks good.
> >>>>
> >>>> This actually causes one regression: I've just learned that people are
> >>>> already happily using MSIs with Xenomai in the field. This is perfectly
> >>>> fine as long as you don't fiddle with rtdm_irq_disable/enable in
> >>>> non-root contexts or while hard IRQs are disable. The latter requirement
> >>>> would be violated by this fix now.
> >>>
> >>> What we could do is handle this corner-case in the ipipe directly, going
> >>> for a nop when IRQs are off on a per-arch basis only to please those
> >>> users,
> >>
> >> Don't we disable hard IRQs also then the root domain is the only
> >> registered one? I'm worried about pushing regressions around, then to
> >> plain Linux use-cases of MSI (which are not broken in anyway - except
> >> for powerpc).
> > 
> > The idea is to provide an ad hoc ipipe service for this, to be used by
> > the HAL. A service that would check the controller for the target IRQ,
> > and handle MSI ones conditionally. For sure, we just can't put those
> > conditionally bluntly into the chip mask handler and expect the kernel
> > to be happy.
> > 
> > In fact, we already have __ipipe_enable/disable_irq from the internal
> > Adeos interface avail, but they are mostly wrappers for now. We could
> > make them a bit more smart, and handle the MSI issue as well. We would
> > then tell the HAL to switch to using those arch-agnostic helpers
> > generally, instead of peeking directly into the chip controller structs
> > like today.
> 
> This belongs to I-pipe, like we already have ipipe_end, just properly
> wrapped to avoid descriptor access. That's specifically important if we
> want to emulate MSI masking in software. I've the generic I-pipe
> infrastructure ready, but the backend, so far consisting of x86 MSI
> hardening, unfortunately needs to be rewritten.
> 
> > 
> > If that ipipe "feature" is not detected by the HAL, then we would
> > refrain from disabling the IRQ in xnintr_detach. In effect, this would
> > leave the SMP race window open, but since we need recent ipipes to get
> > it plugged already anyway (for the revised ipipe_control_irq), we would
> > still remain in the current situation:
> > - old patches? no SMP race fix, no regression
> > - new patches? SMP race fix avail, no regression
> 
> Sounds good.

Now that I slept on it, I find the approach of working around pipeline
limitations this way, to be incorrect.

Basically, the issue is that we still don't have 100% reliable handling
of MSI interrupts (actually, we only have partial handling, and solely
for x86), but this is no reason to introduce code in the pipeline
interface which would perpetuate this fact. I see this as a "all or
nothing" issue: either MSI is fully handled and there shall be no
restriction on applying common operations such as masking/unmasking on
the related IRQs, or it is not, and we should not export "conditionally
working" APIs.

In the latter case, the responsibility to rely on MSI support belongs to
the user, which then should know about the pending restrictions, and
decides for himself whether to use MSI. So I'm heading to this solution
instead:

- when detaching the last handler for a given IRQ, instead of forcibly
disabling the IRQ line, the nucleus would just make sure that such IRQ
is already in a disabled state, and bail out on error if not (probably
with a kernel warning to make the issue obvious).

- track the IRQ line state from xnintr_enable/xnintr_disable routines,
so that xnintr_detach can determine whether the call is legit. Of
course, this also means that any attempt to take sideways to
enable/disable nucleus managed interrupts at PIC level would break that
logic, but doing so would be the root bug anyway.

The advantage of doing so would be three-fold:

- no pipeline code to acknowledge (or even perpetuate) the fact that MSI
support is half working, half broken. We need to fix it properly, so
that we can use it 100% reliably, from whatever context commonly allowed
for enabling/disabling IRQs (and not "from root domain with IRQs on"
only). Typically, I fail to see how one would cope with such limitation,
if a real-time handler detects that some device is going wild and really
needs to shut it down before the whole system crashes.

- we enforce the API usage requirement to disable an interrupt line with
rtdm_irq_disable(), before eventually detaching the last IRQ handler for
it, which is common sense anyway.

- absolutely no change for people who currently rely on partial MSI
support, provided they duly disable IRQ lines before detaching their
last handler via the appropriate RTDM interface.

Can we deal on this?

-- 
Philippe.



