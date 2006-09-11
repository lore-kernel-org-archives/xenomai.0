Subject: Re: [Xenomai-core] No hardware interrupts with xenomai on ppc405
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45057123.1030908@domain.hid>
References: <4503EB88.2040309@domain.hid>
	<200609111058.44417.matthias.fuchs@domain.hid>
	<1157970027.4934.6.camel@domain.hid>
	<200609111402.12493.matthias.fuchs@domain.hid>
	<45055475.2050705@domain.hid> <1157980145.4934.69.camel@domain.hid>
	<45057123.1030908@domain.hid>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 17:32:19 +0200
Message-Id: <1157988739.4991.11.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-09-11 at 16:22 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Mon, 2006-09-11 at 14:20 +0200, Wolfgang Grandegger wrote:
> >> Matthias Fuchs wrote:
> >>> Hello Philippe,
> >>>
> >>> that helps. I will do some further testing.
> >>>
> >>> Matthias
> >>>
> >>>
> >>> On Monday 11 September 2006 12:20, Philippe Gerum wrote:
> >>>> It's likely an Adeos issue. Could you try this patch? TIA,
> >>>>
> >>>> --- arch/ppc/syslib/ppc4xx_pic.c~	2005-10-28 02:02:08.000000000 +0200
> >>>> +++ arch/ppc/syslib/ppc4xx_pic.c	2006-09-11 12:18:14.000000000 +0200
> >>>> @@ -72,7 +72,8 @@
> >>>>  		mtdcr(DCRN_UIC_SR(UIC##n), mask);			\
> >>>>  		ACK_UIC##n##_PARENT					\
> >>>>  	}								\
> >>>> -	if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {		\
> >>>> +	if (!ipipe_root_domain_p ||					\
> >>>> +	    !(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {		\
> >>>>  		ppc_cached_irq_mask[n] |= mask;				\
> >>>>  		mtdcr(DCRN_UIC_ER(UIC##n), ppc_cached_irq_mask[n]);	\
> >>>>  	}								\
> >> Philippe, could you please explain the problem in more detail? And what 
> >> are the consequences for other PowerPC ARCs and PICs, also for Linux 2.4?
> > 
> > The issue lies in the fact that PICs *_end() routines may be called over
> > the Xenomai domain, and actually are, most of the time, since
> > xnintr_irq_handler() -which invokes xnarch_end_irq()- is always called
> > from the the Xenomai stage in the Adeos pipeline.
> > 
> > In such a case, we must not check for the Linux-defined IRQ bits (e.g.
> > IRQ_INPROGRESS), and always send the eoi, since those bits are not
> > relevant to the Xenomai context. The patch above ensures this.
> > 
> > And yes, the 2.4 patch has the very same problem, which should be fixed
> > the same way for all supported ppc platforms in the various PIC
> > management code. Oops.
> 
> And why didn't this render PPC-over-2.4 useless, i.e. what is special
> about this 405-scenario?
> 

A possible explanation is that configurations only using the timer IRQ
are not affected, since the decrementer is not subject to this issue
(the tick handler returns XN_ISR_NOENABLE anyway).

-- 
Philippe.



