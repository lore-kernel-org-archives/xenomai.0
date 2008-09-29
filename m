From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Tue, 30 Sep 2008 00:45:49 +0200
References: <200809282321.25635.niklaus.giger@domain.hid>
In-Reply-To: <200809282321.25635.niklaus.giger@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809300045.49328.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-core] Problems using rt_intr_wait on PowerPC
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

> Based on the user_irq.c I created a simple test program for my PPC405GPr
> board.
>
> We have a FPGA which generates an interrupt every millisecond.
> It seems to work as simple test (fire it once and assure that it
> sets the interrupt-bit).
>
> When I connect it to the irq_server however (letting the main task
> sleep 1 second) I get around 2321964 error and not a single OK from
> rt_intr_wait.
> Also my debug LED flicker very fast.
> The FPGA is connected to the External Interrupt 0, which has the number 25.
>
> I think that I either got the polarity/level/edge register wrong or
> I am playing with the wrong interrupt.
>
> Could anybody tell me, whether I used the correct interrupt number?

I think you are OK on that point. Just beware that your 405GPr can work in two 
modes:
- 7 external interrupts and x GPIO lines 
- 13 external interrupts and x-6 GPIO lines
However, I think the IRQ 25 is the external interrupt 0 in both cases. That 
issue is detailed in the AMCC user manual.

> Does Linux somewhere overwrite the values for the UIC polarity/level, etc
> settings written by U-Boot (e.g. for my board in board_early_init_f)

That may be the case. Have a look at the 
header "linux/include/asm-ppc/ppc4xx_pic.h" (if you are using the old ppc 
branch). If you are using the powerpc branch, check whether the 
function "uic_set_irq_type()" is called.

For example, if you are using the sycamore eval board (and the old ppc 
branch), all the external interrupts are configured in level mode with 
negative polarity (arch/ppc/platforms/4xx/sycamore.c).

Alexis.



