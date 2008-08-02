Message-ID: <489451FA.2020805@domain.hid>
Date: Sat, 02 Aug 2008 14:24:26 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0804111759280.5433@domain.hid><4800B4FA.1050309@domain.hid><50879.62.235.129.158.1208014366.squirrel@domain.hid><18432.56533.343662.272421@domain.hid><Pine.LNX.4.64.0804171657380.18446@domain.hid><2ff1a98a0804170830v3b2fc392lf320f05a8c7f4e8d@domain.hid><2ff1a98a0804170846p2dddbea5k3b69dbbc57fb6761@domain.hid><480775C4.2060302@domain.hid><Pine.LNX.4.64.0804211731160.26198@domain.hid>	<480DECDA.3070204@domain.hid>	<34db01c8f42b$57a4d350$0109220a@domain.hid>
	<48940F10.9060506@domain.hid>
In-Reply-To: <48940F10.9060506@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Recurring Interrupts
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
To: Henry Bausley <hbausley@domain.hid>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Henry Bausley wrote:
>> How do I setup xenomai so that my ISR can be re-entered even if I am 
>> currently in it.
>>
> 
> Try this:
> 

The following is needed to allow the same interrupt to recurse as well.

> int your_isr(xnintr_t *intr)
> {
> 	unsigned long flags;
>

+	xnintr_enable(intr);

> 	xnlock_clear_irqon(&nklock);
> 
> 	... your code ...
> 
> 	xnlock_get_irqsave(&nklock, flags); /* must re-lock on exit */

+	return XN_ISR_HANDLED | XN_ISR_NOENABLE;
> }

> 
> We do take a per-IRQ lock internally as well, but this is a no-brainer for the
> issue at stake.
> 
> NOTE: this solution is only valid in uniprocessor mode. SMP would run into
> deadlocks; we would need to provide internal support to allow this.
> 
>> I have an external edge interrupt wired and it occurs every 250usec.  There 
>> are instances
>> when the interrupt can occur while I am currently in my ISR.
>>
>> If another interrupt occurs while I am currently in my ISR I want my ISR to 
>> be called again
>> so I can flag that the condition occurred then exit the re-entered ISR and 
>> continue executing
>> the originally called ISR.
>>
>>
>> I am using a board based off the AMCC 440EP Yosemite and a Denx Kit with 
>> 2.6.24 and Xenomai 2.4.2
>> This something I did with previously with RT Linux.  I have converted a 
>> large project from FSM RT Linux
>> to Xenomai and everything is functioning except this last item.
>>
>>
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
> 
> 


-- 
Philippe.

