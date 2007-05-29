From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <465BC709.2080000@domain.hid>
References: <4656C2D0.7000705@domain.hid>
	<1180170634.15146.0.camel@domain.hid>  <465BC709.2080000@domain.hid>
Content-Type: text/plain
Date: Tue, 29 May 2007 09:32:12 +0200
Message-Id: <1180423932.28644.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Problem with interrupt enabling
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
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

On Tue, 2007-05-29 at 08:24 +0200, Johan Borkhuis wrote:
> Philippe Gerum wrote:
> > Does this help?
> > --- arch/ppc/syslib/open_pic.c~	2006-11-17 15:55:24.000000000 +0100
> > +++ arch/ppc/syslib/open_pic.c	2007-05-26 11:09:03.000000000 +0200
> > @@ -833,7 +833,7 @@
> >  {
> >  #if defined(__SLOW_VERSION__) || defined(CONFIG_IPIPE)
> >  	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
> > -	    && irq_desc[irq_nr].action)
> > +	    && (!ipipe_root_domain_p || irq_desc[irq_nr].action))
> >  		openpic_enable_irq(irq_nr);
> >  #else
> >  	if ((irq_desc[irq_nr].status & IRQ_LEVEL) != 0)
> >
> >   
> This does indeed fix the problem. Thanks!

Ok. I've uploaded an amended patch for the legacy 2.6.14/ppc support
here:
http://download.gna.org/adeos/patches/v2.6/ppc/older/adeos-ipipe-2.6.14-ppc-1.5-03.patch

This patch will be shipped with the upcoming 2.3.2 too.

> 
> Kind regards,
>     Johan Borkhuis
> 
-- 
Philippe.



