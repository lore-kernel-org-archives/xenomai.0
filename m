Message-ID: <bc4264770703090955p36674dfapfcd1ff4935059d4e@domain.hid>
Date: Fri, 9 Mar 2007 17:55:35 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
In-Reply-To: <Pine.GSO.4.64.0703091709040.16762@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<E1HPclZ-0004Yo-QD@mailer.emlix.com> <45F1425E.90604@domain.hid>
	<E1HPfGn-0003K5-RF@mailer.emlix.com>
	<bc4264770703090717u2a64c148g6000d0d64a488058@domain.hid>
	<Pine.GSO.4.64.0703091709040.16762@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: xenomai@xenomai.org, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

> >
> > What I gather is that allowing the CAN-RX interrupt handler to be
> > interruptible could lead to undesirably long delays while reading out
> > the registers which would either result in buffer overflow or/and,
> > changed register content before the previously read values are
> > written?
>
> The discussion was a little bit theoretical. This would only apply if we
> shift some code from the handler to a bottom-half thread, which would then
> be interruptible by a higher prio task. But I'm not planning to do this.
> ;-)
Ah. :(


>
> >
> > If it is also not possible to optimize the code further then IMHO  we
> > are looking at a fundamental hardware constraint.
>
> Paul already posted some calculations which make the situation rather
> clear.

I thought so too.

>
> >
> > If the latter is true then to be of any use in a RT environment, it
> > must be possible to retain more control over the message receiving in
> > at least one respect. It must be possible to either block the CAN-RX
> > interrupt or the reaction to it of the ISR. Obviously at the cost of
> > loosing messages but in some cases (like mine) loosing messages is not
> > that much of a problem. Having excessive latencies on the other hand
> > is.
>
> With every reception you get those "excessive" latencies on your hardware.
> Which one will you choose to be suppressed? A rather difficult task, I
> could imagine.
Is it? Perhaps I am being rather over optimistic but I am not
interested in position readings coming in at the end of the 1ms
period. If I could block the RX interrupt for the last 0.2ms of my
task the chances are that I would have perfectly acceptable readings.


>
> >
> > What would probably work in my case is to allow the Rx ISR to be
> > interrupted by the rt tasks in such a manner that when the ISR is
> > interrupted the ISR is exited with no values written to the the
> > sockets.
>
> This requires a conversion of the driver which is not done in five
> minutes. And whether this is the way to go remains yet questionable.

I feel that if we are facing a fundamental hardware constraint and
making the ISR interruptible is "impossible" there are not many
alternatives. I don't deny that the suggestion is a serious compromise
but there are applications where it can be used. Mine possibly being
one of them.

Regards,

Roland

>
> --
> Sebastian
>

