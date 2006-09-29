Subject: Re: [Adeos-main] Problems booting after Adeos patch
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <451D18B2.3060007@domain.hid>
References: <451AEEED.1050708@domain.hid> <451B0978.5020108@domain.hid>
	<451BD6FC.9080205@domain.hid> <451BDADC.30101@domain.hid>
	<1159454661.4982.20.camel@domain.hid>  <451C0171.3020508@domain.hid>
	<1159475242.4982.46.camel@domain.hid> <1159475501.4982.49.camel@domain.hid>
	<451D18B2.3060007@domain.hid>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 15:44:08 +0200
Message-Id: <1159537448.4964.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: "J.D. Yamokoski" <yamokosk@domain.hid>
Cc: adeos-main@gna.org

On Fri, 2006-09-29 at 08:59 -0400, J.D. Yamokoski wrote:
> Philippe Gerum wrote:
> > On Thu, 2006-09-28 at 22:27 +0200, Philippe Gerum wrote:
> > 
> >> Ok, thanks. Just for the purpose of finding some grip on this issue,
> >> could you:
> >> 1) apply the patch below; I suspect some unwanted IRQ migration issue,
> >> but can't prove it right now.
> >> 2) if this patch does not solve the boot problem with CONFIG_PCI_MSI
> >> enabled, then does disabling CONFIG_SMP improve the situation?
> >>
> >> TIA,
> >>
> > 
> > Actually, this patch would be better for the purpose of testing.
> > 
> > --- 2.6.17-ipipe/kernel/irq/migration.c.orig	2006-09-28 22:28:20.000000000 +0200
> > +++ 2.6.17-ipipe/kernel/irq/migration.c	2006-09-28 22:30:13.000000000 +0200
> > @@ -17,6 +17,10 @@
> >  	cpumask_t tmp;
> >  	irq_desc_t *desc = irq_descp(irq);
> >  
> > +#ifdef CONFIG_IPIPE
> > +	return;
> > +#endif /* CONFIG_IPIPE */
> > +
> >  	if (likely(!desc->move_irq))
> >  		return;
> >  
> 
> Real quick, does it matter if I was using the Adeos I-pipe patch for 
> kernel 2.6.15 when I ran into my problems? That patch looks like it is 
> for 2.6.17 - But I can try either one.

That should be ok for any version that implements the generic IRQ
migration code, and 2.6.15 does.

-- 
Philippe.



