Message-ID: <4AB2A308.4010508@domain.hid>
Date: Thu, 17 Sep 2009 22:58:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9aa019ba0909150827u38360ec1m7b749838ab0c54c4@domain.hid>	
	<1253116044.2676.153.camel@domain.hid>	
	<9aa019ba0909171026i51de25a7g6e0c5fd60273747@domain.hid>	
	<4AB2745E.3030106@domain.hid>
	<9aa019ba0909171345t4a2996eavc950fa4de543fd6d@domain.hid>
In-Reply-To: <9aa019ba0909171345t4a2996eavc950fa4de543fd6d@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: James Kilts <jameskilts@domain.hid>
Cc: xenomai@xenomai.org

James Kilts wrote:
>> If your PIC needs an EOI, you can define the irq_finish macro in
>> include/mach/irqs.h like the AT91, and use the level handler.
> 
> Thanks for the suggestion.  I'll give it a try when I have a moment.
> 
> 
>> Ok. I had a look at handle_prio_irq in arch/arm/mach-ns9xxx/irq.c. What
>> this irq handler does is bad, really bad. If you care about interrupt
>> latencies, you should really use handle_level_irq. That is, replace the
>> #if 0 with a #if 1.
> 
> There is a newer version of handle_prio_irq() that is very similar to
> handle_fasteoi_irq(), which is not checked into mainline Linux yet.
> And yes, the old version is quite bad.
> 
> In any case, I thought handle_prio_irq should only be called when the
> Linux domain is passed the interrupt by I-pipe.  Should I-pipe be
> calling handle_prio_irq() or handle_level_irq() even when Linux is not
> registered to receive the IRQ?

What happens is that the I-pipe acks and masks the irq in
__ipipe_handle_irq. And if it is a Linux interrupt, the Linux irq
handler is called so should not mask or ack the interrupt.

> 
> 
>> By the way: do you plan to publish your patch?
> 
> It would be desirable to have the patch published, although our
> current platform is Linux kernel version 2.6.28.9 with Xenomai 2.4.8
> and may require some work to get working on the latest branch.

Ok. Please be careful the I-pipe patch which comes with Xenomai 2.4.8
has a bug which we discovered with Xenomai 2.4.9, and was fixed with
2.4.9.1. So, you should really upgrade to 2.4.9.1. It should be
painless, since no ABI change ever take place in the same branch (2.4.x
for instance).

As for including your patch, we could include it starting with I-pipe
patch for Linux 2.6.28.

-- 
					    Gilles.

