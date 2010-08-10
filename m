Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Guenter Ebermann <guenter.ebermann@domain.hid>
In-Reply-To: <4C60A3B8.2000603@domain.hid>
Date: Tue, 10 Aug 2010 09:43:27 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A042E82-C083-4876-AFF5-6D51A291C486@domain.hid>
References: <4C5A26C4.3050702@domain.hid>	<4C5A631B.1040604@domain.hid>	<4C5CC360.7070707@domain.hid>
	<AANLkTikC5DvkOQDfGFWL7b8KXFYd+1OkZrQ0Gc+GzzZr@domain.hid>
	<4C60A3B8.2000603@domain.hid>
Subject: Re: [Xenomai-help] RTDM driver structure - an update
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Hi Bob,

Am 10.08.2010 um 02:56 schrieb Bob Feretich:
> Do I need to mark the IRQ SHARED in the request_irq()?
> Does executing a rtdm_irq_request(), without the SHARED flag, fail if=20=

> the IRQ was reserved via request_irq()? (The purpose of the flag is =
not=20
> documented in the API manual.)
> Do I need to specify the SHARED flag in both request_irq() and=20
> rtdm_irq_request()? I'd rather not allow any other driver access to my =
IRQ.

I am relatively new to xenomai, but perhaps I can shed some light on =
shared
IRQs: Shared IRQs are used if more than one device share one interrupt =
line.
E.g.: Two PCI cards use the same interrupt line.

The cards output has high-resistance if the interrupt is disabled.  A =
external
pull-up is used. So if no interrupt is pending the voltage is high on =
the line.
The interrupt must also be level sensitive.

Whenever a interrupt occurs one card pulls down the IRQ line to ground. =
This
also works if both cards pull the IRQ down the same time (IRQ happens at =
the
same time).

Also the return value of the IRQ is important if the IRQ is shared.  The =
first
thing you have to do is check if it was your device that issued the irq =
(by
accessing some registers in your device).  If it was your device do what =
has to
be done (ack the interrupt in the device so that it doesnt pull down the =
level
to ground any more) and return IRQ_HANDLED.  If its not your return
IRQ_NO_HANDLED or such.=20

So if you write a driver for one of this two cards you must use the =
IRQ_SHARED
flag (this is the same with standard linux interrupt API - just call
request_irq with irqflags=3DIRQF_SHARED) so that linux knows that after =
it calls
your handler it must also call all other handlers of this IRQ.

However shared IRQs can be used for all kind of devices. But PCI is the =
only
example I am aware of where it really is used. It is also the root of =
alot of
problems because one must be really careful to handle such shared IRQs
correctly.

So its more likely your device does not use shared IRQs.

But perhaps in xenomai API this flag means a different thing I am not =
yet aware
of.

Kind regards,
Guenter=

