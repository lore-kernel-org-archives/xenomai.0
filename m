Message-ID: <49DC9E5D.90404@domain.hid>
Date: Wed, 08 Apr 2009 14:53:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <37f89760904080541u4cdff5b2weec809904146cea3@domain.hid>
In-Reply-To: <37f89760904080541u4cdff5b2weec809904146cea3@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ issue :xnintr_irq_handler
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marcel Soulot <msoulot@domain.hid>
Cc: xenomai@xenomai.org

Marcel Soulot wrote:
> Hi,
> 
> I wrote a driver to manage GPIO on a PCI card. This PCI card offer UART and
> GPIO.
> So when I use my GPIO driver with the IRQ10 (automatic assignment), I get
> this error message : Xenomai: xnintr_irq_handler: IRQ10 not handled.
> Disabling IRQ line.
> I program IOCTL command which wait an event. This event is released when a
> interrupt is notified on a change state from the input.
> I get my error message when I change the state of my input and want to
> provocate a interrupt.
> 
> I've made a another test; still with the same PCI card (same IRQ 10) but
> this time I load the 16550A driver and use the uart with www.captain.at test
> on writing and reading on the same uart. Everything works fine.
> 
> Can someone can explain me why I get my error ?

You get this error because no registered real-time IRQ handler is able
to handle the IRQ, very likely because you try to share an IRQ between
real-time drivers and non real-time drivers without modifying the non
real-time drivers as explained in the FAQ.

-- 
                                                 Gilles.

