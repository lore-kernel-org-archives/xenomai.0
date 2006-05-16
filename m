Date: Tue, 16 May 2006 15:57:58 +0200 (MEST)
From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-core] Strange behaviour of RTDM CAN driver
In-Reply-To: <4469CF6D.2000005@domain.hid>
Message-ID: <Pine.GSO.4.58.0605161547220.22581@domain.hid>
References: <200605161240.33036.Sebastian.Smolorz@domain.hid>
	<4469CF6D.2000005@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Hello Philippe,

on Tue, 16 May 2006, Philippe Gerum wrote:
> It would be interesting to know how Adeos is asked to deal with such
> interrupt upon receipt, e.g. does it relay it to Linux?

In the init_module routine the driver calls rtdm_irq_request() with flags
RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE.

The interrupt handler returns RTDM_IRQ_NONE if the interrupt register of
the CAN chip reports zero (which is not the case here) or RTDM_IRQ_HANDLED
if it is not zero.


> What do the
> following say? And also, which is the number of your interrupt in the
> dumps below?
>
> $ cat /proc/ipipe/Xenomai
> $ cat /proc/ipipe/Linux
> $ cat /proc/xenomai/irq

I've sent a mail to Roland Riepl who has got that strange piece of CAN
hardware and also suggested him to directly post his answer to this ML.


Sebastian

