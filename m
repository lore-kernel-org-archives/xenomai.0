From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CD908AD.9000202@domain.hid>
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
	<1289142959.1842.295.camel@domain.hid> <4CD6D22C.2030708@domain.hid>
	<4CD8FFC4.5040202@domain.hid> <1289291217.1957.16.camel@domain.hid shift>
	<4CD908AD.9000202@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 09 Nov 2010 10:36:52 +0100
Message-ID: <1289295412.1957.32.camel@domain.hid>
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

On Tue, 2010-11-09 at 09:39 +0100, Jan Kiszka wrote:
> Am 09.11.2010 09:26, Philippe Gerum wrote:
> > On Tue, 2010-11-09 at 09:01 +0100, Jan Kiszka wrote:
> >> Am 07.11.2010 17:22, Jan Kiszka wrote:
> >>> Am 07.11.2010 16:15, Philippe Gerum wrote:
> >>>> The following patches implements the teardown approach. The basic idea
> >>>> is:
> >>>> - neither break nor improve old setups with legacy I-pipe patches not
> >>>> providing the revised ipipe_control_irq call.
> >>>> - fix the SMP race when detaching interrupts.
> >>>
> >>> Looks good.
> >>
> >> This actually causes one regression: I've just learned that people are
> >> already happily using MSIs with Xenomai in the field. This is perfectly
> >> fine as long as you don't fiddle with rtdm_irq_disable/enable in
> >> non-root contexts or while hard IRQs are disable. The latter requirement
> >> would be violated by this fix now.
> > 
> > What we could do is handle this corner-case in the ipipe directly, going
> > for a nop when IRQs are off on a per-arch basis only to please those
> > users,
> 
> Don't we disable hard IRQs also then the root domain is the only
> registered one? I'm worried about pushing regressions around, then to
> plain Linux use-cases of MSI (which are not broken in anyway - except
> for powerpc).

The idea is to provide an ad hoc ipipe service for this, to be used by
the HAL. A service that would check the controller for the target IRQ,
and handle MSI ones conditionally. For sure, we just can't put those
conditionally bluntly into the chip mask handler and expect the kernel
to be happy.

In fact, we already have __ipipe_enable/disable_irq from the internal
Adeos interface avail, but they are mostly wrappers for now. We could
make them a bit more smart, and handle the MSI issue as well. We would
then tell the HAL to switch to using those arch-agnostic helpers
generally, instead of peeking directly into the chip controller structs
like today.

If that ipipe "feature" is not detected by the HAL, then we would
refrain from disabling the IRQ in xnintr_detach. In effect, this would
leave the SMP race window open, but since we need recent ipipes to get
it plugged already anyway (for the revised ipipe_control_irq), we would
still remain in the current situation:
- old patches? no SMP race fix, no regression
- new patches? SMP race fix avail, no regression

> 
> > because I don't think we can generally tell people that using MSI
> > is fine right now with respect to the above limitations. Besides, we
> > can't enable CONFIG_PCI_MSI at all on powerpc 83xx yet (I suspect most
> > other powerpc platforms are broken the same way), this simply causes a
> > lockup at boot.
> 
> OK, but this is most probably an arch-specific issue. I saw no issues
> inherent to MSI support in the generic PCI driver.

Yes, likely. But still, MSI only works in a well-defined context over
x86 for now.

> 
> > So more work is really needed all over the place for
> > having MSI officially supported in Xenomai.
> > 
> >>
> >> I've evaluated hardening MSI disable/enable in further details in the
> >> meantime. But after collecting information about the latency impacts of
> >> accessing PCI devices' config spaces during some KVM pass-through work,
> >> I finally had to give up this path. What remains (besides restricting
> >> the irq_disable/enable usage) is a software-maintained mask, but that
> >> also requires updated I-pipe patches and refactorings on Xenomai's HAL.
> > 
> > I agree that trying to fit the PCI config accesses over the primary
> > domain would be just insane, I see way too many intricacies and room for
> > deadly issues as well.
> 
> Most deadly is the fact that insane hardware, probably firmware, can
> impact this path under our feet. And we can't isolate those accesses
> even if the devices are well known - the access method is a system-wide
> shared resource.
> 
> Jan
> 

-- 
Philippe.



