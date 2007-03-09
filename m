Date: Fri, 9 Mar 2007 17:37:27 +0100 (MET)
From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
In-Reply-To: <bc4264770703090717u2a64c148g6000d0d64a488058@domain.hid>
Message-ID: <Pine.GSO.4.64.0703091709040.16762@domain.hid>
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<E1HPclZ-0004Yo-QD@mailer.emlix.com> <45F1425E.90604@domain.hid>
	<E1HPfGn-0003K5-RF@mailer.emlix.com>
	<bc4264770703090717u2a64c148g6000d0d64a488058@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

On Fri, 9 Mar 2007, roland Tollenaar wrote:
>> 
>> The CAN controller receive buffer would overflow if the RX interrupt 
>> routine
>> would be interrupted and, before being finished, the controller would 
>> receive
>> more messages than its buffer can hold.
>
> What is the effect of the buffer overflow? Only messages being lost or
> are there more serious consequences? Error states of some kind?

Incoming messages which get no place in the receive buffer of the 
controller are dropped. Your sockets will receive an error frame with
CAN_ERR_CRTL_RX_OVERFLOW.

>
> What I gather is that allowing the CAN-RX interrupt handler to be
> interruptible could lead to undesirably long delays while reading out
> the registers which would either result in buffer overflow or/and,
> changed register content before the previously read values are
> written?

The discussion was a little bit theoretical. This would only apply if we 
shift some code from the handler to a bottom-half thread, which would then 
be interruptible by a higher prio task. But I'm not planning to do this.
;-)

>
> If it is also not possible to optimize the code further then IMHO  we
> are looking at a fundamental hardware constraint.

Paul already posted some calculations which make the situation rather 
clear.

>
> If the latter is true then to be of any use in a RT environment, it
> must be possible to retain more control over the message receiving in
> at least one respect. It must be possible to either block the CAN-RX
> interrupt or the reaction to it of the ISR. Obviously at the cost of
> loosing messages but in some cases (like mine) loosing messages is not
> that much of a problem. Having excessive latencies on the other hand
> is.

With every reception you get those "excessive" latencies on your hardware. 
Which one will you choose to be suppressed? A rather difficult task, I 
could imagine.

>
> What would probably work in my case is to allow the Rx ISR to be
> interrupted by the rt tasks in such a manner that when the ISR is
> interrupted the ISR is exited with no values written to the the
> sockets.

This requires a conversion of the driver which is not done in five 
minutes. And whether this is the way to go remains yet questionable.

-- 
Sebastian

