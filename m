Message-ID: <4F132A7E.4000000@domain.hid>
Date: Sun, 15 Jan 2012 20:35:26 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4F1080E8.6020408@domain.hid>
	<4F1082E5.8000501@domain.hid>
In-Reply-To: <4F1082E5.8000501@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Omap3630, rtserial, xeno_16550A: crash on insmod
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Manfred <manfred@domain.hid>
Cc: xenomai@xenomai.org

On 01/13/2012 08:15 PM, Manfred wrote:
> (In reply to Wolfgangs Respond)
> 
> Thank you for the explanations.
> So I managed to recompile the kernel module with a lot of "printk"
> 
> commands. And I could track the problem to the following:
> it fails in:[1]
> int __init rt_16550_init(void)
> 
> When calling these lines:
> rt_16550_reg_out(mode, base, IER, 0);
> DEBUGPRINT("after reg_out IER \n");
> rt_16550_reg_in(mode, base, IIR);
> DEBUGPRINT("after reg_in IIR \n");
> 
> So it seems to fail the first time when it tries to call:
> rt_16550_reg_in(mode, base, IIR);
> where
> mode=1
> rt_16550_reg_in is defined in:
> 16550A_io.h:161:
> static RT_16550_IO_INLINE u8
> rt_16550_reg_in(io_mode_t io_mode, unsigned long base, int off)
> {
>     switch (io_mode) {
>     case MODE_PIO:
>         return inb(base + off);
>     default: /* MODE_MMIO */
>         return readb((void *)base + off);
>     }
> }
> 
> --> where is MODE_PIO defined?: is it 1 or 0?
> (could not find it in any .c or .h file)

Well, it's in :

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/serial/16550A_io.h

and depends on some Kconfig options. Also another prinkt can give you
the required information.

> So anyway, it either fails in inb(base+off)
> or (more probably:) in read(void*)base+off

Yes, most likely it's an unaligned access.

> -->
> Is this consistent with your assumption that we need a regshift?

Yes. I was suggesting to put some printks in the Linux serial device
setup code first to see how the registers are accessed.

> If yes, which function calls need to be fixed?
> -->
> I tried to look in 8250.c [2]:
> regshift seems to be mostly used when using map_8250_in_reg and
> map_8250_out_reg:
> offset = map_8250_in_reg(p, offset) << p->regshift;
> offset = map_8250_in_reg(p, offset) << p->regshift;
> but also elsewhere:
> 2498 static unsigned int serial8250_port_size(struct uart_8250_port *pt)
> 2499 {
> 2500         if (pt->port.iotype == UPIO_AU)
> 2501                 return 0x1000;
> 2502 #ifdef CONFIG_ARCH_OMAP
> 2503         if (is_omap_port(pt))
> 2504                 return 0x16 << pt->port.regshift;
> 2505 #endif
> 2506         return 8 << pt->port.regshift;
> 2507 }
> or:
> 2600 static void serial8250_release_rsa_resource(struct uart_8250_port *up)
> 2601 {
> 2602         unsigned long offset = UART_RSA_BASE << up->port.regshift;
> 2603         unsigned int size = 8 << up->port.regshift;
> 2604
> 2605         switch (up->port.iotype) {
> 2606         case UPIO_HUB6:
> 2607         case UPIO_PORT:
> 2608                 release_region(up->port.iobase + offset, size);
> 2609                 break;
> 2610         }
> 2611 }

This is the driver. The devices are setup and configured in

http://lxr.linux.no/#linux+v3.2.1/arch/arm/mach-omap2/serial.c

IIRC. Check what regshift is used for your hardware (by putting further
printk's).

> -->
> So can I just change the function in 16550A.c like this?:
> rt_16550_reg_in(io_mode_t io_mode, unsigned long base, int off, int
> regshift)
> {
>      switch (io_mode) {
>     case MODE_PIO:
>         return inb(base + off);
>     default: /* MODE_MMIO */
>          /* ADD REGSHIFT for MMIO Mode: */
>          unsigned long paddr=((void*)base+off)<< regshift;
>          return readb((void *)base + off);

You need to shift just the *offset* at the beginning of the function:

	off <<= regshift;

You also need to adjust the region for request_region() or ioremap().

> }
> 
> Thanks for the help.
> Please note, this is really my first try on kernel modules and drivers,
> So sorry, in case I got it all wrong.

No problem, you are welcome.

Wolfgang.

