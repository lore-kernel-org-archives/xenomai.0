Subject: Re: [Adeos-main] End of interrupt scheduling
From: Michael Neuhauser <mike@domain.hid>
In-Reply-To: <41B9A304.6060101@domain.hid>
References: <008b01c4b5dd$04d20890$7405a8c0@domain.hid>
	 <1098196627.666.9.camel@domain.hid> <1098196994.666.11.camel@domain.hid>
	 <41B974E9.7080801@domain.hid>
	 <1102682214.13152.116.camel@domain.hid>
	 <41B9A304.6060101@domain.hid>
Content-Type: text/plain
Message-Id: <1102686747.13152.134.camel@domain.hid>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 14:52:29 +0100
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

On Fri, 2004-12-10 at 14:22, Andre Tousch wrote:
> Hi,
> thanks for your reply.

I hope you don't mind when we continue this on the mailing list, other
people might also be interested in it or have something to say on these
matters.

> [...]
> 
> >Maybe I'm overlooking something, but why don't you unstall the pipeline
> >in your interrupt handler? 
>
> Adeos stalls the domain before calling its interrupt handler, and 
> unstalls the domain after the handler returns.
> This prevents reentrance on the interrupt handler.
> If I unstall the pipeline, I make the handler reentrant, while Adeos 
> assumes it is not.

As far as I know, Adeos does not make such an assumption. Take for
instance the Linux timer interrupt. It has SA_INTERRUPT set, therefore
arch/arm/kernel/irq.c:__do_irq() enables interrupts with
local_irq_enable() before calling the real handler. With Adeos this
translates to a pipe unstall inside an irq-handler. This allows *other*
interrupts to occur while the timer irq handler is running. Another
timer interrupt can't happen while the old one is handled: the timer-irq
will be unmasked *after* the handler has finished (see 
arch/arm/kernel/irq.c:do_IRQ()).

Mike
-- 
Dr. Michael Neuhauser                phone: +43 1 789 08 49 - 30
Firmix Software GmbH                   fax: +43 1 789 08 49 - 55
Vienna/Austria/Europe                      email: mike@domain.hid
Embedded Linux Development and Services    http://www.firmix.at/


