From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <13153223.1178634900258.JavaMail.ngmail@domain.hid>
References: <1178631460.5045.6.camel@domain.hid>
	<1178627340.5045.3.camel@domain.hid> <1178385693.2406.7.camel@domain.hid>
	<463AE7D3.6030401@domain.hid>
	<24394502.1178264721982.JavaMail.ngmail@domain.hid>
	<13626574.1178266851510.JavaMail.ngmail@domain.hid>
	<1178281223.29093.83.camel@domain.hid>
	<23990358.1178625225906.JavaMail.ngmail@domain.hid>
	<15573283.1178627888504.JavaMail.ngmail@domain.hid>
	<13153223.1178634900258.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Wed, 09 May 2007 10:00:25 +0200
Message-Id: <1178697626.5004.12.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Tue, 2007-05-08 at 16:35 +0200, M. Koehrer wrote:
> Hi Philippe,
> 
> that's it! Now, everything seems to run really nicely!
> The great thing is, that is I have now one of my e1000 (PCIe) running 
> in non real time mode and the other running with rtnet in real time!
> They have IRQs 223 resp. 222.
> As interrupt sharing was one of the main issues I had, this seems
> to be solved now!
> In which Xenomai version will the new adeos patch and the fix from today end up?
> Or should I use the 2.3.1 and using the new adeos patch + the fix?

I'll roll out I-pipe/x86 1.8-01 including the latest fixes soon. This
patch will be available from the next 2.3.x maintenance release (2.3.2)
and the trunk.

> 
> Thank you very much for the excellent support!
> 
> Regards
> 
> Mathias
> > On Tue, 2007-05-08 at 14:38 +0200, M. Koehrer wrote:
> > > Hi Philippe,
> > > 
> > > perhaps one more information regarding that issue: 
> > > When I disable SMP, it seems to work fine (APIC and local APIC are
> > enabled).
> > 
> > This should improve things:
> > 
> > --- a/arch/i386/kernel/ipipe.c
> > +++ b/arch/i386/kernel/ipipe.c
> > @@ -373,7 +373,7 @@ int fastcall __ipipe_send_ipi (unsigned ipi, cpumask_t
> > cpumask)
> >         cpu_clear(cpuid,cpumask);
> > 
> >         if (!cpus_empty(cpumask))
> > -               send_IPI_mask(cpumask,ipi + FIRST_EXTERNAL_VECTOR);
> > +               send_IPI_mask(cpumask,ipipe_apic_irq_vector(ipi));
> > 
> >         if (self)
> >                 ipipe_trigger_irq(ipi);
> > 
> > -- 
> > Philippe.
> > 
> > 
> > 
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> > 
> 
-- 
Philippe.



