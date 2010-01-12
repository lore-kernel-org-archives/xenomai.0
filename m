Message-ID: <4B4C4EF9.601@domain.hid>
Date: Tue, 12 Jan 2010 11:29:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>
	<4B4BADDD.7070900@domain.hid>
In-Reply-To: <4B4BADDD.7070900@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Viper board (ARM XScale) problems
	with	Xenomai-2.4.10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ivan Kalatchev <ivan.kalatchev@domain.hid>
Cc: Xenomai-help@domain.hid

Gilles Chanteperdrix wrote:
> Ivan Kalatchev wrote:
>> and not be part of the common code? 
> 
> handle_edge_irq is a misnomer, it should be called
> "handle_edge_irq_by_bogus_interrupt_controller"
> handle_level_irq is perfectly fine for edge irqs if the interrupt
> controller does not loose edge irqs when they are masked.
> 
> The point is that handle_edge_irq is incompatible with Xenomai. So, we
> replace handle_edge_irq with handle_level_irq in the hope that your edge
> controller is not buggy. I did not invent this, I read it on the linux
> arm kernel mailing list, and for the sake of preempt_rt, people are
> doing the same thing (only without a #ifdef) in the mainline kernel,
> they maybe even did it in 2.6.33, or it is pending for 2.6.34.
> 
> The point is: you think that everything works fine, but I really doubt
> it. Normally, with handle_edge_irq, the I-pipes receives the irq, acks
> it, does not mask it, and then go to some other business with irqs on,
> the problem is that since the interrupt handler was not run, the
> peripheral from which originates the interrupt may trigger it again, and
> then you get a lock-up. This is what the code you disabled fixes. And
> this is the only fix we have at hand for now.

Ok, I have dug the linux arm kernel mailing list archives. It turns out
that PXA, SA1100 and AT91 have buggy PICs which need absolutely
handle_edge_irq.

That said, I think that the lockup issue does not happen with any
peripheral when the interrupt controller is configured in edge mode. I
think the problem happens when a peripheral with a "level" behaviour is
plugged on a pin configured as edge.

In short, you are right, we will ask people who have the lockup issue to
call set_irq_handler(handle_level_irq) for the drivers who have the
problem. Only, the way you presented your mail made me think that your
modification was a hacker's random change rather than a fully thought
out/documented one.

-- 
					    Gilles.

