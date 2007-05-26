From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4656C2D0.7000705@domain.hid>
References: <4656C2D0.7000705@domain.hid>
Content-Type: text/plain
Date: Sat, 26 May 2007 11:10:34 +0200
Message-Id: <1180170634.15146.0.camel@domain.hid>
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

On Fri, 2007-05-25 at 13:04 +0200, Johan Borkhuis wrote:
> Hello,
> 
> I am trying to create an RTDM interrupt handler for an external 
> interrupt. I use a rtdm_irq_request, followed by a rtdm_irq_enable. This 
> caused one interrupt to be processed, but subsequent interrupts were not 
> processed.
> After adding an extra rtdm_irq_enable to the ISR the interrupts are 
> processed. When I look at the other drivers I don't see this. Is this 
> needed, or is there a bug/feature in the interrupt handling on my platform?
> (I use a MVME3100 with a ppc8540 processor and openPIC interrupt 
> controller).
> 

Does this help?

--- arch/ppc/syslib/open_pic.c~	2006-11-17 15:55:24.000000000 +0100
+++ arch/ppc/syslib/open_pic.c	2007-05-26 11:09:03.000000000 +0200
@@ -833,7 +833,7 @@
 {
 #if defined(__SLOW_VERSION__) || defined(CONFIG_IPIPE)
 	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
-	    && irq_desc[irq_nr].action)
+	    && (!ipipe_root_domain_p || irq_desc[irq_nr].action))
 		openpic_enable_irq(irq_nr);
 #else
 	if ((irq_desc[irq_nr].status & IRQ_LEVEL) != 0)

> Kind regards,
>     Johan Borkhuis
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



