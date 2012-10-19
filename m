From: Wayne Warren <wwarren@emacinc.com>
In-Reply-To: <50749349.5070900@xenomai.org>
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>
	<506B5D6B.80005@xenomai.org> <506B5E0E.5050900@xenomai.org>
	<1349369822.3775.107.camel@ENG-09-LX.emacinc.com>
	<506DC2DA.5000105@xenomai.org> <506E9510.7090105@xenomai.org>
	<1349462858.26881.43.camel@ENG-09-LX.emacinc.com>
	<506F402A.9030102@xenomai.org>
	<1349473634.26881.221.camel@ENG-09-LX.emacinc.com>
	<506F6283.2040901@xenomai.org>
	<5afa3b9a7c7daf116f8284b4f255227e.squirrel@mail.emacinc.com>
	<506FFDDC.60104@xenomai.org>
	<1349816136.25350.426.camel@ENG-09-LX.emacinc.com>
	<50749349.5070900@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 Oct 2012 16:22:39 -0500
Message-ID: <1350681759.1282.88.camel@ENG-09-LX.emacinc.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Adeos I-Pipe patch problem on vendor-specific kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Just an update...

I currently have GDB connected to the unit using a BDI2000 JTAG
debugger.


(gdb) bt
#0  __set_irq_handler (irq=395, handle=0xc00c3424 <handle_simple_irq>, is_chained=0, name=0x0) at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/kernel/irq/chip.c:836
#1  0xc0010f04 in gpmc_init () at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/include/linux/irq.h:288
#2  0xc000beb4 in init_IRQ () at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/arch/arm/kernel/irq.c:159
#3  0xc0008b44 in start_kernel () at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/init/main.c:611
#4  0x80008034 in ?? ()

Then if I continue from here the next breakpoint I have set up is
__delay:

(gdb) bt
#0  __delay () at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/arch/arm/lib/delay.S:44
#1  0xc0482acc in panic (fmt=0xc0641d24 "\001") at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/kernel/panic.c:152
#2  0xc00800b4 in do_exit (code=11) at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/kernel/exit.c:915
#3  0xc004ed9c in die (str=0xc00c2e10 "x0\222, regs=0xc062df38, err=0) at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/arch/arm/kernel/traps.c:287
#4  0xc003f3b8 in do_DataAbort (addr=3735899941, fsr=1, regs=0xc062df38) at /home/wayne/src/linux/linux-2.6.37-3517-xenomai/arch/arm/mm/fault.c:575
#5  0xc04868ec in __dabt_svc ()
Backtrace stopped: frame did not save the PC


I don't really understand __dabt_svc, maybe it means "data abort
service" or something. I have pinpointed what seems to be the exact
instruction just prior to the entry into __dabt_svc, though it seems
like there is probably something going on behind the scenes in the
processor which is not visible from the debug unit.

I also now understand why there are no printk messages--since the
machine_init() has not been called yet, there are no UARTs registered as
a serial console. The way early_printk works is also a little more clear
to me, but I do not plan at this time to continue trying to get it to
work.

One thing I tried was to reduce GPMC_CS_NUM to 7 in
arch/arm/plat-omap/include/plat/gpmc.h (even though the AM3517 does have
8 chip selects) since it was always failing on the 8th
__set_irq_handler invocation in gpmc_init(), which I assume corresponds
to the 8th chip select. But, it still failed anyway so I guess it is
just the last GPMC interrupt that fails, maybe regardless of the number.

Wayne

> 
> There may be a trap in arch/arm/plat-omap/include/mach/serial.h: the
> constants OMAP3_UARTx_BASE are numbered starting from 1. So, if the
> hardware UART are numbered from 0, you should pass 4 instead of 3 to the
> DEBUG_LL_OMAP3 macro.
> 
> > 
> >> - the uart registers range is mapped where the code in debug-macro.S
> >> expects it?
> > 
> > Not sure how to check this, will probably have to read the tech ref
> > manual more in-depth. 
> 
> 
> No, you will have to check the code and find the place where the I/O
> mapping is done.
> 

> The idea is that printascii should work whether the MMU is enabled or
> not. If the MMU is not enabled the physical address is used directly,
> if the MMU is enabled, the virtual address is used. However, for this to
> work, a mapping, presumably static, should have been defined for the
> UART registers, still presumably somewhere in the .map_io callback for
> your board. I have to admit that I could not find where this happens for
> the omap3 based board I use, where printascii works.
> 




