Sender: dv@domain.hid
Message-ID: <44D2E4DC.63409EBA@vollmann.ch>
Date: Fri, 04 Aug 2006 08:10:36 +0200
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
	<44CDE4C2.77465253@domain.hid>
	<17616.42011.663899.554796@domain.hid>
	<1154525585.9559.22.camel@domain.hid>
	<17616.59841.283196.201008@domain.hid>
	<1154596354.9835.28.camel@domain.hid>
	<17617.63387.138316.343123@domain.hid>
	<1154617014.5010.29.camel@domain.hid>
	<17618.12042.631648.702921@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > Fixing the I-pipe is the way to go, definitely. If I understand this
>  > correctly, the best way to handle the demux case is to implement an
>  > I-pipe variant of the demultiplexing code currently available in
>  > pxa_gpio_demux_handler(), which would be called from __ipipe_grab_irq()
>  > when processing the multiplexed interrupt channel.
>  >
>  > The I-pipe-specific demux code would then log the decoded IRQ by a call
>  > to __ipipe_handle_irq() instead of running the root handler directly
>  > (i.e. desc_handle_irq), which would in turn preserve the ability to
>  > "wire" GPIO interrupts and also handle IRQ stickiness issues.
This was also my first idea.  But after a bit of musing on that
idea, I'm not really sure that this is the best way to go.
We're talking here about more than 100 bits that have to be tested
one after the other (on PXA270, it's 116, though the actual code
checks 126 bits), and even on a fast CPU this takes some time.

So I've thought about a way to register a GPIO-IRQ into I-pipe
that gets checked directly under I-pipe, while all other GPIOs
are only checked and handled in the domain that handles the
original multiplexing IRQ.
But I have to admit that I have no idea how to implement that...

[snip]
> +++ linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-pxa/irq.c   2006-08-03 19:04:52.000000000 +0200

> +#ifdef CONFIG_IPIPE
> +void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)

> +                                       __ipipe_handle_irq(irq, regs);
Just to check:  this only marks the interrupt, but not actually
handles it, doesn't it?

 Detlef

-- 
Detlef Vollmann   vollmann engineering gmbh
Linux and C++ for Embedded Systems    http://www.vollmann.ch/
Linux for PXA270 Colibri module: http://www.vollmann.ch/en/colibri/

