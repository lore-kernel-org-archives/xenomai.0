MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18181.18334.268857.877692@domain.hid>
Date: Thu, 4 Oct 2007 22:05:50 +0200
In-Reply-To: <1191500570.20623.63.camel@domain.hid>
References: <4704AEF3.4030105@domain.hid> <1191490451.20623.54.camel@domain.hid>
	<1191500570.20623.63.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [BUG] IO-APIC stall due to broken fasteoi
	handling
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

Philippe Gerum wrote:
 > On Thu, 2007-10-04 at 11:34 +0200, Philippe Gerum wrote: 
 > > > Well, this trace also reveals a second bug that can cause nasty priority
 > > > inversion: a high-prio domains executes when a fasteoi-IRQ arrives for a
 > > > low-prio domain. This will now block all IRQs until the low-prio domain
 > > > was able to run its IRQ handler completely. Thus we must _mask_ fasteoi
 > > > IRQs for low-prio domains while high-prio ones are running!
 > > > 
 > > 
 > > This code was actually there up to 2.6.17-1.5-02, and was removed at
 > > some point in the 2.6.19 series, due to some severe conflicts with the
 > > vanilla IO-APIC support which used to be a hell of a moving target at
 > > that time. I guess it's time to bring this code back.
 > > 
 > 
 > Does the following work for you?
 > 
 > diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
 > index 2ae79e9..517937b 100644
 > --- a/arch/i386/kernel/io_apic.c
 > +++ b/arch/i386/kernel/io_apic.c
 > @@ -2022,6 +2022,8 @@ static void ack_ioapic_quirk_irq(unsigned int irq)
 >  		__unmask_and_level_IO_APIC_irq(irq);
 >  		spin_unlock(&ioapic_lock);
 >  	}
 > +
 > +	__mask_IO_APIC_irq(irq);
 >  }
 >  
 >  static int ioapic_retrigger_irq(unsigned int irq)
 > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
 > index ba497a7..1560b4a 100644
 > --- a/kernel/irq/chip.c
 > +++ b/kernel/irq/chip.c
 > @@ -422,8 +422,13 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
 >  
 >  	spin_lock(&desc->lock);
 >  	desc->status &= ~IRQ_INPROGRESS;
 > +#ifdef CONFIG_IPIPE
 > +	desc->chip->unmask(irq);
 > +out:
 > +#else
 >  out:
 >  	desc->chip->eoi(irq);
 > +#endif
 >  
 >  	spin_unlock(&desc->lock);
 >  }
 > @@ -533,11 +538,12 @@ void fastcall __ipipe_end_level_irq(unsigned irq, struct irq_desc *desc)
 >  
 >  void fastcall __ipipe_ack_fasteoi_irq(unsigned irq, struct irq_desc *desc)
 >  {
 > +	desc->chip->eoi(irq);
 >  }
 >  
 >  void fastcall __ipipe_end_fasteoi_irq(unsigned irq, struct irq_desc *desc)
 >  {
 > -	desc->chip->eoi(irq);
 > +	desc->chip->unmask(irq);
 >  }
 >  
 >  void fastcall __ipipe_ack_edge_irq(unsigned irq, struct irq_desc *desc)

FWIW, this patche fixes my known-to-crash I-pipe 2.6.20 configuration.

-- 


					    Gilles Chanteperdrix.

