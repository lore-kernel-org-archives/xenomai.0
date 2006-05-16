From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Date: Tue, 16 May 2006 12:40:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605161240.33036.Sebastian.Smolorz@domain.hid>
Subject: [Xenomai-core] Strange behaviour of RTDM CAN driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hello all,

the following is a really nasty problem I am trying to solve for months now. I 
really hope that someone on the list knows the solution.

As you may remember some months ago I announced a RTDM CAN driver for SJA1000 
based cards (see 
https://mail.gna.org/public/xenomai-core/2005-11/msg00108.html). The driver 
works well with the cards at our institute. Some time ago I was asked to 
extend the driver so that it would work also with a card from another vendor 
(Advantech PCM3680). By now, the driver does its job as expected, with one 
exception: It gets stuck in the interrupt handler. The problem is that the 
interrupt register of the SJA1000 chip does not get cleared after a read 
command like it should. So the driver never knows that there is no interrupt 
anymore and therefore never leaves the interrupt handler.

After I installed a break after 20 loops inside the handler and an additional 
read of the interrupt register in the following syscall routine issued by the 
test program, I noticed that the register is cleared! So I strongly think 
that the reason for clearing this register lies in actions taken after the 
driver left the interrupt handler. But I am not very sure about this. Maybe 
there is another reason I do not see (or in the end the hardware is 
faulty ...).

Did any of you experienced a similar problem in the past? Any hint would be 
appreciated!

Interestingly, the driver does not show the above behaviour with all interrupt 
numbers. E.g. with interrupt number 12 the driver gets no interrupt at all.

Some technical details:
- Linux Kernel 2.6.16
- adeos-ipipe-2.6.16-i386-1.3-01.patch
- Xenomai 2.1.50


Sebastian

