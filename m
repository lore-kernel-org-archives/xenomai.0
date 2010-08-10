From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C615516.2060102@domain.hid>
References: <4C5A26C4.3050702@domain.hid>
	<4C5A631B.1040604@domain.hid>	<4C5CC360.7070707@domain.hid>
	<AANLkTikC5DvkOQDfGFWL7b8KXFYd+1OkZrQ0Gc+GzzZr@domain.hid>
	<4C60A3B8.2000603@domain.hid>
	<8A042E82-C083-4876-AFF5-6D51A291C486@domain.hid>
	<4C611708.30702@domain.hid>  <4C615516.2060102@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Aug 2010 15:41:42 +0200
Message-ID: <1281447702.1730.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Bob Feretich <bob.feretich@domain.hid>

On Tue, 2010-08-10 at 15:33 +0200, Gilles Chanteperdrix wrote:
> Bob Feretich wrote:
> >   Gunther,
> > Thank you for the information.
> > No, the my hardware interrupt line is not being shared by other devices. 
> > So I really don't want it to be considered "shared". However, my concern 
> > was on how driver IRQ request calls are handled.
> > 
> > If a driver invokes request_irq() without the SHARED flag, I would 
> > expect Linux to reject subsequent request_irq() calls for the same IRQ 
> > made by other drivers. Similarly, if the first driver invokes 
> > request_irq() with the SHARED flag, I would expect Linux to accept 
> > subsequent request_irq() calls for the same IRQ made by other drivers 
> > if-and-only-if the other requests are made with the SHARED flag.
> > 
> > My temporary fix for the problem I encountered required me to request 
> > the same IRQ from Linux via request_irq() and then from Xenomai via 
> > rtdm_irq_request(). I had expected the Xenomai request to fail. However, 
> > that expectation assumed that there are interlocks between the 
> > environments. I perceived problems in either case. If there are no 
> > interlocks, then both a real-time driver and a non-real-time driver may 
> > be loaded to service the same IRQ and be ignorant of each other. This 
> > would probably be bad.
> > 
> > If there are interlocks...
> > Then for a non-shared IRQ, the first driver to request the IRQ would 
> > receive it. All other requestors, regardless of whether they are Xenomai 
> > or Linux would be refused.
> 
> Ok. Adeos 101.
> 
> Xenomai and Linux are living in different Adeos domains, each with its
> own interrupt handlers. The domains are organized in a pipeline. When an
> interrupt is received, it goes down the pipeline until a domain accepts
> it. The domain which accepts it may choose to propagate it or not to the
> next domain. So, there is nothing wrong with registering an interrupt
> handler for each domain. However, if the Xenomai domain interrupt
> handler decides not to propagate the interrupt to the Linux domain,
> Linux will simply never receive any interrupt.
> 
> The SHARED flag applies to interrupts in the same domain, and are
> handled outside of the Adeos realm.
> 
> The timer interrupt, on the other hand, propagates the interrupt when it
> sees fit, so that Linux timer handling is called. Both solutions are
> allowed.
> 
> The reason why it is impossible to share an interrupt between two
> different drivers, unaware of each other, living in Xenomai and Linux
> domain is that it destroys the determinism. But even that can be made to
> work if we make a Xenomai domain driver for the Linux domain interrupt,
> aware of that Linux domain driver:
> https://mail.gna.org/public/xenomai-core/2008-07/msg00025.html
> 
> > For a shared IRQ, the rules get much more complex. I believe that the 
> > first driver to request the IRQ would receive it, but if the driver 
> > specified the SHARED flag sharing would restricted the environment of 
> > that first driver. Requests made from the other environment should be 
> > rejected whether or not they specify SHARED.
> > Since my temporary fix (requesting and receiving a non-shared IRQ in 
> > both the Linux and Xenomai environments) worked, if proved that there 
> > were no interlocks. Phillippe stated that this is a flaw in the current 
> > version of Xenomai.
> 
> No, you misunderstood Philippe. What is a flaw in the current version of
> Xenomai is the fact that rtdm_request_irq does not configure the GPIO
> registers to set the GPIO interrupt to edge/level triggered, rising,
> falling, etc... The fact that the same interrupt can be requested in
> Xenomai domain and in Linux domain is perfectly normal, fits in the
> Adeos architecture, and is even needed for handling the timer interrupt
> on several architectures including arm.

Ack.

> 
> 

-- 
Philippe.



