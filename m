From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-core] Strange behaviour of RTDM CAN driver
Date: Wed, 24 May 2006 12:51:40 +0200
References: <200605161240.33036.Sebastian.Smolorz@domain.hid>
	<4469CF6D.2000005@domain.hid>
In-Reply-To: <4469CF6D.2000005@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605241251.41085.Sebastian.Smolorz@domain.hid>
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

I've got the results from Roland now.


> > Interestingly, the driver does not show the above behaviour with all
> > interrupt numbers. E.g. with interrupt number 12 the driver gets no
> > interrupt at all.

Now IRQ 12 works ...

> > Some technical details:
> > - Linux Kernel 2.6.16
> > - adeos-ipipe-2.6.16-i386-1.3-01.patch
> > - Xenomai 2.1.50
>
> It would be interesting to know how Adeos is asked to deal with such
> interrupt upon receipt, e.g. does it relay it to Linux? What do the
> following say? And also, which is the number of your interrupt in the
> dumps below?
>
> $ cat /proc/ipipe/Xenomai
> $ cat /proc/ipipe/Linux
> $ cat /proc/xenomai/irq

First, for IRQ 11:
# cat /proc/ipipe/Xenomai
Invariant head, Id=0x58454e4f
irq0-10: passed
irq11: wired
irq12-215: passed
irq216: wired
irq217-255: passed
irq256-257: passed, virtual
irq258: wired, virtual

# cat /proc/ipipe/Linux
Priority=100, Id=0x00000000
irq0-238: accepted
irq256-257: grabbed, virtual
irq258: passed, virtual

# cat /proc/xenomai/irq
IRQ         CPU0
 11:          10
216:          29
258:          20


And now, the card is assigned to IRQ12:
# cat /proc/ipipe/Xenomai
Invariant head, Id=0x58454e4f
irq0-11: passed
irq12: wired
irq13-215: passed
irq216: wired
irq217-255: passed
irq256-257: passed, virtual
irq258: wired, virtual

# cat /proc/ipipe/Linux
Priority=100, Id=0x00000000
irq0-238: accepted
irq256-257: grabbed, virtual
irq258: passed, virtual

# cat /proc/xenomai/irq
IRQ         CPU0
 12:           8
216:          33
258:          20

It should be noted that only 3 interrupts are registered by my driver.

Another phenomenon reported by Roland: His test program sends three messages 
via rt_dev_send(). After a fresh reboot, when the program sends it directly 
in a row, only the first one makes it. When he adds a printf() statement 
after each rt_dev_send() to get the return value, the program works nicely 
and sends 3 messages. And when he removes the printf() statements afterwards 
without booting freshly, the first behaviour cannot be reproduced.

Strange! I guess this behaviour has to do with the fact that no interrupts 
appear the first time. But why does they appear during the second run? Could 
it be related to the switch between primary/secondary domain and back? And 
has it to do with the problem that the interrupt register of the SJA1000 is 
not cleared?

Maybe someone can bring some light to this dark place ...


Sebastian

