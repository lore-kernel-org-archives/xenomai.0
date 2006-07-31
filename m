Sender: dv@domain.hid
Message-ID: <44CDE4C2.77465253@domain.hid>
Date: Mon, 31 Jul 2006 13:08:50 +0200
From: Detlef Vollmann <dv@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai on PXA
References: <200607071703.10700.vagninu@domain.hid>
	<17582.50372.830923.414981@domain.hid>
	<44B34343.9F56F13@domain.hid>
	<17595.47131.142881.132531@domain.hid>
	<1153153788.11603.2.camel@domain.hid>
	<17595.49478.157044.654500@domain.hid>
	<1154334859.9569.12.camel@domain.hid>
	<44CDCB61.2DEDCBFF@vollmann.ch>
	<1154342029.9569.27.camel@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Bart Jonkers <jonkersbart@domain.hid>
Cc: xenomai@xenomai.org

Bart Jonkers wrote:
> On Mon, 2006-07-31 at 11:20 +0200, Detlef Vollmann wrote:
> > Bart Jonkers wrote:
> > > When I boot the kernel with ipipe enabled, linux receives no interrupts
> > > anymore. Any idea to solve this?
> > What are the symtomps?

> hda: lost interrupt

> Sending BOOTP requests ...... timed out!

> The interrupt for the harddisk and the network chip are GPIO interrupts.
This is what I suspected.

> > Are you sure you get no interrupts (incl. timer) or e.g. just no GPIO
> > interrupts?
> 
> I added a kernel timer to the a driver of me witch does a printk every
> 10 seconds. The printk shows up so I think that Linux still gets its
> timer interrupts.
And if you can type something on the serial console, you also
get the UART interrupt.

> I also added an interrupt handler on a button which is connected to GPIO
> pin. The interrupt handler should print something when it is executed.
> When I push the button a couple of times nothing happens. So GPIO
> interrupts doesn't seems to work.
Probably GPIO0 and GPIO1 work.
I suspect it's the cascading interrupt that doesn't work.
When I played around with an earlier version of ipipe, I found that
the IRQ_GPIO_2_80 (IRQ 10 on PXA270) is masked, but never unmasked
again.

The problem is that for the cascading interrupt you need a special
IPIPE handler, and I don't think there is currently one for PXA.

How is that done on other machines/architectures?

 Detlef

-- 
Detlef Vollmann   vollmann engineering gmbh
Linux and C++ for Embedded Systems    http://www.vollmann.ch/
Linux for PXA270 Colibri module: http://www.vollmann.ch/en/colibri/

