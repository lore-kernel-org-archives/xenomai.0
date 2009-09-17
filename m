MIME-Version: 1.0
In-Reply-To: <4AB2745E.3030106@domain.hid>
References: <9aa019ba0909150827u38360ec1m7b749838ab0c54c4@domain.hid>
	<1253116044.2676.153.camel@domain.hid>
	<9aa019ba0909171026i51de25a7g6e0c5fd60273747@domain.hid>
	<4AB2745E.3030106@domain.hid>
Date: Thu, 17 Sep 2009 15:45:02 -0500
Message-ID: <9aa019ba0909171345t4a2996eavc950fa4de543fd6d@domain.hid>
From: James Kilts <jameskilts@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Interrupt only runs once
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> If your PIC needs an EOI, you can define the irq_finish macro in
> include/mach/irqs.h like the AT91, and use the level handler.

Thanks for the suggestion.  I'll give it a try when I have a moment.


> Ok. I had a look at handle_prio_irq in arch/arm/mach-ns9xxx/irq.c. What
> this irq handler does is bad, really bad. If you care about interrupt
> latencies, you should really use handle_level_irq. That is, replace the
> #if 0 with a #if 1.

There is a newer version of handle_prio_irq() that is very similar to
handle_fasteoi_irq(), which is not checked into mainline Linux yet.
And yes, the old version is quite bad.

In any case, I thought handle_prio_irq should only be called when the
Linux domain is passed the interrupt by I-pipe.  Should I-pipe be
calling handle_prio_irq() or handle_level_irq() even when Linux is not
registered to receive the IRQ?


> By the way: do you plan to publish your patch?

It would be desirable to have the patch published, although our
current platform is Linux kernel version 2.6.28.9 with Xenomai 2.4.8
and may require some work to get working on the latest branch.


- James

